// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerImpl _$$PlayerImplFromJson(Map<String, dynamic> json) => _$PlayerImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      displayName: json['displayName'] as String,
      email: json['email'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      jerseyNumber: (json['jerseyNumber'] as num?)?.toInt(),
      primaryRole:
          $enumDecodeNullable(_$PlayerRoleEnumMap, json['primaryRole']),
      teamIds: (json['teamIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      totalGamesPlayed: (json['totalGamesPlayed'] as num?)?.toInt() ?? 0,
      totalGoals: (json['totalGoals'] as num?)?.toInt() ?? 0,
      totalAssists: (json['totalAssists'] as num?)?.toInt() ?? 0,
      totalBlocks: (json['totalBlocks'] as num?)?.toInt() ?? 0,
      totalTurnovers: (json['totalTurnovers'] as num?)?.toInt() ?? 0,
      totalDrops: (json['totalDrops'] as num?)?.toInt() ?? 0,
      totalPointsPlayed: (json['totalPointsPlayed'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$PlayerImplToJson(_$PlayerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'displayName': instance.displayName,
      'email': instance.email,
      'avatarUrl': instance.avatarUrl,
      'jerseyNumber': instance.jerseyNumber,
      'primaryRole': _$PlayerRoleEnumMap[instance.primaryRole],
      'teamIds': instance.teamIds,
      'totalGamesPlayed': instance.totalGamesPlayed,
      'totalGoals': instance.totalGoals,
      'totalAssists': instance.totalAssists,
      'totalBlocks': instance.totalBlocks,
      'totalTurnovers': instance.totalTurnovers,
      'totalDrops': instance.totalDrops,
      'totalPointsPlayed': instance.totalPointsPlayed,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$PlayerRoleEnumMap = {
  PlayerRole.handler: 'handler',
  PlayerRole.cutter: 'cutter',
  PlayerRole.hybrid: 'hybrid',
};

_$PlayerGameStatsImpl _$$PlayerGameStatsImplFromJson(
        Map<String, dynamic> json) =>
    _$PlayerGameStatsImpl(
      id: json['id'] as String,
      gameId: json['gameId'] as String,
      playerId: json['playerId'] as String,
      teamId: json['teamId'] as String,
      playerName: json['playerName'] as String?,
      jerseyNumber: (json['jerseyNumber'] as num?)?.toInt(),
      goals: (json['goals'] as num?)?.toInt() ?? 0,
      assists: (json['assists'] as num?)?.toInt() ?? 0,
      hockeyAssists: (json['hockeyAssists'] as num?)?.toInt() ?? 0,
      blocks: (json['blocks'] as num?)?.toInt() ?? 0,
      turnovers: (json['turnovers'] as num?)?.toInt() ?? 0,
      drops: (json['drops'] as num?)?.toInt() ?? 0,
      throwaways: (json['throwaways'] as num?)?.toInt() ?? 0,
      stalls: (json['stalls'] as num?)?.toInt() ?? 0,
      catches: (json['catches'] as num?)?.toInt() ?? 0,
      completedThrows: (json['completedThrows'] as num?)?.toInt() ?? 0,
      incompleteThrows: (json['incompleteThrows'] as num?)?.toInt() ?? 0,
      pointsPlayed: (json['pointsPlayed'] as num?)?.toInt() ?? 0,
      oPointsPlayed: (json['oPointsPlayed'] as num?)?.toInt() ?? 0,
      dPointsPlayed: (json['dPointsPlayed'] as num?)?.toInt() ?? 0,
      pointsWon: (json['pointsWon'] as num?)?.toInt() ?? 0,
      pointsLost: (json['pointsLost'] as num?)?.toInt() ?? 0,
      pulls: (json['pulls'] as num?)?.toInt() ?? 0,
      isSynced: json['isSynced'] as bool? ?? false,
    );

Map<String, dynamic> _$$PlayerGameStatsImplToJson(
        _$PlayerGameStatsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gameId': instance.gameId,
      'playerId': instance.playerId,
      'teamId': instance.teamId,
      'playerName': instance.playerName,
      'jerseyNumber': instance.jerseyNumber,
      'goals': instance.goals,
      'assists': instance.assists,
      'hockeyAssists': instance.hockeyAssists,
      'blocks': instance.blocks,
      'turnovers': instance.turnovers,
      'drops': instance.drops,
      'throwaways': instance.throwaways,
      'stalls': instance.stalls,
      'catches': instance.catches,
      'completedThrows': instance.completedThrows,
      'incompleteThrows': instance.incompleteThrows,
      'pointsPlayed': instance.pointsPlayed,
      'oPointsPlayed': instance.oPointsPlayed,
      'dPointsPlayed': instance.dPointsPlayed,
      'pointsWon': instance.pointsWon,
      'pointsLost': instance.pointsLost,
      'pulls': instance.pulls,
      'isSynced': instance.isSynced,
    };

_$TeamMemberImpl _$$TeamMemberImplFromJson(Map<String, dynamic> json) =>
    _$TeamMemberImpl(
      id: json['id'] as String,
      playerId: json['playerId'] as String,
      teamId: json['teamId'] as String,
      displayName: json['displayName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      jerseyNumber: (json['jerseyNumber'] as num?)?.toInt(),
      role: $enumDecodeNullable(_$TeamMemberRoleEnumMap, json['role']) ??
          TeamMemberRole.player,
      position: $enumDecodeNullable(_$PlayerRoleEnumMap, json['position']),
      isActive: json['isActive'] as bool? ?? true,
      isCaptain: json['isCaptain'] as bool? ?? false,
      joinedAt: DateTime.parse(json['joinedAt'] as String),
      leftAt: json['leftAt'] == null
          ? null
          : DateTime.parse(json['leftAt'] as String),
    );

Map<String, dynamic> _$$TeamMemberImplToJson(_$TeamMemberImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'playerId': instance.playerId,
      'teamId': instance.teamId,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'jerseyNumber': instance.jerseyNumber,
      'role': _$TeamMemberRoleEnumMap[instance.role]!,
      'position': _$PlayerRoleEnumMap[instance.position],
      'isActive': instance.isActive,
      'isCaptain': instance.isCaptain,
      'joinedAt': instance.joinedAt.toIso8601String(),
      'leftAt': instance.leftAt?.toIso8601String(),
    };

const _$TeamMemberRoleEnumMap = {
  TeamMemberRole.player: 'player',
  TeamMemberRole.captain: 'captain',
  TeamMemberRole.coach: 'coach',
  TeamMemberRole.manager: 'manager',
  TeamMemberRole.statKeeper: 'statKeeper',
};

_$GamePlayerImpl _$$GamePlayerImplFromJson(Map<String, dynamic> json) =>
    _$GamePlayerImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      jerseyNumber: (json['jerseyNumber'] as num?)?.toInt(),
      isOnField: json['isOnField'] as bool? ?? false,
      position: $enumDecodeNullable(_$PlayerRoleEnumMap, json['position']),
    );

Map<String, dynamic> _$$GamePlayerImplToJson(_$GamePlayerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'jerseyNumber': instance.jerseyNumber,
      'isOnField': instance.isOnField,
      'position': _$PlayerRoleEnumMap[instance.position],
    };
