import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ultimate_hub/features/live_game/domain/entities/play.dart';
import 'package:ultimate_hub/core/enums/play_type.dart';

/// Abstract interface for remote play data source
///
/// Defines the contract for Supabase database operations
abstract class PlayRemoteDataSource {
  /// Create a new play in Supabase
  Future<Play> createPlay(Play play);

  /// Get a play by ID from Supabase
  Future<Play> getPlay(String playId);

  /// Get all plays for a specific game
  Future<List<Play>> getPlaysForGame(String gameId);

  /// Get all plays for a specific point
  Future<List<Play>> getPlaysForPoint(String pointId);

  /// Update an existing play in Supabase
  Future<Play> updatePlay(Play play);

  /// Delete a play from Supabase
  Future<void> deletePlay(String playId);

  /// Stream plays for a game in real-time
  /// Emits updates whenever new plays are added
  Stream<List<Play>> watchPlaysForGame(String gameId);
}

/// Implementation of PlayRemoteDataSource using Supabase
///
/// Handles camelCase (Dart) ↔ snake_case (PostgreSQL) mapping
class PlayRemoteDataSourceImpl implements PlayRemoteDataSource {
  final SupabaseClient client;

  PlayRemoteDataSourceImpl({required this.client});

  @override
  Future<Play> createPlay(Play play) async {
    final response = await client
        .from('plays')
        .insert(_playToSupabaseJson(play))
        .select()
        .single();

    return _playFromSupabaseJson(response);
  }

  @override
  Future<Play> getPlay(String playId) async {
    final response = await client
        .from('plays')
        .select()
        .eq('id', playId)
        .single();

    return _playFromSupabaseJson(response);
  }

  @override
  Future<List<Play>> getPlaysForGame(String gameId) async {
    final response = await client
        .from('plays')
        .select()
        .eq('game_id', gameId)
        .order('timestamp');

    return (response as List)
        .map((json) => _playFromSupabaseJson(json))
        .toList();
  }

  @override
  Future<List<Play>> getPlaysForPoint(String pointId) async {
    final response = await client
        .from('plays')
        .select()
        .eq('point_id', pointId)
        .order('play_number');

    return (response as List)
        .map((json) => _playFromSupabaseJson(json))
        .toList();
  }

  @override
  Future<Play> updatePlay(Play play) async {
    final response = await client
        .from('plays')
        .update(_playToSupabaseJson(play))
        .eq('id', play.id)
        .select()
        .single();

    return _playFromSupabaseJson(response);
  }

  @override
  Future<void> deletePlay(String playId) async {
    await client.from('plays').delete().eq('id', playId);
  }

  @override
  Stream<List<Play>> watchPlaysForGame(String gameId) {
    return client
        .from('plays')
        .stream(primaryKey: ['id'])
        .eq('game_id', gameId)
        .order('timestamp')
        .map((data) => data.map((json) => _playFromSupabaseJson(json)).toList());
  }

  // =========================================================================
  // MAPPING HELPERS: Dart camelCase ↔ PostgreSQL snake_case
  // =========================================================================

  /// Convert Play entity to Supabase JSON (snake_case)
  Map<String, dynamic> _playToSupabaseJson(Play play) {
    return {
      'id': play.id,
      'game_id': play.gameId,
      'point_id': play.pointId,
      'play_number': play.playNumber,
      'player_id': play.playerId,
      'player_name': play.playerName,
      'player_jersey_number': play.playerJerseyNumber,
      'team_id': play.teamId,
      'type': play.type.name,
      'notes': play.notes,
      'field_x': play.fieldX,
      'field_y': play.fieldY,
      'target_player_id': play.targetPlayerId,
      'target_player_name': play.targetPlayerName,
      'turnover_type': play.turnoverType,
      'timestamp': play.timestamp.toIso8601String(),
      'stall_count': play.stallCount,
      'is_synced': play.isSynced,
      'synced_at': play.syncedAt?.toIso8601String(),
    };
  }

  /// Convert Supabase JSON (snake_case) to Play entity
  Play _playFromSupabaseJson(Map<String, dynamic> json) {
    return Play(
      id: json['id'] as String,
      gameId: json['game_id'] as String,
      pointId: json['point_id'] as String,
      playNumber: json['play_number'] as int,
      playerId: json['player_id'] as String?,
      playerName: json['player_name'] as String?,
      playerJerseyNumber: json['player_jersey_number'] as int?,
      teamId: json['team_id'] as String,
      type: _parsePlayType(json['type'] as String),
      notes: json['notes'] as String?,
      fieldX: _parseDouble(json['field_x']),
      fieldY: _parseDouble(json['field_y']),
      targetPlayerId: json['target_player_id'] as String?,
      targetPlayerName: json['target_player_name'] as String?,
      turnoverType: json['turnover_type'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      stallCount: json['stall_count'] as int?,
      isSynced: json['is_synced'] as bool? ?? false,
      syncedAt: _parseDateTime(json['synced_at']),
    );
  }

  // =========================================================================
  // PARSING HELPERS
  // =========================================================================

  PlayType _parsePlayType(String type) {
    try {
      return PlayType.values.byName(type);
    } catch (e) {
      // Default to throw if unrecognized
      return PlayType.throwDisc;
    }
  }

  double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is String) return DateTime.parse(value);
    return null;
  }
}
