// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayImpl _$$PlayImplFromJson(Map<String, dynamic> json) => _$PlayImpl(
      id: json['id'] as String,
      gameId: json['gameId'] as String,
      pointId: json['pointId'] as String,
      playNumber: (json['playNumber'] as num).toInt(),
      playerId: json['playerId'] as String?,
      playerName: json['playerName'] as String?,
      playerJerseyNumber: (json['playerJerseyNumber'] as num?)?.toInt(),
      teamId: json['teamId'] as String,
      type: $enumDecode(_$PlayTypeEnumMap, json['type']),
      notes: json['notes'] as String?,
      fieldX: (json['fieldX'] as num?)?.toDouble(),
      fieldY: (json['fieldY'] as num?)?.toDouble(),
      targetPlayerId: json['targetPlayerId'] as String?,
      targetPlayerName: json['targetPlayerName'] as String?,
      turnoverType: json['turnoverType'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      stallCount: (json['stallCount'] as num?)?.toInt(),
      isSynced: json['isSynced'] as bool? ?? false,
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
    );

Map<String, dynamic> _$$PlayImplToJson(_$PlayImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gameId': instance.gameId,
      'pointId': instance.pointId,
      'playNumber': instance.playNumber,
      'playerId': instance.playerId,
      'playerName': instance.playerName,
      'playerJerseyNumber': instance.playerJerseyNumber,
      'teamId': instance.teamId,
      'type': _$PlayTypeEnumMap[instance.type]!,
      'notes': instance.notes,
      'fieldX': instance.fieldX,
      'fieldY': instance.fieldY,
      'targetPlayerId': instance.targetPlayerId,
      'targetPlayerName': instance.targetPlayerName,
      'turnoverType': instance.turnoverType,
      'timestamp': instance.timestamp.toIso8601String(),
      'stallCount': instance.stallCount,
      'isSynced': instance.isSynced,
      'syncedAt': instance.syncedAt?.toIso8601String(),
    };

const _$PlayTypeEnumMap = {
  PlayType.pull: 'pull',
  PlayType.catch_: 'catch_',
  PlayType.throwDisc: 'throwDisc',
  PlayType.drop: 'drop',
  PlayType.throwaway: 'throwaway',
  PlayType.stall: 'stall',
  PlayType.outOfBounds: 'outOfBounds',
  PlayType.block: 'block',
  PlayType.interception: 'interception',
  PlayType.goal: 'goal',
  PlayType.callahan: 'callahan',
  PlayType.timeout: 'timeout',
  PlayType.injury: 'injury',
  PlayType.substitution: 'substitution',
};

_$GamePointImpl _$$GamePointImplFromJson(Map<String, dynamic> json) =>
    _$GamePointImpl(
      id: json['id'] as String,
      gameId: json['gameId'] as String,
      pointNumber: (json['pointNumber'] as num).toInt(),
      startingTeamId: json['startingTeamId'] as String,
      receivingTeamId: json['receivingTeamId'] as String,
      scoringTeamId: json['scoringTeamId'] as String?,
      homeLineType: $enumDecode(_$LineTypeEnumMap, json['homeLineType']),
      awayLineType: $enumDecode(_$LineTypeEnumMap, json['awayLineType']),
      homePlayersOnField: (json['homePlayersOnField'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      awayPlayersOnField: (json['awayPlayersOnField'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      totalTurnovers: (json['totalTurnovers'] as num?)?.toInt() ?? 0,
      homeTurnovers: (json['homeTurnovers'] as num?)?.toInt() ?? 0,
      awayTurnovers: (json['awayTurnovers'] as num?)?.toInt() ?? 0,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      homeScoreAtStart: (json['homeScoreAtStart'] as num).toInt(),
      awayScoreAtStart: (json['awayScoreAtStart'] as num).toInt(),
      isSynced: json['isSynced'] as bool? ?? false,
    );

Map<String, dynamic> _$$GamePointImplToJson(_$GamePointImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gameId': instance.gameId,
      'pointNumber': instance.pointNumber,
      'startingTeamId': instance.startingTeamId,
      'receivingTeamId': instance.receivingTeamId,
      'scoringTeamId': instance.scoringTeamId,
      'homeLineType': _$LineTypeEnumMap[instance.homeLineType]!,
      'awayLineType': _$LineTypeEnumMap[instance.awayLineType]!,
      'homePlayersOnField': instance.homePlayersOnField,
      'awayPlayersOnField': instance.awayPlayersOnField,
      'totalTurnovers': instance.totalTurnovers,
      'homeTurnovers': instance.homeTurnovers,
      'awayTurnovers': instance.awayTurnovers,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'homeScoreAtStart': instance.homeScoreAtStart,
      'awayScoreAtStart': instance.awayScoreAtStart,
      'isSynced': instance.isSynced,
    };

const _$LineTypeEnumMap = {
  LineType.offense: 'offense',
  LineType.defense: 'defense',
};

_$FieldPositionImpl _$$FieldPositionImplFromJson(Map<String, dynamic> json) =>
    _$FieldPositionImpl(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
    );

Map<String, dynamic> _$$FieldPositionImplToJson(_$FieldPositionImpl instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
    };
