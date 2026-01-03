import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ultimate_hub/features/live_game/data/datasources/game_local_datasource.dart';
import 'package:ultimate_hub/features/live_game/data/datasources/game_remote_datasource.dart';
import 'package:ultimate_hub/features/live_game/data/datasources/play_local_datasource.dart';
import 'package:ultimate_hub/features/live_game/data/datasources/play_remote_datasource.dart';

/// Service for syncing local data to Supabase in the background
///
/// Features:
/// - Periodic sync every 30 seconds when online
/// - Automatic sync when connectivity is restored
/// - Manual sync on demand
/// - Sync status tracking (idle, syncing, error)
/// - Error handling with retry logic
class SyncService {
  final GameLocalDataSource gameLocalDataSource;
  final GameRemoteDataSource gameRemoteDataSource;
  final PlayLocalDataSource playLocalDataSource;
  final PlayRemoteDataSource playRemoteDataSource;
  final Connectivity connectivity;

  // Sync configuration
  static const Duration _syncInterval = Duration(seconds: 30);

  // Internal state
  Timer? _syncTimer;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  bool _isSyncing = false;
  SyncStatus _status = SyncStatus.idle;
  String? _lastError;
  DateTime? _lastSyncTime;

  // Stream controller for sync status updates
  final _statusController = StreamController<SyncStatus>.broadcast();

  SyncService({
    required this.gameLocalDataSource,
    required this.gameRemoteDataSource,
    required this.playLocalDataSource,
    required this.playRemoteDataSource,
    required this.connectivity,
  });

  /// Current sync status
  SyncStatus get status => _status;

  /// Last sync error message (if any)
  String? get lastError => _lastError;

  /// Last successful sync time
  DateTime? get lastSyncTime => _lastSyncTime;

  /// Stream of sync status changes
  Stream<SyncStatus> get statusStream => _statusController.stream;

  /// Start the background sync service
  ///
  /// This starts:
  /// 1. Periodic sync timer (every 30 seconds)
  /// 2. Connectivity change listener (sync when online)
  void start() {
    // Start periodic sync
    _syncTimer = Timer.periodic(_syncInterval, (_) => syncAll());

    // Listen for connectivity changes
    _connectivitySubscription = connectivity.onConnectivityChanged.listen(
      (ConnectivityResult result) {
        if (_isOnline(result) && !_isSyncing) {
          // Connection restored - trigger sync
          syncAll();
        }
      },
    );
  }

  /// Stop the background sync service
  void stop() {
    _syncTimer?.cancel();
    _syncTimer = null;
    _connectivitySubscription?.cancel();
    _connectivitySubscription = null;
  }

  /// Manually trigger a sync of all unsynced data
  ///
  /// Returns true if sync completed successfully, false otherwise
  Future<bool> syncAll() async {
    if (_isSyncing) {
      return false; // Already syncing
    }

    // Check if online
    final connectivityResult = await connectivity.checkConnectivity();
    if (!_isOnline(connectivityResult)) {
      _updateStatus(SyncStatus.offline);
      return false;
    }

    _isSyncing = true;
    _updateStatus(SyncStatus.syncing);

    try {
      // Sync games first
      final gameSyncSuccess = await _syncGames();

      // Then sync plays
      final playSyncSuccess = await _syncPlays();

      if (gameSyncSuccess && playSyncSuccess) {
        _lastSyncTime = DateTime.now();
        _lastError = null;
        _updateStatus(SyncStatus.success);
        return true;
      } else {
        _updateStatus(SyncStatus.partial);
        return false;
      }
    } catch (e) {
      _lastError = e.toString();
      _updateStatus(SyncStatus.error);
      return false;
    } finally {
      _isSyncing = false;
    }
  }

