import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ultimate_hub/features/live_game/domain/entities/game.dart';
import 'package:ultimate_hub/core/enums/game_status.dart';
import 'package:ultimate_hub/core/enums/delay_reason.dart';

/// Abstract interface for remote game data source
///
/// Defines the contract for Supabase database operations
abstract class GameRemoteDataSource {
  /// Create a new game in Supabase
  Future<Game> createGame(Game game);

  /// Get a game by ID from Supabase
  Future<Game> getGame(String gameId);

  /// Update an existing game in Supabase
  Future<Game> updateGame(Game game);

  /// Delete a game from Supabase
  Future<void> deleteGame(String gameId);

  /// Get games by tournament ID
  Future<List<Game>> getGamesByTournament(String tournamentId);

  /// Stream a game in real-time (for spectator mode)
  /// Emits updates whenever the game changes
  Stream<Game> watchGame(String gameId);
}

/// Implementation of GameRemoteDataSource using Supabase
///
/// Handles camelCase (Dart) ↔ snake_case (PostgreSQL) mapping
class GameRemoteDataSourceImpl implements GameRemoteDataSource {
  final SupabaseClient client;

  GameRemoteDataSourceImpl({required this.client});

  @override
  Future<Game> createGame(Game game) async {
    final response = await client
        .from('games')
        .insert(_gameToSupabaseJson(game))
        .select()
        .single();

    return _gameFromSupabaseJson(response);
  }

  @override
  Future<Game> getGame(String gameId) async {
    final response = await client
        .from('games')
        .select()
        .eq('id', gameId)
        .single();

    return _gameFromSupabaseJson(response);
  }

  @override
  Future<Game> updateGame(Game game) async {
    final response = await client
        .from('games')
        .update(_gameToSupabaseJson(game))
        .eq('id', game.id)
        .select()
        .single();

    return _gameFromSupabaseJson(response);
  }

  @override
  Future<void> deleteGame(String gameId) async {
    await client.from('games').delete().eq('id', gameId);
  }

  @override
  Future<List<Game>> getGamesByTournament(String tournamentId) async {
    final response = await client
        .from('games')
        .select()
        .eq('tournament_id', tournamentId)
        .order('scheduled_at');

    return (response as List)
        .map((json) => _gameFromSupabaseJson(json))
        .toList();
  }

  @override
  Stream<Game> watchGame(String gameId) {
    return client
        .from('games')
        .stream(primaryKey: ['id'])
        .eq('id', gameId)
        .map((data) => _gameFromSupabaseJson(data.first));
  }

  // =========================================================================
  // MAPPING HELPERS: Dart camelCase ↔ PostgreSQL snake_case
  // =========================================================================

  /// Convert Game entity to Supabase JSON (snake_case)
  Map<String, dynamic> _gameToSupabaseJson(Game game) {
    return {
      'id': game.id,
      'tournament_id': game.tournamentId,
      'pool_id': game.poolId,
      'bracket_position': game.bracketPosition,
      'home_team_id': game.homeTeamId,
      'away_team_id': game.awayTeamId,
      'home_team_name': game.homeTeamName,
      'away_team_name': game.awayTeamName,
      'home_team_logo': game.homeTeamLogo,
      'away_team_logo': game.awayTeamLogo,
      'home_score': game.homeScore,
      'away_score': game.awayScore,
      'game_to_points': game.gameToPoints,
      'hard_cap_points': game.hardCapPoints,
      'halftime_at': game.halftimeAt,
      'soft_cap_minutes': game.softCapMinutes,
      'hard_cap_minutes': game.hardCapMinutes,
      'status': game.status.name,
      'current_point': game.currentPoint,
      'current_possession': game.currentPossession,
      'scheduled_at': game.scheduledAt?.toIso8601String(),
      'started_at': game.startedAt?.toIso8601String(),
      'halftime_started_at': game.halftimeStartedAt?.toIso8601String(),
      'soft_cap_started_at': game.softCapStartedAt?.toIso8601String(),
      'hard_cap_started_at': game.hardCapStartedAt?.toIso8601String(),
      'ended_at': game.endedAt?.toIso8601String(),
      'is_delayed': game.isDelayed,
      'delay_reason': game.delayReason?.name,
      'delay_notes': game.delayNotes,
      'delay_started_at': game.delayStartedAt?.toIso8601String(),
      'wind_speed': game.windSpeed,
      'wind_direction': game.windDirection,
      'weather_notes': game.weatherNotes,
      'is_being_tracked': game.isBeingTracked,
      'tracked_by_user_id': game.trackedByUserId,
      'tracked_by_user_name': game.trackedByUserName,
      'is_simple_tracking': game.isSimpleTracking,
      'is_synced': game.isSynced,
      'last_synced_at': game.lastSyncedAt?.toIso8601String(),
      'created_at': game.createdAt.toIso8601String(),
      'updated_at': game.updatedAt.toIso8601String(),
    };
  }

