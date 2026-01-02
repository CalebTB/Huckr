// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Team _$TeamFromJson(Map<String, dynamic> json) {
  return _Team.fromJson(json);
}

/// @nodoc
mixin _$Team {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get abbreviation =>
      throw _privateConstructorUsedError; // e.g., "RIN" for Ring of Fire
  String? get logoUrl => throw _privateConstructorUsedError; // Team info
  Division get division => throw _privateConstructorUsedError;
  TeamType? get type => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get region => throw _privateConstructorUsedError; // Colors (for UI)
  String? get primaryColor => throw _privateConstructorUsedError; // Hex color
  String? get secondaryColor =>
      throw _privateConstructorUsedError; // Leadership
  String? get captainUserId => throw _privateConstructorUsedError;
  List<String> get managerUserIds =>
      throw _privateConstructorUsedError; // Roster
  List<TeamMember> get roster =>
      throw _privateConstructorUsedError; // Season stats
  int get wins => throw _privateConstructorUsedError;
  int get losses => throw _privateConstructorUsedError;
  int get ties => throw _privateConstructorUsedError;
  int get pointsScored => throw _privateConstructorUsedError;
  int get pointsAllowed => throw _privateConstructorUsedError; // Settings
  bool get isPublic =>
      throw _privateConstructorUsedError; // Can be found in search
  String? get inviteCode =>
      throw _privateConstructorUsedError; // For private teams
// Timestamps
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamCopyWith<Team> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamCopyWith<$Res> {
  factory $TeamCopyWith(Team value, $Res Function(Team) then) =
      _$TeamCopyWithImpl<$Res, Team>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? abbreviation,
      String? logoUrl,
      Division division,
      TeamType? type,
      String? city,
      String? state,
      String? region,
      String? primaryColor,
      String? secondaryColor,
      String? captainUserId,
      List<String> managerUserIds,
      List<TeamMember> roster,
      int wins,
      int losses,
      int ties,
      int pointsScored,
      int pointsAllowed,
      bool isPublic,
      String? inviteCode,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$TeamCopyWithImpl<$Res, $Val extends Team>
    implements $TeamCopyWith<$Res> {
  _$TeamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? abbreviation = freezed,
    Object? logoUrl = freezed,
    Object? division = null,
    Object? type = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? region = freezed,
    Object? primaryColor = freezed,
    Object? secondaryColor = freezed,
    Object? captainUserId = freezed,
    Object? managerUserIds = null,
    Object? roster = null,
    Object? wins = null,
    Object? losses = null,
    Object? ties = null,
    Object? pointsScored = null,
    Object? pointsAllowed = null,
    Object? isPublic = null,
    Object? inviteCode = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
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
      abbreviation: freezed == abbreviation
          ? _value.abbreviation
          : abbreviation // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      division: null == division
          ? _value.division
          : division // ignore: cast_nullable_to_non_nullable
              as Division,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TeamType?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryColor: freezed == primaryColor
          ? _value.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as String?,
      secondaryColor: freezed == secondaryColor
          ? _value.secondaryColor
          : secondaryColor // ignore: cast_nullable_to_non_nullable
              as String?,
      captainUserId: freezed == captainUserId
          ? _value.captainUserId
          : captainUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      managerUserIds: null == managerUserIds
          ? _value.managerUserIds
          : managerUserIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      roster: null == roster
          ? _value.roster
          : roster // ignore: cast_nullable_to_non_nullable
              as List<TeamMember>,
      wins: null == wins
          ? _value.wins
          : wins // ignore: cast_nullable_to_non_nullable
              as int,
      losses: null == losses
          ? _value.losses
          : losses // ignore: cast_nullable_to_non_nullable
              as int,
      ties: null == ties
          ? _value.ties
          : ties // ignore: cast_nullable_to_non_nullable
              as int,
      pointsScored: null == pointsScored
          ? _value.pointsScored
          : pointsScored // ignore: cast_nullable_to_non_nullable
              as int,
      pointsAllowed: null == pointsAllowed
          ? _value.pointsAllowed
          : pointsAllowed // ignore: cast_nullable_to_non_nullable
              as int,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      inviteCode: freezed == inviteCode
          ? _value.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$TeamImplCopyWith<$Res> implements $TeamCopyWith<$Res> {
  factory _$$TeamImplCopyWith(
          _$TeamImpl value, $Res Function(_$TeamImpl) then) =
      __$$TeamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? abbreviation,
      String? logoUrl,
      Division division,
      TeamType? type,
      String? city,
      String? state,
      String? region,
      String? primaryColor,
      String? secondaryColor,
      String? captainUserId,
      List<String> managerUserIds,
      List<TeamMember> roster,
      int wins,
      int losses,
      int ties,
      int pointsScored,
      int pointsAllowed,
      bool isPublic,
      String? inviteCode,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$TeamImplCopyWithImpl<$Res>
    extends _$TeamCopyWithImpl<$Res, _$TeamImpl>
    implements _$$TeamImplCopyWith<$Res> {
  __$$TeamImplCopyWithImpl(_$TeamImpl _value, $Res Function(_$TeamImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? abbreviation = freezed,
    Object? logoUrl = freezed,
    Object? division = null,
    Object? type = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? region = freezed,
    Object? primaryColor = freezed,
    Object? secondaryColor = freezed,
    Object? captainUserId = freezed,
    Object? managerUserIds = null,
    Object? roster = null,
    Object? wins = null,
    Object? losses = null,
    Object? ties = null,
    Object? pointsScored = null,
    Object? pointsAllowed = null,
    Object? isPublic = null,
    Object? inviteCode = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$TeamImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      abbreviation: freezed == abbreviation
          ? _value.abbreviation
          : abbreviation // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      division: null == division
          ? _value.division
          : division // ignore: cast_nullable_to_non_nullable
              as Division,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TeamType?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      region: freezed == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryColor: freezed == primaryColor
          ? _value.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as String?,
      secondaryColor: freezed == secondaryColor
          ? _value.secondaryColor
          : secondaryColor // ignore: cast_nullable_to_non_nullable
              as String?,
      captainUserId: freezed == captainUserId
          ? _value.captainUserId
          : captainUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      managerUserIds: null == managerUserIds
          ? _value._managerUserIds
          : managerUserIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      roster: null == roster
          ? _value._roster
          : roster // ignore: cast_nullable_to_non_nullable
              as List<TeamMember>,
      wins: null == wins
          ? _value.wins
          : wins // ignore: cast_nullable_to_non_nullable
              as int,
      losses: null == losses
          ? _value.losses
          : losses // ignore: cast_nullable_to_non_nullable
              as int,
      ties: null == ties
          ? _value.ties
          : ties // ignore: cast_nullable_to_non_nullable
              as int,
      pointsScored: null == pointsScored
          ? _value.pointsScored
          : pointsScored // ignore: cast_nullable_to_non_nullable
              as int,
      pointsAllowed: null == pointsAllowed
          ? _value.pointsAllowed
          : pointsAllowed // ignore: cast_nullable_to_non_nullable
              as int,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      inviteCode: freezed == inviteCode
          ? _value.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$TeamImpl implements _Team {
  const _$TeamImpl(
      {required this.id,
      required this.name,
      this.abbreviation,
      this.logoUrl,
      required this.division,
      this.type,
      this.city,
      this.state,
      this.region,
      this.primaryColor,
      this.secondaryColor,
      this.captainUserId,
      final List<String> managerUserIds = const [],
      final List<TeamMember> roster = const [],
      this.wins = 0,
      this.losses = 0,
      this.ties = 0,
      this.pointsScored = 0,
      this.pointsAllowed = 0,
      this.isPublic = false,
      this.inviteCode,
      required this.createdAt,
      this.updatedAt})
      : _managerUserIds = managerUserIds,
        _roster = roster;

  factory _$TeamImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? abbreviation;
// e.g., "RIN" for Ring of Fire
  @override
  final String? logoUrl;
// Team info
  @override
  final Division division;
  @override
  final TeamType? type;
  @override
  final String? city;
  @override
  final String? state;
  @override
  final String? region;
// Colors (for UI)
  @override
  final String? primaryColor;
// Hex color
  @override
  final String? secondaryColor;
// Leadership
  @override
  final String? captainUserId;
  final List<String> _managerUserIds;
  @override
  @JsonKey()
  List<String> get managerUserIds {
    if (_managerUserIds is EqualUnmodifiableListView) return _managerUserIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_managerUserIds);
  }

// Roster
  final List<TeamMember> _roster;
// Roster
  @override
  @JsonKey()
  List<TeamMember> get roster {
    if (_roster is EqualUnmodifiableListView) return _roster;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roster);
  }

// Season stats
  @override
  @JsonKey()
  final int wins;
  @override
  @JsonKey()
  final int losses;
  @override
  @JsonKey()
  final int ties;
  @override
  @JsonKey()
  final int pointsScored;
  @override
  @JsonKey()
  final int pointsAllowed;
// Settings
  @override
  @JsonKey()
  final bool isPublic;
// Can be found in search
  @override
  final String? inviteCode;
// For private teams
// Timestamps
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Team(id: $id, name: $name, abbreviation: $abbreviation, logoUrl: $logoUrl, division: $division, type: $type, city: $city, state: $state, region: $region, primaryColor: $primaryColor, secondaryColor: $secondaryColor, captainUserId: $captainUserId, managerUserIds: $managerUserIds, roster: $roster, wins: $wins, losses: $losses, ties: $ties, pointsScored: $pointsScored, pointsAllowed: $pointsAllowed, isPublic: $isPublic, inviteCode: $inviteCode, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.abbreviation, abbreviation) ||
                other.abbreviation == abbreviation) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.division, division) ||
                other.division == division) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.region, region) || other.region == region) &&
            (identical(other.primaryColor, primaryColor) ||
                other.primaryColor == primaryColor) &&
            (identical(other.secondaryColor, secondaryColor) ||
                other.secondaryColor == secondaryColor) &&
            (identical(other.captainUserId, captainUserId) ||
                other.captainUserId == captainUserId) &&
            const DeepCollectionEquality()
                .equals(other._managerUserIds, _managerUserIds) &&
            const DeepCollectionEquality().equals(other._roster, _roster) &&
            (identical(other.wins, wins) || other.wins == wins) &&
            (identical(other.losses, losses) || other.losses == losses) &&
            (identical(other.ties, ties) || other.ties == ties) &&
            (identical(other.pointsScored, pointsScored) ||
                other.pointsScored == pointsScored) &&
            (identical(other.pointsAllowed, pointsAllowed) ||
                other.pointsAllowed == pointsAllowed) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.inviteCode, inviteCode) ||
                other.inviteCode == inviteCode) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        abbreviation,
        logoUrl,
        division,
        type,
        city,
        state,
        region,
        primaryColor,
        secondaryColor,
        captainUserId,
        const DeepCollectionEquality().hash(_managerUserIds),
        const DeepCollectionEquality().hash(_roster),
        wins,
        losses,
        ties,
        pointsScored,
        pointsAllowed,
        isPublic,
        inviteCode,
        createdAt,
        updatedAt
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamImplCopyWith<_$TeamImpl> get copyWith =>
      __$$TeamImplCopyWithImpl<_$TeamImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamImplToJson(
      this,
    );
  }
}