  /// Sync a specific game by ID
  Future<bool> syncGame(String gameId) async {
    final connectivityResult = await connectivity.checkConnectivity();
    if (!_isOnline(connectivityResult)) {
      return false;
    }

    try {
      final game = await gameLocalDataSource.getCachedGame(gameId);
      if (game == null || game.isSynced) {
        return true; // Nothing to sync
      }

      final remoteGame = await gameRemoteDataSource.updateGame(game);
      final syncedGame = remoteGame.copyWith(
        isSynced: true,
        lastSyncedAt: DateTime.now(),
      );
      await gameLocalDataSource.updateCachedGame(syncedGame);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Sync plays for a specific game
  Future<bool> syncPlaysForGame(String gameId) async {
    final connectivityResult = await connectivity.checkConnectivity();
    if (!_isOnline(connectivityResult)) {
      return false;
    }

    try {
      final unsyncedPlays =
          await playLocalDataSource.getUnsyncedPlaysForGame(gameId);

      if (unsyncedPlays.isEmpty) {
        return true; // Nothing to sync
      }

      for (final play in unsyncedPlays) {
        try {
          final remotePlay = await playRemoteDataSource.updatePlay(play);
          final syncedPlay = remotePlay.copyWith(
            isSynced: true,
            syncedAt: DateTime.now(),
          );
          await playLocalDataSource.updateCachedPlay(syncedPlay);
        } catch (e) {
          // Continue syncing other plays even if one fails
          continue;
        }
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get count of unsynced items
  Future<SyncStats> getUnsyncedStats() async {
    final unsyncedGames = await gameLocalDataSource.getUnsyncedGames();
    final unsyncedPlays = await playLocalDataSource.getUnsyncedPlays();

    return SyncStats(
      unsyncedGames: unsyncedGames.length,
      unsyncedPlays: unsyncedPlays.length,
    );
  }

  /// Dispose of resources
  void dispose() {
    stop();
    _statusController.close();
  }

  // =========================================================================
  // PRIVATE HELPERS
  // =========================================================================

  /// Sync all unsynced games to Supabase
  Future<bool> _syncGames() async {
    try {
      final unsyncedGames = await gameLocalDataSource.getUnsyncedGames();

      if (unsyncedGames.isEmpty) {
        return true;
      }

      int successCount = 0;
      for (final game in unsyncedGames) {
        try {
          final remoteGame = await gameRemoteDataSource.updateGame(game);
          final syncedGame = remoteGame.copyWith(
            isSynced: true,
            lastSyncedAt: DateTime.now(),
          );
          await gameLocalDataSource.updateCachedGame(syncedGame);
          successCount++;
        } catch (e) {
          // Log error but continue syncing other games
          continue;
        }
      }

      return successCount == unsyncedGames.length;
    } catch (e) {
      return false;
    }
  }

  /// Sync all unsynced plays to Supabase
  Future<bool> _syncPlays() async {
    try {
      final unsyncedPlays = await playLocalDataSource.getUnsyncedPlays();

      if (unsyncedPlays.isEmpty) {
        return true;
      }

      int successCount = 0;
      for (final play in unsyncedPlays) {
        try {
          final remotePlay = await playRemoteDataSource.updatePlay(play);
          final syncedPlay = remotePlay.copyWith(
            isSynced: true,
            syncedAt: DateTime.now(),
          );
          await playLocalDataSource.updateCachedPlay(syncedPlay);
          successCount++;
        } catch (e) {
          // Log error but continue syncing other plays
          continue;
        }
      }

      return successCount == unsyncedPlays.length;
    } catch (e) {
      return false;
    }
  }

  /// Update sync status and notify listeners
  void _updateStatus(SyncStatus newStatus) {
    _status = newStatus;
    _statusController.add(newStatus);
  }

  /// Check if device has network connectivity
  bool _isOnline(ConnectivityResult result) {
    return result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.ethernet;
  }
}

/// Sync status enum
enum SyncStatus {
  idle, // Not currently syncing
  syncing, // Sync in progress
  success, // Last sync completed successfully
  partial, // Sync completed but some items failed
  error, // Sync failed completely
  offline, // Device is offline
}

/// Statistics about unsynced items
class SyncStats {
  final int unsyncedGames;
  final int unsyncedPlays;

  SyncStats({
    required this.unsyncedGames,
    required this.unsyncedPlays,
  });

  int get totalUnsynced => unsyncedGames + unsyncedPlays;

  bool get hasUnsyncedData => totalUnsynced > 0;
}