  /// Convert Supabase JSON (snake_case) to Game entity
  Game _gameFromSupabaseJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'] as String,
      tournamentId: json['tournament_id'] as String?,
      poolId: json['pool_id'] as String?,
      bracketPosition: json['bracket_position'] as String?,
      homeTeamId: json['home_team_id'] as String,
      awayTeamId: json['away_team_id'] as String,
      homeTeamName: json['home_team_name'] as String,
      awayTeamName: json['away_team_name'] as String,
      homeTeamLogo: json['home_team_logo'] as String?,
      awayTeamLogo: json['away_team_logo'] as String?,
      homeScore: json['home_score'] as int? ?? 0,
      awayScore: json['away_score'] as int? ?? 0,
      gameToPoints: json['game_to_points'] as int? ?? 15,
      hardCapPoints: json['hard_cap_points'] as int? ?? 17,
      halftimeAt: json['halftime_at'] as int? ?? 8,
      softCapMinutes: json['soft_cap_minutes'] as int? ?? 75,
      hardCapMinutes: json['hard_cap_minutes'] as int? ?? 90,
      status: _parseGameStatus(json['status'] as String?),
      currentPoint: json['current_point'] as int? ?? 1,
      currentPossession: json['current_possession'] as String?,
      scheduledAt: _parseDateTime(json['scheduled_at']),
      startedAt: _parseDateTime(json['started_at']),
      halftimeStartedAt: _parseDateTime(json['halftime_started_at']),
      softCapStartedAt: _parseDateTime(json['soft_cap_started_at']),
      hardCapStartedAt: _parseDateTime(json['hard_cap_started_at']),
      endedAt: _parseDateTime(json['ended_at']),
      isDelayed: json['is_delayed'] as bool? ?? false,
      delayReason: _parseDelayReason(json['delay_reason'] as String?),
      delayNotes: json['delay_notes'] as String?,
      delayStartedAt: _parseDateTime(json['delay_started_at']),
      windSpeed: json['wind_speed'] as String?,
      windDirection: json['wind_direction'] as String?,
      weatherNotes: json['weather_notes'] as String?,
      isBeingTracked: json['is_being_tracked'] as bool? ?? false,
      trackedByUserId: json['tracked_by_user_id'] as String?,
      trackedByUserName: json['tracked_by_user_name'] as String?,
      isSimpleTracking: json['is_simple_tracking'] as bool? ?? true,
      isSynced: json['is_synced'] as bool? ?? false,
      lastSyncedAt: _parseDateTime(json['last_synced_at']),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  // =========================================================================
  // ENUM PARSING HELPERS
  // =========================================================================

  GameStatus _parseGameStatus(String? status) {
    if (status == null) return GameStatus.scheduled;
    try {
      return GameStatus.values.byName(status);
    } catch (e) {
      return GameStatus.scheduled;
    }
  }

  DelayReason? _parseDelayReason(String? reason) {
    if (reason == null) return null;
    try {
      return DelayReason.values.byName(reason);
    } catch (e) {
      return null;
    }
  }

  DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is String) return DateTime.parse(value);
    return null;
  }
}