abstract class _Team implements Team {
  const factory _Team(
      {required final String id,
      required final String name,
      final String? abbreviation,
      final String? logoUrl,
      required final Division division,
      final TeamType? type,
      final String? city,
      final String? state,
      final String? region,
      final String? primaryColor,
      final String? secondaryColor,
      final String? captainUserId,
      final List<String> managerUserIds,
      final List<TeamMember> roster,
      final int wins,
      final int losses,
      final int ties,
      final int pointsScored,
      final int pointsAllowed,
      final bool isPublic,
      final String? inviteCode,
      required final DateTime createdAt,
      final DateTime? updatedAt}) = _$TeamImpl;

  factory _Team.fromJson(Map<String, dynamic> json) = _$TeamImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get abbreviation;
  @override // e.g., "RIN" for Ring of Fire
  String? get logoUrl;
  @override // Team info
  Division get division;
  @override
  TeamType? get type;
  @override
  String? get city;
  @override
  String? get state;
  @override
  String? get region;
  @override // Colors (for UI)
  String? get primaryColor;
  @override // Hex color
  String? get secondaryColor;
  @override // Leadership
  String? get captainUserId;
  @override
  List<String> get managerUserIds;
  @override // Roster
  List<TeamMember> get roster;
  @override // Season stats
  int get wins;
  @override
  int get losses;
  @override
  int get ties;
  @override
  int get pointsScored;
  @override
  int get pointsAllowed;
  @override // Settings
  bool get isPublic;
  @override // Can be found in search
  String? get inviteCode;
  @override // For private teams
// Timestamps
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$TeamImplCopyWith<_$TeamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TeamGameStats _$TeamGameStatsFromJson(Map<String, dynamic> json) {
  return _TeamGameStats.fromJson(json);
}

/// @nodoc
mixin _$TeamGameStats {
  String get gameId => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError; // Score
  int get score => throw _privateConstructorUsedError; // Point stats
  int get oPointsPlayed => throw _privateConstructorUsedError;
  int get oPointsScored => throw _privateConstructorUsedError;
  int get dPointsPlayed => throw _privateConstructorUsedError;
  int get dPointsScored => throw _privateConstructorUsedError; // Breaks
// Clean points (scored without turning over)
  int get cleanHolds => throw _privateConstructorUsedError; // Turnover stats
  int get turnovers => throw _privateConstructorUsedError;
  int get turnoversForced => throw _privateConstructorUsedError; // Blocks/Ds
// Efficiency metrics
  int get totalPossessions => throw _privateConstructorUsedError;
  int get scoringPossessions => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamGameStatsCopyWith<TeamGameStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamGameStatsCopyWith<$Res> {
  factory $TeamGameStatsCopyWith(
          TeamGameStats value, $Res Function(TeamGameStats) then) =
      _$TeamGameStatsCopyWithImpl<$Res, TeamGameStats>;
  @useResult
  $Res call(
      {String gameId,
      String teamId,
      int score,
      int oPointsPlayed,
      int oPointsScored,
      int dPointsPlayed,
      int dPointsScored,
      int cleanHolds,
      int turnovers,
      int turnoversForced,
      int totalPossessions,
      int scoringPossessions});
}

/// @nodoc
class _$TeamGameStatsCopyWithImpl<$Res, $Val extends TeamGameStats>
    implements $TeamGameStatsCopyWith<$Res> {
  _$TeamGameStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameId = null,
    Object? teamId = null,
    Object? score = null,
    Object? oPointsPlayed = null,
    Object? oPointsScored = null,
    Object? dPointsPlayed = null,
    Object? dPointsScored = null,
    Object? cleanHolds = null,
    Object? turnovers = null,
    Object? turnoversForced = null,
    Object? totalPossessions = null,
    Object? scoringPossessions = null,
  }) {
    return _then(_value.copyWith(
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      oPointsPlayed: null == oPointsPlayed
          ? _value.oPointsPlayed
          : oPointsPlayed // ignore: cast_nullable_to_non_nullable
              as int,
      oPointsScored: null == oPointsScored
          ? _value.oPointsScored
          : oPointsScored // ignore: cast_nullable_to_non_nullable
              as int,
      dPointsPlayed: null == dPointsPlayed
          ? _value.dPointsPlayed
          : dPointsPlayed // ignore: cast_nullable_to_non_nullable
              as int,
      dPointsScored: null == dPointsScored
          ? _value.dPointsScored
          : dPointsScored // ignore: cast_nullable_to_non_nullable
              as int,
      cleanHolds: null == cleanHolds
          ? _value.cleanHolds
          : cleanHolds // ignore: cast_nullable_to_non_nullable
              as int,
      turnovers: null == turnovers
          ? _value.turnovers
          : turnovers // ignore: cast_nullable_to_non_nullable
              as int,
      turnoversForced: null == turnoversForced
          ? _value.turnoversForced
          : turnoversForced // ignore: cast_nullable_to_non_nullable
              as int,
      totalPossessions: null == totalPossessions
          ? _value.totalPossessions
          : totalPossessions // ignore: cast_nullable_to_non_nullable
              as int,
      scoringPossessions: null == scoringPossessions
          ? _value.scoringPossessions
          : scoringPossessions // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamGameStatsImplCopyWith<$Res>
    implements $TeamGameStatsCopyWith<$Res> {
  factory _$$TeamGameStatsImplCopyWith(
          _$TeamGameStatsImpl value, $Res Function(_$TeamGameStatsImpl) then) =
      __$$TeamGameStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String gameId,
      String teamId,
      int score,
      int oPointsPlayed,
      int oPointsScored,
      int dPointsPlayed,
      int dPointsScored,
      int cleanHolds,
      int turnovers,
      int turnoversForced,
      int totalPossessions,
      int scoringPossessions});
}

/// @nodoc
class __$$TeamGameStatsImplCopyWithImpl<$Res>
    extends _$TeamGameStatsCopyWithImpl<$Res, _$TeamGameStatsImpl>
    implements _$$TeamGameStatsImplCopyWith<$Res> {
  __$$TeamGameStatsImplCopyWithImpl(
      _$TeamGameStatsImpl _value, $Res Function(_$TeamGameStatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? gameId = null,
    Object? teamId = null,
    Object? score = null,
    Object? oPointsPlayed = null,
    Object? oPointsScored = null,
    Object? dPointsPlayed = null,
    Object? dPointsScored = null,
    Object? cleanHolds = null,
    Object? turnovers = null,
    Object? turnoversForced = null,
    Object? totalPossessions = null,
    Object? scoringPossessions = null,
  }) {
    return _then(_$TeamGameStatsImpl(
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      oPointsPlayed: null == oPointsPlayed
          ? _value.oPointsPlayed
          : oPointsPlayed // ignore: cast_nullable_to_non_nullable
              as int,
      oPointsScored: null == oPointsScored
          ? _value.oPointsScored
          : oPointsScored // ignore: cast_nullable_to_non_nullable
              as int,
      dPointsPlayed: null == dPointsPlayed
          ? _value.dPointsPlayed
          : dPointsPlayed // ignore: cast_nullable_to_non_nullable
              as int,
      dPointsScored: null == dPointsScored
          ? _value.dPointsScored
          : dPointsScored // ignore: cast_nullable_to_non_nullable
              as int,
      cleanHolds: null == cleanHolds
          ? _value.cleanHolds
          : cleanHolds // ignore: cast_nullable_to_non_nullable
              as int,
      turnovers: null == turnovers
          ? _value.turnovers
          : turnovers // ignore: cast_nullable_to_non_nullable
              as int,
      turnoversForced: null == turnoversForced
          ? _value.turnoversForced
          : turnoversForced // ignore: cast_nullable_to_non_nullable
              as int,
      totalPossessions: null == totalPossessions
          ? _value.totalPossessions
          : totalPossessions // ignore: cast_nullable_to_non_nullable
              as int,
      scoringPossessions: null == scoringPossessions
          ? _value.scoringPossessions
          : scoringPossessions // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamGameStatsImpl implements _TeamGameStats {
  const _$TeamGameStatsImpl(
      {required this.gameId,
      required this.teamId,
      this.score = 0,
      this.oPointsPlayed = 0,
      this.oPointsScored = 0,
      this.dPointsPlayed = 0,
      this.dPointsScored = 0,
      this.cleanHolds = 0,
      this.turnovers = 0,
      this.turnoversForced = 0,
      this.totalPossessions = 0,
      this.scoringPossessions = 0});

  factory _$TeamGameStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamGameStatsImplFromJson(json);

  @override
  final String gameId;
  @override
  final String teamId;
// Score
  @override
  @JsonKey()
  final int score;
// Point stats
  @override
  @JsonKey()
  final int oPointsPlayed;
  @override
  @JsonKey()
  final int oPointsScored;
  @override
  @JsonKey()
  final int dPointsPlayed;
  @override
  @JsonKey()
  final int dPointsScored;
// Breaks
// Clean points (scored without turning over)
  @override
  @JsonKey()
  final int cleanHolds;
// Turnover stats
  @override
  @JsonKey()
  final int turnovers;
  @override
  @JsonKey()
  final int turnoversForced;
// Blocks/Ds
// Efficiency metrics
  @override
  @JsonKey()
  final int totalPossessions;
  @override
  @JsonKey()
  final int scoringPossessions;

  @override
  String toString() {
    return 'TeamGameStats(gameId: $gameId, teamId: $teamId, score: $score, oPointsPlayed: $oPointsPlayed, oPointsScored: $oPointsScored, dPointsPlayed: $dPointsPlayed, dPointsScored: $dPointsScored, cleanHolds: $cleanHolds, turnovers: $turnovers, turnoversForced: $turnoversForced, totalPossessions: $totalPossessions, scoringPossessions: $scoringPossessions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamGameStatsImpl &&
            (identical(other.gameId, gameId) || other.gameId == gameId) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.oPointsPlayed, oPointsPlayed) ||
                other.oPointsPlayed == oPointsPlayed) &&
            (identical(other.oPointsScored, oPointsScored) ||
                other.oPointsScored == oPointsScored) &&
            (identical(other.dPointsPlayed, dPointsPlayed) ||
                other.dPointsPlayed == dPointsPlayed) &&
            (identical(other.dPointsScored, dPointsScored) ||
                other.dPointsScored == dPointsScored) &&
            (identical(other.cleanHolds, cleanHolds) ||
                other.cleanHolds == cleanHolds) &&
            (identical(other.turnovers, turnovers) ||
                other.turnovers == turnovers) &&
            (identical(other.turnoversForced, turnoversForced) ||
                other.turnoversForced == turnoversForced) &&
            (identical(other.totalPossessions, totalPossessions) ||
                other.totalPossessions == totalPossessions) &&
            (identical(other.scoringPossessions, scoringPossessions) ||
                other.scoringPossessions == scoringPossessions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      gameId,
      teamId,
      score,
      oPointsPlayed,
      oPointsScored,
      dPointsPlayed,
      dPointsScored,
      cleanHolds,
      turnovers,
      turnoversForced,
      totalPossessions,
      scoringPossessions);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamGameStatsImplCopyWith<_$TeamGameStatsImpl> get copyWith =>
      __$$TeamGameStatsImplCopyWithImpl<_$TeamGameStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamGameStatsImplToJson(
      this,
    );
  }
}

abstract class _TeamGameStats implements TeamGameStats {
  const factory _TeamGameStats(
      {required final String gameId,
      required final String teamId,
      final int score,
      final int oPointsPlayed,
      final int oPointsScored,
      final int dPointsPlayed,
      final int dPointsScored,
      final int cleanHolds,
      final int turnovers,
      final int turnoversForced,
      final int totalPossessions,
      final int scoringPossessions}) = _$TeamGameStatsImpl;

  factory _TeamGameStats.fromJson(Map<String, dynamic> json) =
      _$TeamGameStatsImpl.fromJson;

  @override
  String get gameId;
  @override
  String get teamId;
  @override // Score
  int get score;
  @override // Point stats
  int get oPointsPlayed;
  @override
  int get oPointsScored;
  @override
  int get dPointsPlayed;
  @override
  int get dPointsScored;
  @override // Breaks
// Clean points (scored without turning over)
  int get cleanHolds;
  @override // Turnover stats
  int get turnovers;
  @override
  int get turnoversForced;
  @override // Blocks/Ds
// Efficiency metrics
  int get totalPossessions;
  @override
  int get scoringPossessions;
  @override
  @JsonKey(ignore: true)
  _$$TeamGameStatsImplCopyWith<_$TeamGameStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GameTeam _$GameTeamFromJson(Map<String, dynamic> json) {
  return _GameTeam.fromJson(json);
}

/// @nodoc
mixin _$GameTeam {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get abbreviation => throw _privateConstructorUsedError;
  String? get logoUrl => throw _privateConstructorUsedError;
  String? get primaryColor => throw _privateConstructorUsedError;
  List<GamePlayer> get players => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameTeamCopyWith<GameTeam> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameTeamCopyWith<$Res> {
  factory $GameTeamCopyWith(GameTeam value, $Res Function(GameTeam) then) =
      _$GameTeamCopyWithImpl<$Res, GameTeam>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? abbreviation,
      String? logoUrl,
      String? primaryColor,
      List<GamePlayer> players});
}

/// @nodoc
class _$GameTeamCopyWithImpl<$Res, $Val extends GameTeam>
    implements $GameTeamCopyWith<$Res> {
  _$GameTeamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? abbreviation = freezed,
    Object? logoUrl = freezed,
    Object? primaryColor = freezed,
    Object? players = null,
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
      abbreviation: freezed == abbreviation
          ? _value.abbreviation
          : abbreviation // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryColor: freezed == primaryColor
          ? _value.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as String?,
      players: null == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<GamePlayer>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameTeamImplCopyWith<$Res>
    implements $GameTeamCopyWith<$Res> {
  factory _$$GameTeamImplCopyWith(
          _$GameTeamImpl value, $Res Function(_$GameTeamImpl) then) =
      __$$GameTeamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? abbreviation,
      String? logoUrl,
      String? primaryColor,
      List<GamePlayer> players});
}

/// @nodoc
class __$$GameTeamImplCopyWithImpl<$Res>
    extends _$GameTeamCopyWithImpl<$Res, _$GameTeamImpl>
    implements _$$GameTeamImplCopyWith<$Res> {
  __$$GameTeamImplCopyWithImpl(
      _$GameTeamImpl _value, $Res Function(_$GameTeamImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? abbreviation = freezed,
    Object? logoUrl = freezed,
    Object? primaryColor = freezed,
    Object? players = null,
  }) {
    return _then(_$GameTeamImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      abbreviation: freezed == abbreviation
          ? _value.abbreviation
          : abbreviation // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryColor: freezed == primaryColor
          ? _value.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as String?,
      players: null == players
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<GamePlayer>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameTeamImpl implements _GameTeam {
  const _$GameTeamImpl(
      {required this.id,
      required this.name,
      this.abbreviation,
      this.logoUrl,
      this.primaryColor,
      final List<GamePlayer> players = const []})
      : _players = players;

  factory _$GameTeamImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameTeamImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? abbreviation;
  @override
  final String? logoUrl;
  @override
  final String? primaryColor;
  final List<GamePlayer> _players;
  @override
  @JsonKey()
  List<GamePlayer> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  @override
  String toString() {
    return 'GameTeam(id: $id, name: $name, abbreviation: $abbreviation, logoUrl: $logoUrl, primaryColor: $primaryColor, players: $players)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameTeamImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.abbreviation, abbreviation) ||
                other.abbreviation == abbreviation) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.primaryColor, primaryColor) ||
                other.primaryColor == primaryColor) &&
            const DeepCollectionEquality().equals(other._players, _players));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, abbreviation, logoUrl,
      primaryColor, const DeepCollectionEquality().hash(_players));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameTeamImplCopyWith<_$GameTeamImpl> get copyWith =>
      __$$GameTeamImplCopyWithImpl<_$GameTeamImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameTeamImplToJson(
      this,
    );
  }
}

abstract class _GameTeam implements GameTeam {
  const factory _GameTeam(
      {required final String id,
      required final String name,
      final String? abbreviation,
      final String? logoUrl,
      final String? primaryColor,
      final List<GamePlayer> players}) = _$GameTeamImpl;

  factory _GameTeam.fromJson(Map<String, dynamic> json) =
      _$GameTeamImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get abbreviation;
  @override
  String? get logoUrl;
  @override
  String? get primaryColor;
  @override
  List<GamePlayer> get players;
  @override
  @JsonKey(ignore: true)
  _$$GameTeamImplCopyWith<_$GameTeamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
