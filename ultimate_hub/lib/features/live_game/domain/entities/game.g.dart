// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameImpl _$$GameImplFromJson(Map<String, dynamic> json) => _$GameImpl(
      id: json['id'] as String,
      tournamentId: json['tournamentId'] as String?,
      poolId: json['poolId'] as String?,
      bracketPosition: json['bracketPosition'] as String?,
      homeTeamId: json['homeTeamId'] as String,
      awayTeamId: json['awayTeamId'] as String,
      homeTeamName: json['homeTeamName'] as String,
      awayTeamName: json['awayTeamName'] as String,
      homeTeamLogo: json['homeTeamLogo'] as String?,
      awayTeamLogo: json['awayTeamLogo'] as String?,
      homeScore: (json['homeScore'] as num?)?.toInt() ?? 0,
      awayScore: (json['awayScore'] as num?)?.toInt() ?? 0,
      halftimeHomeScore: (json['halftimeHomeScore'] as num?)?.toInt(),
      halftimeAwayScore: (json['halftimeAwayScore'] as num?)?.toInt(),
      gameToPoints: (json['gameToPoints'] as num?)?.toInt() ?? 15,
      originalGameToPoints: (json['originalGameToPoints'] as num?)?.toInt(),
      hardCapPoints: (json['hardCapPoints'] as num?)?.toInt() ?? 17,
      halftimeAtOverride: (json['halftimeAtOverride'] as num?)?.toInt(),
      softCapMinutes: (json['softCapMinutes'] as num?)?.toInt() ?? 75,
      hardCapMinutes: (json['hardCapMinutes'] as num?)?.toInt() ?? 90,
      status: $enumDecodeNullable(_$GameStatusEnumMap, json['status']) ??
          GameStatus.scheduled,
      currentPoint: (json['currentPoint'] as num?)?.toInt() ?? 1,
      currentPossession: json['currentPossession'] as String?,
      scheduledAt: json['scheduledAt'] == null
          ? null
          : DateTime.parse(json['scheduledAt'] as String),
      startedAt: json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      halftimeStartedAt: json['halftimeStartedAt'] == null
          ? null
          : DateTime.parse(json['halftimeStartedAt'] as String),
      softCapStartedAt: json['softCapStartedAt'] == null
          ? null
          : DateTime.parse(json['softCapStartedAt'] as String),
      hardCapStartedAt: json['hardCapStartedAt'] == null
          ? null
          : DateTime.parse(json['hardCapStartedAt'] as String),
      endedAt: json['endedAt'] == null
          ? null
          : DateTime.parse(json['endedAt'] as String),
      isDelayed: json['isDelayed'] as bool? ?? false,
      delayReason:
          $enumDecodeNullable(_$DelayReasonEnumMap, json['delayReason']),
      delayNotes: json['delayNotes'] as String?,
      delayStartedAt: json['delayStartedAt'] == null
          ? null
          : DateTime.parse(json['delayStartedAt'] as String),
      windSpeed: json['windSpeed'] as String?,
      windDirection: json['windDirection'] as String?,
      weatherNotes: json['weatherNotes'] as String?,
      gameNotes: json['gameNotes'] as String?,
      isBeingTracked: json['isBeingTracked'] as bool? ?? false,
      trackedByUserId: json['trackedByUserId'] as String?,
      trackedByUserName: json['trackedByUserName'] as String?,
      isSimpleTracking: json['isSimpleTracking'] as bool? ?? true,
      isSynced: json['isSynced'] as bool? ?? false,
      lastSyncedAt: json['lastSyncedAt'] == null
          ? null
          : DateTime.parse(json['lastSyncedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$GameImplToJson(_$GameImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tournamentId': instance.tournamentId,
      'poolId': instance.poolId,
      'bracketPosition': instance.bracketPosition,
      'homeTeamId': instance.homeTeamId,
      'awayTeamId': instance.awayTeamId,
      'homeTeamName': instance.homeTeamName,
      'awayTeamName': instance.awayTeamName,
      'homeTeamLogo': instance.homeTeamLogo,
      'awayTeamLogo': instance.awayTeamLogo,
      'homeScore': instance.homeScore,
      'awayScore': instance.awayScore,
      'halftimeHomeScore': instance.halftimeHomeScore,
      'halftimeAwayScore': instance.halftimeAwayScore,
      'gameToPoints': instance.gameToPoints,
      'originalGameToPoints': instance.originalGameToPoints,
      'hardCapPoints': instance.hardCapPoints,
      'halftimeAtOverride': instance.halftimeAtOverride,
      'softCapMinutes': instance.softCapMinutes,
      'hardCapMinutes': instance.hardCapMinutes,
      'status': _$GameStatusEnumMap[instance.status]!,
      'currentPoint': instance.currentPoint,
      'currentPossession': instance.currentPossession,
      'scheduledAt': instance.scheduledAt?.toIso8601String(),
      'startedAt': instance.startedAt?.toIso8601String(),
      'halftimeStartedAt': instance.halftimeStartedAt?.toIso8601String(),
      'softCapStartedAt': instance.softCapStartedAt?.toIso8601String(),
      'hardCapStartedAt': instance.hardCapStartedAt?.toIso8601String(),
      'endedAt': instance.endedAt?.toIso8601String(),
      'isDelayed': instance.isDelayed,
      'delayReason': _$DelayReasonEnumMap[instance.delayReason],
      'delayNotes': instance.delayNotes,
      'delayStartedAt': instance.delayStartedAt?.toIso8601String(),
      'windSpeed': instance.windSpeed,
      'windDirection': instance.windDirection,
      'weatherNotes': instance.weatherNotes,
      'gameNotes': instance.gameNotes,
      'isBeingTracked': instance.isBeingTracked,
      'trackedByUserId': instance.trackedByUserId,
      'trackedByUserName': instance.trackedByUserName,
      'isSimpleTracking': instance.isSimpleTracking,
      'isSynced': instance.isSynced,
      'lastSyncedAt': instance.lastSyncedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$GameStatusEnumMap = {
  GameStatus.scheduled: 'scheduled',
  GameStatus.warmup: 'warmup',
  GameStatus.inProgress: 'inProgress',
  GameStatus.halftime: 'halftime',
  GameStatus.softCap: 'softCap',
  GameStatus.hardCap: 'hardCap',
  GameStatus.delayed: 'delayed',
  GameStatus.completed: 'completed',
  GameStatus.cancelled: 'cancelled',
};

const _$DelayReasonEnumMap = {
  DelayReason.lightning: 'lightning',
  DelayReason.rain: 'rain',
  DelayReason.wind: 'wind',
  DelayReason.heat: 'heat',
  DelayReason.fieldConditions: 'fieldConditions',
  DelayReason.injury: 'injury',
  DelayReason.other: 'other',
};

_$QuickGameSetupImpl _$$QuickGameSetupImplFromJson(Map<String, dynamic> json) =>
    _$QuickGameSetupImpl(
      homeTeamName: json['homeTeamName'] as String,
      awayTeamName: json['awayTeamName'] as String,
      gameToPoints: (json['gameToPoints'] as num?)?.toInt() ?? 15,
      hardCapPoints: (json['hardCapPoints'] as num?)?.toInt() ?? 17,
      softCapMinutes: (json['softCapMinutes'] as num?)?.toInt() ?? 75,
      hardCapMinutes: (json['hardCapMinutes'] as num?)?.toInt() ?? 90,
      windSpeed: json['windSpeed'] as String?,
      windDirection: json['windDirection'] as String?,
    );

Map<String, dynamic> _$$QuickGameSetupImplToJson(
        _$QuickGameSetupImpl instance) =>
    <String, dynamic>{
      'homeTeamName': instance.homeTeamName,
      'awayTeamName': instance.awayTeamName,
      'gameToPoints': instance.gameToPoints,
      'hardCapPoints': instance.hardCapPoints,
      'softCapMinutes': instance.softCapMinutes,
      'hardCapMinutes': instance.hardCapMinutes,
      'windSpeed': instance.windSpeed,
      'windDirection': instance.windDirection,
    };
