// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Player _$PlayerFromJson(Map<String, dynamic> json) {
  return _Player.fromJson(json);
}

/// @nodoc
mixin _$Player {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError; // Auth user ID
  String get displayName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError; // Profile info
  int? get jerseyNumber => throw _privateConstructorUsedError;
  PlayerRole? get primaryRole => throw _privateConstructorUsedError;
  List<String> get teamIds =>
      throw _privateConstructorUsedError; // Teams they belong to
// Career stats (aggregated)
  int get totalGamesPlayed => throw _privateConstructorUsedError;
  int get totalGoals => throw _privateConstructorUsedError;
  int get totalAssists => throw _privateConstructorUsedError;
  int get totalBlocks => throw _privateConstructorUsedError;
  int get totalTurnovers => throw _privateConstructorUsedError;
  int get totalDrops => throw _privateConstructorUsedError;
  int get totalPointsPlayed => throw _privateConstructorUsedError; // Timestamps
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayerCopyWith<Player> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerCopyWith<$Res> {
  factory $PlayerCopyWith(Player value, $Res Function(Player) then) =
      _$PlayerCopyWithImpl<$Res, Player>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String displayName,
      String? email,
      String? avatarUrl,
      int? jerseyNumber,
      PlayerRole? primaryRole,
      List<String> teamIds,
      int totalGamesPlayed,
      int totalGoals,
      int totalAssists,
      int totalBlocks,
      int totalTurnovers,
      int totalDrops,
      int totalPointsPlayed,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$PlayerCopyWithImpl<$Res, $Val extends Player>
    implements $PlayerCopyWith<$Res> {
  _$PlayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? displayName = null,
    Object? email = freezed,
    Object? avatarUrl = freezed,
    Object? jerseyNumber = freezed,
    Object? primaryRole = freezed,
    Object? teamIds = null,
    Object? totalGamesPlayed = null,
    Object? totalGoals = null,
    Object? totalAssists = null,
    Object? totalBlocks = null,
    Object? totalTurnovers = null,
    Object? totalDrops = null,
    Object? totalPointsPlayed = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      jerseyNumber: freezed == jerseyNumber
          ? _value.jerseyNumber
          : jerseyNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      primaryRole: freezed == primaryRole
          ? _value.primaryRole
          : primaryRole // ignore: cast_nullable_to_non_nullable
              as PlayerRole?,
      teamIds: null == teamIds
          ? _value.teamIds
          : teamIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      totalGamesPlayed: null == totalGamesPlayed
          ? _value.totalGamesPlayed
          : totalGamesPlayed // ignore: cast_nullable_to_non_nullable
              as int,
      totalGoals: null == totalGoals
          ? _value.totalGoals
          : totalGoals // ignore: cast_nullable_to_non_nullable
              as int,
      totalAssists: null == totalAssists
          ? _value.totalAssists
          : totalAssists // ignore: cast_nullable_to_non_nullable
              as int,
      totalBlocks: null == totalBlocks
          ? _value.totalBlocks
          : totalBlocks // ignore: cast_nullable_to_non_nullable
              as int,
      totalTurnovers: null == totalTurnovers
          ? _value.totalTurnovers
          : totalTurnovers // ignore: cast_nullable_to_non_nullable
              as int,
      totalDrops: null == totalDrops
          ? _value.totalDrops
          : totalDrops // ignore: cast_nullable_to_non_nullable
              as int,
      totalPointsPlayed: null == totalPointsPlayed
          ? _value.totalPointsPlayed
          : totalPointsPlayed // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerImplCopyWith<$Res> implements $PlayerCopyWith<$Res> {
  factory _$$PlayerImplCopyWith(
          _$PlayerImpl value, $Res Function(_$PlayerImpl) then) =
      __$$PlayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String displayName,
      String? email,
      String? avatarUrl,
      int? jerseyNumber,
      PlayerRole? primaryRole,
      List<String> teamIds,
      int totalGamesPlayed,
      int totalGoals,
      int totalAssists,
      int totalBlocks,
      int totalTurnovers,
      int totalDrops,
      int totalPointsPlayed,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$PlayerImplCopyWithImpl<$Res>
    extends _$PlayerCopyWithImpl<$Res, _$PlayerImpl>
    implements _$$PlayerImplCopyWith<$Res> {
  __$$PlayerImplCopyWithImpl(
      _$PlayerImpl _value, $Res Function(_$PlayerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? displayName = null,
    Object? email = freezed,
    Object? avatarUrl = freezed,
    Object? jerseyNumber = freezed,
    Object? primaryRole = freezed,
    Object? teamIds = null,
    Object? totalGamesPlayed = null,
    Object? totalGoals = null,
    Object? totalAssists = null,
    Object? totalBlocks = null,
    Object? totalTurnovers = null,
    Object? totalDrops = null,
    Object? totalPointsPlayed = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$PlayerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      jerseyNumber: freezed == jerseyNumber
          ? _value.jerseyNumber
          : jerseyNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      primaryRole: freezed == primaryRole
          ? _value.primaryRole
          : primaryRole // ignore: cast_nullable_to_non_nullable
              as PlayerRole?,
      teamIds: null == teamIds
          ? _value._teamIds
          : teamIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      totalGamesPlayed: null == totalGamesPlayed
          ? _value.totalGamesPlayed
          : totalGamesPlayed // ignore: cast_nullable_to_non_nullable
              as int,
      totalGoals: null == totalGoals
          ? _value.totalGoals
          : totalGoals // ignore: cast_nullable_to_non_nullable
              as int,
      totalAssists: null == totalAssists
          ? _value.totalAssists
          : totalAssists // ignore: cast_nullable_to_non_nullable
              as int,
      totalBlocks: null == totalBlocks
          ? _value.totalBlocks
          : totalBlocks // ignore: cast_nullable_to_non_nullable
              as int,
      totalTurnovers: null == totalTurnovers
          ? _value.totalTurnovers
          : totalTurnovers // ignore: cast_nullable_to_non_nullable
              as int,
      totalDrops: null == totalDrops
          ? _value.totalDrops
          : totalDrops // ignore: cast_nullable_to_non_nullable
              as int,
      totalPointsPlayed: null == totalPointsPlayed
          ? _value.totalPointsPlayed
          : totalPointsPlayed // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerImpl implements _Player {
  const _$PlayerImpl(
      {required this.id,
      required this.userId,
      required this.displayName,
      this.email,
      this.avatarUrl,
      this.jerseyNumber,
      this.primaryRole,
      final List<String> teamIds = const [],
      this.totalGamesPlayed = 0,
      this.totalGoals = 0,
      this.totalAssists = 0,
      this.totalBlocks = 0,
      this.totalTurnovers = 0,
      this.totalDrops = 0,
      this.totalPointsPlayed = 0,
      required this.createdAt,
      this.updatedAt})
      : _teamIds = teamIds;

  factory _$PlayerImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
// Auth user ID
  @override
  final String displayName;
  @override
  final String? email;
  @override
  final String? avatarUrl;
// Profile info
  @override
  final int? jerseyNumber;
  @override
  final PlayerRole? primaryRole;
  final List<String> _teamIds;
  @override
  @JsonKey()
  List<String> get teamIds {
    if (_teamIds is EqualUnmodifiableListView) return _teamIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_teamIds);
  }

// Teams they belong to
// Career stats (aggregated)
  @override
  @JsonKey()
  final int totalGamesPlayed;
  @override
  @JsonKey()
  final int totalGoals;
  @override
  @JsonKey()
  final int totalAssists;
  @override
  @JsonKey()
  final int totalBlocks;
  @override
  @JsonKey()
  final int totalTurnovers;
  @override
  @JsonKey()
  final int totalDrops;
  @override
  @JsonKey()
  final int totalPointsPlayed;
// Timestamps
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Player(id: $id, userId: $userId, displayName: $displayName, email: $email, avatarUrl: $avatarUrl, jerseyNumber: $jerseyNumber, primaryRole: $primaryRole, teamIds: $teamIds, totalGamesPlayed: $totalGamesPlayed, totalGoals: $totalGoals, totalAssists: $totalAssists, totalBlocks: $totalBlocks, totalTurnovers: $totalTurnovers, totalDrops: $totalDrops, totalPointsPlayed: $totalPointsPlayed, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.jerseyNumber, jerseyNumber) ||
                other.jerseyNumber == jerseyNumber) &&
            (identical(other.primaryRole, primaryRole) ||
                other.primaryRole == primaryRole) &&
            const DeepCollectionEquality().equals(other._teamIds, _teamIds) &&
            (identical(other.totalGamesPlayed, totalGamesPlayed) ||
                other.totalGamesPlayed == totalGamesPlayed) &&
            (identical(other.totalGoals, totalGoals) ||
                other.totalGoals == totalGoals) &&
            (identical(other.totalAssists, totalAssists) ||
                other.totalAssists == totalAssists) &&
            (identical(other.totalBlocks, totalBlocks) ||
                other.totalBlocks == totalBlocks) &&
            (identical(other.totalTurnovers, totalTurnovers) ||
                other.totalTurnovers == totalTurnovers) &&
            (identical(other.totalDrops, totalDrops) ||
                other.totalDrops == totalDrops) &&
            (identical(other.totalPointsPlayed, totalPointsPlayed) ||
                other.totalPointsPlayed == totalPointsPlayed) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      displayName,
      email,
      avatarUrl,
      jerseyNumber,
      primaryRole,
      const DeepCollectionEquality().hash(_teamIds),
      totalGamesPlayed,
      totalGoals,
      totalAssists,
      totalBlocks,
      totalTurnovers,
      totalDrops,
      totalPointsPlayed,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerImplCopyWith<_$PlayerImpl> get copyWith =>
      __$$PlayerImplCopyWithImpl<_$PlayerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerImplToJson(
      this,
    );
  }
}

abstract class _Player implements Player {
  const factory _Player(
      {required final String id,
      required final String userId,
      required final String displayName,
      final String? email,
      final String? avatarUrl,
      final int? jerseyNumber,
      final PlayerRole? primaryRole,
      final List<String> teamIds,
      final int totalGamesPlayed,
      final int totalGoals,
      final int totalAssists,
      final int totalBlocks,
      final int totalTurnovers,
      final int totalDrops,
      final int totalPointsPlayed,
      required final DateTime createdAt,
      final DateTime? updatedAt}) = _$PlayerImpl;

  factory _Player.fromJson(Map<String, dynamic> json) = _$PlayerImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override // Auth user ID
  String get displayName;
  @override
  String? get email;
  @override
  String? get avatarUrl;
  @override // Profile info
  int? get jerseyNumber;
  @override
  PlayerRole? get primaryRole;
  @override
  List<String> get teamIds;
  @override // Teams they belong to
// Career stats (aggregated)
  int get totalGamesPlayed;
  @override
  int get totalGoals;
  @override
  int get totalAssists;
  @override
  int get totalBlocks;
  @override
  int get totalTurnovers;
  @override
  int get totalDrops;
  @override
  int get totalPointsPlayed;
  @override // Timestamps
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$PlayerImplCopyWith<_$PlayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlayerGameStats _$PlayerGameStatsFromJson(Map<String, dynamic> json) {
  return _PlayerGameStats.fromJson(json);
}

/// @nodoc
mixin _$PlayerGameStats {
  String get id => throw _privateConstructorUsedError;
  String get gameId => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError;
  String? get playerName => throw _privateConstructorUsedError;
  int? get jerseyNumber => throw _privateConstructorUsedError; // Core stats
  int get goals => throw _privateConstructorUsedError;
  int get assists => throw _privateConstructorUsedError;
  int get hockeyAssists =>
      throw _privateConstructorUsedError; // Pass before the assist
  int get blocks => throw _privateConstructorUsedError;
  int get turnovers => throw _privateConstructorUsedError;
  int get drops => throw _privateConstructorUsedError;
  int get throwaways => throw _privateConstructorUsedError;
  int get stalls => throw _privateConstructorUsedError; // Touch stats
  int get catches => throw _privateConstructorUsedError;
  int get completedThrows => throw _privateConstructorUsedError;
  int get incompleteThrows =>
      throw _privateConstructorUsedError; // Playing time
  int get pointsPlayed => throw _privateConstructorUsedError;
  int get oPointsPlayed => throw _privateConstructorUsedError;
  int get dPointsPlayed =>
      throw _privateConstructorUsedError; // Point outcomes when on field
  int get pointsWon => throw _privateConstructorUsedError;
  int get pointsLost =>
      throw _privateConstructorUsedError; // Pulls (for D-line)
  int get pulls => throw _privateConstructorUsedError; // Sync
  bool get isSynced => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayerGameStatsCopyWith<PlayerGameStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerGameStatsCopyWith<$Res> {
  factory $PlayerGameStatsCopyWith(
          PlayerGameStats value, $Res Function(PlayerGameStats) then) =
      _$PlayerGameStatsCopyWithImpl<$Res, PlayerGameStats>;
  @useResult
  $Res call(
      {String id,
      String gameId,
      String playerId,
      String teamId,
      String? playerName,
      int? jerseyNumber,
      int goals,
      int assists,
      int hockeyAssists,
      int blocks,
      int turnovers,
      int drops,
      int throwaways,
      int stalls,
      int catches,
      int completedThrows,
      int incompleteThrows,
      int pointsPlayed,
      int oPointsPlayed,
      int dPointsPlayed,
      int pointsWon,
      int pointsLost,
      int pulls,
      bool isSynced});
}

/// @nodoc
class _$PlayerGameStatsCopyWithImpl<$Res, $Val extends PlayerGameStats>
    implements $PlayerGameStatsCopyWith<$Res> {
  _$PlayerGameStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? gameId = null,
    Object? playerId = null,
    Object? teamId = null,
    Object? playerName = freezed,
    Object? jerseyNumber = freezed,
    Object? goals = null,
    Object? assists = null,
    Object? hockeyAssists = null,
    Object? blocks = null,
    Object? turnovers = null,
    Object? drops = null,
    Object? throwaways = null,
    Object? stalls = null,
    Object? catches = null,
    Object? completedThrows = null,
    Object? incompleteThrows = null,
    Object? pointsPlayed = null,
    Object? oPointsPlayed = null,
    Object? dPointsPlayed = null,
    Object? pointsWon = null,
    Object? pointsLost = null,
    Object? pulls = null,
    Object? isSynced = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      playerName: freezed == playerName
          ? _value.playerName
          : playerName // ignore: cast_nullable_to_non_nullable
              as String?,
      jerseyNumber: freezed == jerseyNumber
          ? _value.jerseyNumber
          : jerseyNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      goals: null == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as int,
      assists: null == assists
          ? _value.assists
          : assists // ignore: cast_nullable_to_non_nullable
              as int,
      hockeyAssists: null == hockeyAssists
          ? _value.hockeyAssists
          : hockeyAssists // ignore: cast_nullable_to_non_nullable
              as int,
      blocks: null == blocks
          ? _value.blocks
          : blocks // ignore: cast_nullable_to_non_nullable
              as int,
      turnovers: null == turnovers
          ? _value.turnovers
          : turnovers // ignore: cast_nullable_to_non_nullable
              as int,
      drops: null == drops
          ? _value.drops
          : drops // ignore: cast_nullable_to_non_nullable
              as int,
      throwaways: null == throwaways
          ? _value.throwaways
          : throwaways // ignore: cast_nullable_to_non_nullable
              as int,
      stalls: null == stalls
          ? _value.stalls
          : stalls // ignore: cast_nullable_to_non_nullable
              as int,
      catches: null == catches
          ? _value.catches
          : catches // ignore: cast_nullable_to_non_nullable
              as int,
      completedThrows: null == completedThrows
          ? _value.completedThrows
          : completedThrows // ignore: cast_nullable_to_non_nullable
              as int,
      incompleteThrows: null == incompleteThrows
          ? _value.incompleteThrows
          : incompleteThrows // ignore: cast_nullable_to_non_nullable
              as int,
      pointsPlayed: null == pointsPlayed
          ? _value.pointsPlayed
          : pointsPlayed // ignore: cast_nullable_to_non_nullable
              as int,
      oPointsPlayed: null == oPointsPlayed
          ? _value.oPointsPlayed
          : oPointsPlayed // ignore: cast_nullable_to_non_nullable
              as int,
      dPointsPlayed: null == dPointsPlayed
          ? _value.dPointsPlayed
          : dPointsPlayed // ignore: cast_nullable_to_non_nullable
              as int,
      pointsWon: null == pointsWon
          ? _value.pointsWon
          : pointsWon // ignore: cast_nullable_to_non_nullable
              as int,
      pointsLost: null == pointsLost
          ? _value.pointsLost
          : pointsLost // ignore: cast_nullable_to_non_nullable
              as int,
      pulls: null == pulls
          ? _value.pulls
          : pulls // ignore: cast_nullable_to_non_nullable
              as int,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerGameStatsImplCopyWith<$Res>
    implements $PlayerGameStatsCopyWith<$Res> {
  factory _$$PlayerGameStatsImplCopyWith(_$PlayerGameStatsImpl value,
          $Res Function(_$PlayerGameStatsImpl) then) =
      __$$PlayerGameStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String gameId,
      String playerId,
      String teamId,
      String? playerName,
      int? jerseyNumber,
      int goals,
      int assists,
      int hockeyAssists,
      int blocks,
      int turnovers,
      int drops,
      int throwaways,
      int stalls,
      int catches,
      int completedThrows,
      int incompleteThrows,
      int pointsPlayed,
      int oPointsPlayed,
      int dPointsPlayed,
      int pointsWon,
      int pointsLost,
      int pulls,
      bool isSynced});
}

/// @nodoc
class __$$PlayerGameStatsImplCopyWithImpl<$Res>
    extends _$PlayerGameStatsCopyWithImpl<$Res, _$PlayerGameStatsImpl>
    implements _$$PlayerGameStatsImplCopyWith<$Res> {
  __$$PlayerGameStatsImplCopyWithImpl(
      _$PlayerGameStatsImpl _value, $Res Function(_$PlayerGameStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? gameId = null,
    Object? playerId = null,
    Object? teamId = null,
    Object? playerName = freezed,
    Object? jerseyNumber = freezed,
    Object? goals = null,
    Object? assists = null,
    Object? hockeyAssists = null,
    Object? blocks = null,
    Object? turnovers = null,
    Object? drops = null,
    Object? throwaways = null,
    Object? stalls = null,
    Object? catches = null,
    Object? completedThrows = null,
    Object? incompleteThrows = null,
    Object? pointsPlayed = null,
    Object? oPointsPlayed = null,
    Object? dPointsPlayed = null,
    Object? pointsWon = null,
    Object? pointsLost = null,
    Object? pulls = null,
    Object? isSynced = null,
  }) {
    return _then(_$PlayerGameStatsImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      playerName: freezed == playerName
          ? _value.playerName
          : playerName // ignore: cast_nullable_to_non_nullable
              as String?,
      jerseyNumber: freezed == jerseyNumber
          ? _value.jerseyNumber
          : jerseyNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      goals: null == goals
          ? _value.goals
          : goals // ignore: cast_nullable_to_non_nullable
              as int,
      assists: null == assists
          ? _value.assists
          : assists // ignore: cast_nullable_to_non_nullable
              as int,
      hockeyAssists: null == hockeyAssists
          ? _value.hockeyAssists
          : hockeyAssists // ignore: cast_nullable_to_non_nullable
              as int,
      blocks: null == blocks
          ? _value.blocks
          : blocks // ignore: cast_nullable_to_non_nullable
              as int,
      turnovers: null == turnovers
          ? _value.turnovers
          : turnovers // ignore: cast_nullable_to_non_nullable
              as int,
      drops: null == drops
          ? _value.drops
          : drops // ignore: cast_nullable_to_non_nullable
              as int,
      throwaways: null == throwaways
          ? _value.throwaways
          : throwaways // ignore: cast_nullable_to_non_nullable
              as int,
      stalls: null == stalls
          ? _value.stalls
          : stalls // ignore: cast_nullable_to_non_nullable
              as int,
      catches: null == catches
          ? _value.catches
          : catches // ignore: cast_nullable_to_non_nullable
              as int,
      completedThrows: null == completedThrows
          ? _value.completedThrows
          : completedThrows // ignore: cast_nullable_to_non_nullable
              as int,
      incompleteThrows: null == incompleteThrows
          ? _value.incompleteThrows
          : incompleteThrows // ignore: cast_nullable_to_non_nullable
              as int,
      pointsPlayed: null == pointsPlayed
          ? _value.pointsPlayed
          : pointsPlayed // ignore: cast_nullable_to_non_nullable
              as int,
      oPointsPlayed: null == oPointsPlayed
          ? _value.oPointsPlayed
          : oPointsPlayed // ignore: cast_nullable_to_non_nullable
              as int,
      dPointsPlayed: null == dPointsPlayed
          ? _value.dPointsPlayed
          : dPointsPlayed // ignore: cast_nullable_to_non_nullable
              as int,
      pointsWon: null == pointsWon
          ? _value.pointsWon
          : pointsWon // ignore: cast_nullable_to_non_nullable
              as int,
      pointsLost: null == pointsLost
          ? _value.pointsLost
          : pointsLost // ignore: cast_nullable_to_non_nullable
              as int,
      pulls: null == pulls
          ? _value.pulls
          : pulls // ignore: cast_nullable_to_non_nullable
              as int,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerGameStatsImpl implements _PlayerGameStats {
  const _$PlayerGameStatsImpl(
      {required this.id,
      required this.gameId,
      required this.playerId,
      required this.teamId,
      this.playerName,
      this.jerseyNumber,
      this.goals = 0,
      this.assists = 0,
      this.hockeyAssists = 0,
      this.blocks = 0,
      this.turnovers = 0,
      this.drops = 0,
      this.throwaways = 0,
      this.stalls = 0,
      this.catches = 0,
      this.completedThrows = 0,
      this.incompleteThrows = 0,
      this.pointsPlayed = 0,
      this.oPointsPlayed = 0,
      this.dPointsPlayed = 0,
      this.pointsWon = 0,
      this.pointsLost = 0,
      this.pulls = 0,
      this.isSynced = false});

  factory _$PlayerGameStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerGameStatsImplFromJson(json);

  @override
  final String id;
  @override
  final String gameId;
  @override
  final String playerId;
  @override
  final String teamId;
  @override
  final String? playerName;
  @override
  final int? jerseyNumber;
// Core stats
  @override
  @JsonKey()
  final int goals;
  @override
  @JsonKey()
  final int assists;
  @override
  @JsonKey()
  final int hockeyAssists;
// Pass before the assist
  @override
  @JsonKey()
  final int blocks;
  @override
  @JsonKey()
  final int turnovers;
  @override
  @JsonKey()
  final int drops;
  @override
  @JsonKey()
  final int throwaways;
  @override
  @JsonKey()
  final int stalls;
// Touch stats
  @override
  @JsonKey()
  final int catches;
  @override
  @JsonKey()
  final int completedThrows;
  @override
  @JsonKey()
  final int incompleteThrows;
// Playing time
  @override
  @JsonKey()
  final int pointsPlayed;
  @override
  @JsonKey()
  final int oPointsPlayed;
  @override
  @JsonKey()
  final int dPointsPlayed;
// Point outcomes when on field
  @override
  @JsonKey()
  final int pointsWon;
  @override
  @JsonKey()
  final int pointsLost;
// Pulls (for D-line)
  @override
  @JsonKey()
  final int pulls;
// Sync
  @override
  @JsonKey()
  final bool isSynced;

  @override
  String toString() {
    return 'PlayerGameStats(id: $id, gameId: $gameId, playerId: $playerId, teamId: $teamId, playerName: $playerName, jerseyNumber: $jerseyNumber, goals: $goals, assists: $assists, hockeyAssists: $hockeyAssists, blocks: $blocks, turnovers: $turnovers, drops: $drops, throwaways: $throwaways, stalls: $stalls, catches: $catches, completedThrows: $completedThrows, incompleteThrows: $incompleteThrows, pointsPlayed: $pointsPlayed, oPointsPlayed: $oPointsPlayed, dPointsPlayed: $dPointsPlayed, pointsWon: $pointsWon, pointsLost: $pointsLost, pulls: $pulls, isSynced: $isSynced)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerGameStatsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.gameId, gameId) || other.gameId == gameId) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.playerName, playerName) ||
                other.playerName == playerName) &&
            (identical(other.jerseyNumber, jerseyNumber) ||
                other.jerseyNumber == jerseyNumber) &&
            (identical(other.goals, goals) || other.goals == goals) &&
            (identical(other.assists, assists) || other.assists == assists) &&
            (identical(other.hockeyAssists, hockeyAssists) ||
                other.hockeyAssists == hockeyAssists) &&
            (identical(other.blocks, blocks) || other.blocks == blocks) &&
            (identical(other.turnovers, turnovers) ||
                other.turnovers == turnovers) &&
            (identical(other.drops, drops) || other.drops == drops) &&
            (identical(other.throwaways, throwaways) ||
                other.throwaways == throwaways) &&
            (identical(other.stalls, stalls) || other.stalls == stalls) &&
            (identical(other.catches, catches) || other.catches == catches) &&
            (identical(other.completedThrows, completedThrows) ||
                other.completedThrows == completedThrows) &&
            (identical(other.incompleteThrows, incompleteThrows) ||
                other.incompleteThrows == incompleteThrows) &&
            (identical(other.pointsPlayed, pointsPlayed) ||
                other.pointsPlayed == pointsPlayed) &&
            (identical(other.oPointsPlayed, oPointsPlayed) ||
                other.oPointsPlayed == oPointsPlayed) &&
            (identical(other.dPointsPlayed, dPointsPlayed) ||
                other.dPointsPlayed == dPointsPlayed) &&
            (identical(other.pointsWon, pointsWon) ||
                other.pointsWon == pointsWon) &&
            (identical(other.pointsLost, pointsLost) ||
                other.pointsLost == pointsLost) &&
            (identical(other.pulls, pulls) || other.pulls == pulls) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        gameId,
        playerId,
        teamId,
        playerName,
        jerseyNumber,
        goals,
        assists,
        hockeyAssists,
        blocks,
        turnovers,
        drops,
        throwaways,
        stalls,
        catches,
        completedThrows,
        incompleteThrows,
        pointsPlayed,
        oPointsPlayed,
        dPointsPlayed,
        pointsWon,
        pointsLost,
        pulls,
        isSynced
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerGameStatsImplCopyWith<_$PlayerGameStatsImpl> get copyWith =>
      __$$PlayerGameStatsImplCopyWithImpl<_$PlayerGameStatsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerGameStatsImplToJson(
      this,
    );
  }
}

abstract class _PlayerGameStats implements PlayerGameStats {
  const factory _PlayerGameStats(
      {required final String id,
      required final String gameId,
      required final String playerId,
      required final String teamId,
      final String? playerName,
      final int? jerseyNumber,
      final int goals,
      final int assists,
      final int hockeyAssists,
      final int blocks,
      final int turnovers,
      final int drops,
      final int throwaways,
      final int stalls,
      final int catches,
      final int completedThrows,
      final int incompleteThrows,
      final int pointsPlayed,
      final int oPointsPlayed,
      final int dPointsPlayed,
      final int pointsWon,
      final int pointsLost,
      final int pulls,
      final bool isSynced}) = _$PlayerGameStatsImpl;

  factory _PlayerGameStats.fromJson(Map<String, dynamic> json) =
      _$PlayerGameStatsImpl.fromJson;

  @override
  String get id;
  @override
  String get gameId;
  @override
  String get playerId;
  @override
  String get teamId;
  @override
  String? get playerName;
  @override
  int? get jerseyNumber;
  @override // Core stats
  int get goals;
  @override
  int get assists;
  @override
  int get hockeyAssists;
  @override // Pass before the assist
  int get blocks;
  @override
  int get turnovers;
  @override
  int get drops;
  @override
  int get throwaways;
  @override
  int get stalls;
  @override // Touch stats
  int get catches;
  @override
  int get completedThrows;
  @override
  int get incompleteThrows;
  @override // Playing time
  int get pointsPlayed;
  @override
  int get oPointsPlayed;
  @override
  int get dPointsPlayed;
  @override // Point outcomes when on field
  int get pointsWon;
  @override
  int get pointsLost;
  @override // Pulls (for D-line)
  int get pulls;
  @override // Sync
  bool get isSynced;
  @override
  @JsonKey(ignore: true)
  _$$PlayerGameStatsImplCopyWith<_$PlayerGameStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TeamMember _$TeamMemberFromJson(Map<String, dynamic> json) {
  return _TeamMember.fromJson(json);
}

/// @nodoc
mixin _$TeamMember {
  String get id => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get avatarUrl =>
      throw _privateConstructorUsedError; // Team-specific info
  int? get jerseyNumber => throw _privateConstructorUsedError;
  TeamMemberRole get role => throw _privateConstructorUsedError;
  PlayerRole? get position => throw _privateConstructorUsedError; // Status
  bool get isActive => throw _privateConstructorUsedError;
  bool get isCaptain => throw _privateConstructorUsedError; // Timestamps
  DateTime get joinedAt => throw _privateConstructorUsedError;
  DateTime? get leftAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamMemberCopyWith<TeamMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamMemberCopyWith<$Res> {
  factory $TeamMemberCopyWith(
          TeamMember value, $Res Function(TeamMember) then) =
      _$TeamMemberCopyWithImpl<$Res, TeamMember>;
  @useResult
  $Res call(
      {String id,
      String playerId,
      String teamId,
      String displayName,
      String? avatarUrl,
      int? jerseyNumber,
      TeamMemberRole role,
      PlayerRole? position,
      bool isActive,
      bool isCaptain,
      DateTime joinedAt,
      DateTime? leftAt});
}

/// @nodoc
class _$TeamMemberCopyWithImpl<$Res, $Val extends TeamMember>
    implements $TeamMemberCopyWith<$Res> {
  _$TeamMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerId = null,
    Object? teamId = null,
    Object? displayName = null,
    Object? avatarUrl = freezed,
    Object? jerseyNumber = freezed,
    Object? role = null,
    Object? position = freezed,
    Object? isActive = null,
    Object? isCaptain = null,
    Object? joinedAt = null,
    Object? leftAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      jerseyNumber: freezed == jerseyNumber
          ? _value.jerseyNumber
          : jerseyNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as TeamMemberRole,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as PlayerRole?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isCaptain: null == isCaptain
          ? _value.isCaptain
          : isCaptain // ignore: cast_nullable_to_non_nullable
              as bool,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      leftAt: freezed == leftAt
          ? _value.leftAt
          : leftAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamMemberImplCopyWith<$Res>
    implements $TeamMemberCopyWith<$Res> {
  factory _$$TeamMemberImplCopyWith(
          _$TeamMemberImpl value, $Res Function(_$TeamMemberImpl) then) =
      __$$TeamMemberImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String playerId,
      String teamId,
      String displayName,
      String? avatarUrl,
      int? jerseyNumber,
      TeamMemberRole role,
      PlayerRole? position,
      bool isActive,
      bool isCaptain,
      DateTime joinedAt,
      DateTime? leftAt});
}

/// @nodoc
class __$$TeamMemberImplCopyWithImpl<$Res>
    extends _$TeamMemberCopyWithImpl<$Res, _$TeamMemberImpl>
    implements _$$TeamMemberImplCopyWith<$Res> {
  __$$TeamMemberImplCopyWithImpl(
      _$TeamMemberImpl _value, $Res Function(_$TeamMemberImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? playerId = null,
    Object? teamId = null,
    Object? displayName = null,
    Object? avatarUrl = freezed,
    Object? jerseyNumber = freezed,
    Object? role = null,
    Object? position = freezed,
    Object? isActive = null,
    Object? isCaptain = null,
    Object? joinedAt = null,
    Object? leftAt = freezed,
  }) {
    return _then(_$TeamMemberImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      jerseyNumber: freezed == jerseyNumber
          ? _value.jerseyNumber
          : jerseyNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as TeamMemberRole,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as PlayerRole?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isCaptain: null == isCaptain
          ? _value.isCaptain
          : isCaptain // ignore: cast_nullable_to_non_nullable
              as bool,
      joinedAt: null == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      leftAt: freezed == leftAt
          ? _value.leftAt
          : leftAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamMemberImpl implements _TeamMember {
  const _$TeamMemberImpl(
      {required this.id,
      required this.playerId,
      required this.teamId,
      required this.displayName,
      this.avatarUrl,
      this.jerseyNumber,
      this.role = TeamMemberRole.player,
      this.position,
      this.isActive = true,
      this.isCaptain = false,
      required this.joinedAt,
      this.leftAt});

  factory _$TeamMemberImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamMemberImplFromJson(json);

  @override
  final String id;
  @override
  final String playerId;
  @override
  final String teamId;
  @override
  final String displayName;
  @override
  final String? avatarUrl;
// Team-specific info
  @override
  final int? jerseyNumber;
  @override
  @JsonKey()
  final TeamMemberRole role;
  @override
  final PlayerRole? position;
// Status
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool isCaptain;
// Timestamps
  @override
  final DateTime joinedAt;
  @override
  final DateTime? leftAt;

  @override
  String toString() {
    return 'TeamMember(id: $id, playerId: $playerId, teamId: $teamId, displayName: $displayName, avatarUrl: $avatarUrl, jerseyNumber: $jerseyNumber, role: $role, position: $position, isActive: $isActive, isCaptain: $isCaptain, joinedAt: $joinedAt, leftAt: $leftAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamMemberImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.jerseyNumber, jerseyNumber) ||
                other.jerseyNumber == jerseyNumber) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isCaptain, isCaptain) ||
                other.isCaptain == isCaptain) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt) &&
            (identical(other.leftAt, leftAt) || other.leftAt == leftAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      playerId,
      teamId,
      displayName,
      avatarUrl,
      jerseyNumber,
      role,
      position,
      isActive,
      isCaptain,
      joinedAt,
      leftAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamMemberImplCopyWith<_$TeamMemberImpl> get copyWith =>
      __$$TeamMemberImplCopyWithImpl<_$TeamMemberImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamMemberImplToJson(
      this,
    );
  }
}

abstract class _TeamMember implements TeamMember {
  const factory _TeamMember(
      {required final String id,
      required final String playerId,
      required final String teamId,
      required final String displayName,
      final String? avatarUrl,
      final int? jerseyNumber,
      final TeamMemberRole role,
      final PlayerRole? position,
      final bool isActive,
      final bool isCaptain,
      required final DateTime joinedAt,
      final DateTime? leftAt}) = _$TeamMemberImpl;

  factory _TeamMember.fromJson(Map<String, dynamic> json) =
      _$TeamMemberImpl.fromJson;

  @override
  String get id;
  @override
  String get playerId;
  @override
  String get teamId;
  @override
  String get displayName;
  @override
  String? get avatarUrl;
  @override // Team-specific info
  int? get jerseyNumber;
  @override
  TeamMemberRole get role;
  @override
  PlayerRole? get position;
  @override // Status
  bool get isActive;
  @override
  bool get isCaptain;
  @override // Timestamps
  DateTime get joinedAt;
  @override
  DateTime? get leftAt;
  @override
  @JsonKey(ignore: true)
  _$$TeamMemberImplCopyWith<_$TeamMemberImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GamePlayer _$GamePlayerFromJson(Map<String, dynamic> json) {
  return _GamePlayer.fromJson(json);
}

/// @nodoc
mixin _$GamePlayer {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int? get jerseyNumber => throw _privateConstructorUsedError;
  bool get isOnField => throw _privateConstructorUsedError;
  PlayerRole? get position => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GamePlayerCopyWith<GamePlayer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GamePlayerCopyWith<$Res> {
  factory $GamePlayerCopyWith(
          GamePlayer value, $Res Function(GamePlayer) then) =
      _$GamePlayerCopyWithImpl<$Res, GamePlayer>;
  @useResult
  $Res call(
      {String id,
      String name,
      int? jerseyNumber,
      bool isOnField,
      PlayerRole? position});
}

/// @nodoc
class _$GamePlayerCopyWithImpl<$Res, $Val extends GamePlayer>
    implements $GamePlayerCopyWith<$Res> {
  _$GamePlayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? jerseyNumber = freezed,
    Object? isOnField = null,
    Object? position = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      jerseyNumber: freezed == jerseyNumber
          ? _value.jerseyNumber
          : jerseyNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      isOnField: null == isOnField
          ? _value.isOnField
          : isOnField // ignore: cast_nullable_to_non_nullable
              as bool,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as PlayerRole?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GamePlayerImplCopyWith<$Res>
    implements $GamePlayerCopyWith<$Res> {
  factory _$$GamePlayerImplCopyWith(
          _$GamePlayerImpl value, $Res Function(_$GamePlayerImpl) then) =
      __$$GamePlayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      int? jerseyNumber,
      bool isOnField,
      PlayerRole? position});
}

/// @nodoc
class __$$GamePlayerImplCopyWithImpl<$Res>
    extends _$GamePlayerCopyWithImpl<$Res, _$GamePlayerImpl>
    implements _$$GamePlayerImplCopyWith<$Res> {
  __$$GamePlayerImplCopyWithImpl(
      _$GamePlayerImpl _value, $Res Function(_$GamePlayerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? jerseyNumber = freezed,
    Object? isOnField = null,
    Object? position = freezed,
  }) {
    return _then(_$GamePlayerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      jerseyNumber: freezed == jerseyNumber
          ? _value.jerseyNumber
          : jerseyNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      isOnField: null == isOnField
          ? _value.isOnField
          : isOnField // ignore: cast_nullable_to_non_nullable
              as bool,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as PlayerRole?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GamePlayerImpl implements _GamePlayer {
  const _$GamePlayerImpl(
      {required this.id,
      required this.name,
      this.jerseyNumber,
      this.isOnField = false,
      this.position});

  factory _$GamePlayerImpl.fromJson(Map<String, dynamic> json) =>
      _$$GamePlayerImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int? jerseyNumber;
  @override
  @JsonKey()
  final bool isOnField;
  @override
  final PlayerRole? position;

  @override
  String toString() {
    return 'GamePlayer(id: $id, name: $name, jerseyNumber: $jerseyNumber, isOnField: $isOnField, position: $position)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GamePlayerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.jerseyNumber, jerseyNumber) ||
                other.jerseyNumber == jerseyNumber) &&
            (identical(other.isOnField, isOnField) ||
                other.isOnField == isOnField) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, jerseyNumber, isOnField, position);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GamePlayerImplCopyWith<_$GamePlayerImpl> get copyWith =>
      __$$GamePlayerImplCopyWithImpl<_$GamePlayerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GamePlayerImplToJson(
      this,
    );
  }
}

abstract class _GamePlayer implements GamePlayer {
  const factory _GamePlayer(
      {required final String id,
      required final String name,
      final int? jerseyNumber,
      final bool isOnField,
      final PlayerRole? position}) = _$GamePlayerImpl;

  factory _GamePlayer.fromJson(Map<String, dynamic> json) =
      _$GamePlayerImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int? get jerseyNumber;
  @override
  bool get isOnField;
  @override
  PlayerRole? get position;
  @override
  @JsonKey(ignore: true)
  _$$GamePlayerImplCopyWith<_$GamePlayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
