// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeamImpl _$$TeamImplFromJson(Map<String, dynamic> json) => _$TeamImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      abbreviation: json['abbreviation'] as String?,
      logoUrl: json['logoUrl'] as String?,
      division: $enumDecode(_$DivisionEnumMap, json['division']),
      type: $enumDecodeNullable(_$TeamTypeEnumMap, json['type']),
      city: json['city'] as String?,
      state: json['state'] as String?,
      region: json['region'] as String?,
      primaryColor: json['primaryColor'] as String?,
      secondaryColor: json['secondaryColor'] as String?,
      captainUserId: json['captainUserId'] as String?,
      managerUserIds: (json['managerUserIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      roster: (json['roster'] as List<dynamic>?)
              ?.map((e) => TeamMember.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      wins: (json['wins'] as num?)?.toInt() ?? 0,
      losses: (json['losses'] as num?)?.toInt() ?? 0,
      ties: (json['ties'] as num?)?.toInt() ?? 0,
      pointsScored: (json['pointsScored'] as num?)?.toInt() ?? 0,
      pointsAllowed: (json['pointsAllowed'] as num?)?.toInt() ?? 0,
      isPublic: json['isPublic'] as bool? ?? false,
      inviteCode: json['inviteCode'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$TeamImplToJson(_$TeamImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'abbreviation': instance.abbreviation,
      'logoUrl': instance.logoUrl,
      'division': _$DivisionEnumMap[instance.division]!,
      'type': _$TeamTypeEnumMap[instance.type],
      'city': instance.city,
      'state': instance.state,
      'region': instance.region,
      'primaryColor': instance.primaryColor,
      'secondaryColor': instance.secondaryColor,
      'captainUserId': instance.captainUserId,
      'managerUserIds': instance.managerUserIds,
      'roster': instance.roster,
      'wins': instance.wins,
      'losses': instance.losses,
      'ties': instance.ties,
      'pointsScored': instance.pointsScored,
      'pointsAllowed': instance.pointsAllowed,
      'isPublic': instance.isPublic,
      'inviteCode': instance.inviteCode,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$DivisionEnumMap = {
  Division.open: 'open',
  Division.womens: 'womens',
  Division.mixed: 'mixed',
};

const _$TeamTypeEnumMap = {
  TeamType.university: 'university',
  TeamType.club: 'club',
  TeamType.masters: 'masters',
  TeamType.grandMasters: 'grandMasters',
  TeamType.youth: 'youth',
  TeamType.pickup: 'pickup',
};

_$TeamGameStatsImpl _$$TeamGameStatsImplFromJson(Map<String, dynamic> json) =>
    _$TeamGameStatsImpl(
      gameId: json['gameId'] as String,
      teamId: json['teamId'] as String,
      score: (json['score'] as num?)?.toInt() ?? 0,
      oPointsPlayed: (json['oPointsPlayed'] as num?)?.toInt() ?? 0,
      oPointsScored: (json['oPointsScored'] as num?)?.toInt() ?? 0,
      dPointsPlayed: (json['dPointsPlayed'] as num?)?.toInt() ?? 0,
      dPointsScored: (json['dPointsScored'] as num?)?.toInt() ?? 0,
      cleanHolds: (json['cleanHolds'] as num?)?.toInt() ?? 0,
      turnovers: (json['turnovers'] as num?)?.toInt() ?? 0,
      turnoversForced: (json['turnoversForced'] as num?)?.toInt() ?? 0,
      totalPossessions: (json['totalPossessions'] as num?)?.toInt() ?? 0,
      scoringPossessions: (json['scoringPossessions'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$TeamGameStatsImplToJson(_$TeamGameStatsImpl instance) =>
    <String, dynamic>{
      'gameId': instance.gameId,
      'teamId': instance.teamId,
      'score': instance.score,
      'oPointsPlayed': instance.oPointsPlayed,
      'oPointsScored': instance.oPointsScored,
      'dPointsPlayed': instance.dPointsPlayed,
      'dPointsScored': instance.dPointsScored,
      'cleanHolds': instance.cleanHolds,
      'turnovers': instance.turnovers,
      'turnoversForced': instance.turnoversForced,
      'totalPossessions': instance.totalPossessions,
      'scoringPossessions': instance.scoringPossessions,
    };

_$GameTeamImpl _$$GameTeamImplFromJson(Map<String, dynamic> json) =>
    _$GameTeamImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      abbreviation: json['abbreviation'] as String?,
      logoUrl: json['logoUrl'] as String?,
      primaryColor: json['primaryColor'] as String?,
      players: (json['players'] as List<dynamic>?)
              ?.map((e) => GamePlayer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$GameTeamImplToJson(_$GameTeamImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'abbreviation': instance.abbreviation,
      'logoUrl': instance.logoUrl,
      'primaryColor': instance.primaryColor,
      'players': instance.players,
    };
