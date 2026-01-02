// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'play.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Play _$PlayFromJson(Map<String, dynamic> json) {
  return _Play.fromJson(json);
}

/// @nodoc
mixin _$Play {
  String get id => throw _privateConstructorUsedError;
  String get gameId => throw _privateConstructorUsedError;
  String get pointId => throw _privateConstructorUsedError;
  int get playNumber =>
      throw _privateConstructorUsedError; // Sequential within the point
// Player info
  String? get playerId => throw _privateConstructorUsedError;
  String? get playerName => throw _privateConstructorUsedError;
  int? get playerJerseyNumber => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError; // Action details
  PlayType get type => throw _privateConstructorUsedError;
  String? get notes =>
      throw _privateConstructorUsedError; // Field position (normalized 0-1 coordinates)
// 0,0 is home team's defended end zone corner
// 1,1 is away team's defended end zone corner
  double? get fieldX => throw _privateConstructorUsedError;
  double? get fieldY =>
      throw _privateConstructorUsedError; // For throws: who received (if completed)
  String? get targetPlayerId => throw _privateConstructorUsedError;
  String? get targetPlayerName =>
      throw _privateConstructorUsedError; // For turnovers: additional context
  String? get turnoverType =>
      throw _privateConstructorUsedError; // 'throwaway', 'drop', 'stall', 'OB'
// Timing
  DateTime get timestamp => throw _privateConstructorUsedError;
  int? get stallCount =>
      throw _privateConstructorUsedError; // 0-10, at time of action
// Sync status
  bool get isSynced => throw _privateConstructorUsedError;
  DateTime? get syncedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayCopyWith<Play> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayCopyWith<$Res> {
  factory $PlayCopyWith(Play value, $Res Function(Play) then) =
      _$PlayCopyWithImpl<$Res, Play>;
  @useResult
  $Res call(
      {String id,
      String gameId,
      String pointId,
      int playNumber,
      String? playerId,
      String? playerName,
      int? playerJerseyNumber,
      String teamId,
      PlayType type,
      String? notes,
      double? fieldX,
      double? fieldY,
      String? targetPlayerId,
      String? targetPlayerName,
      String? turnoverType,
      DateTime timestamp,
      int? stallCount,
      bool isSynced,
      DateTime? syncedAt});
}

/// @nodoc
class _$PlayCopyWithImpl<$Res, $Val extends Play>
    implements $PlayCopyWith<$Res> {
  _$PlayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? gameId = null,
    Object? pointId = null,
    Object? playNumber = null,
    Object? playerId = freezed,
    Object? playerName = freezed,
    Object? playerJerseyNumber = freezed,
    Object? teamId = null,
    Object? type = null,
    Object? notes = freezed,
    Object? fieldX = freezed,
    Object? fieldY = freezed,
    Object? targetPlayerId = freezed,
    Object? targetPlayerName = freezed,
    Object? turnoverType = freezed,
    Object? timestamp = null,
    Object? stallCount = freezed,
    Object? isSynced = null,
    Object? syncedAt = freezed,
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
      pointId: null == pointId
          ? _value.pointId
          : pointId // ignore: cast_nullable_to_non_nullable
              as String,
      playNumber: null == playNumber
          ? _value.playNumber
          : playNumber // ignore: cast_nullable_to_non_nullable
              as int,
      playerId: freezed == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String?,
      playerName: freezed == playerName
          ? _value.playerName
          : playerName // ignore: cast_nullable_to_non_nullable
              as String?,
      playerJerseyNumber: freezed == playerJerseyNumber
          ? _value.playerJerseyNumber
          : playerJerseyNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PlayType,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      fieldX: freezed == fieldX
          ? _value.fieldX
          : fieldX // ignore: cast_nullable_to_non_nullable
              as double?,
      fieldY: freezed == fieldY
          ? _value.fieldY
          : fieldY // ignore: cast_nullable_to_non_nullable
              as double?,
      targetPlayerId: freezed == targetPlayerId
          ? _value.targetPlayerId
          : targetPlayerId // ignore: cast_nullable_to_non_nullable
              as String?,
      targetPlayerName: freezed == targetPlayerName
          ? _value.targetPlayerName
          : targetPlayerName // ignore: cast_nullable_to_non_nullable
              as String?,
      turnoverType: freezed == turnoverType
          ? _value.turnoverType
          : turnoverType // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      stallCount: freezed == stallCount
          ? _value.stallCount
          : stallCount // ignore: cast_nullable_to_non_nullable
              as int?,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayImplCopyWith<$Res> implements $PlayCopyWith<$Res> {
  factory _$$PlayImplCopyWith(
          _$PlayImpl value, $Res Function(_$PlayImpl) then) =
      __$$PlayImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String gameId,
      String pointId,
      int playNumber,
      String? playerId,
      String? playerName,
      int? playerJerseyNumber,
      String teamId,
      PlayType type,
      String? notes,
      double? fieldX,
      double? fieldY,
      String? targetPlayerId,
      String? targetPlayerName,
      String? turnoverType,
      DateTime timestamp,
      int? stallCount,
      bool isSynced,
      DateTime? syncedAt});
}

/// @nodoc
class __$$PlayImplCopyWithImpl<$Res>
    extends _$PlayCopyWithImpl<$Res, _$PlayImpl>
    implements _$$PlayImplCopyWith<$Res> {
  __$$PlayImplCopyWithImpl(_$PlayImpl _value, $Res Function(_$PlayImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? gameId = null,
    Object? pointId = null,
    Object? playNumber = null,
    Object? playerId = freezed,
    Object? playerName = freezed,
    Object? playerJerseyNumber = freezed,
    Object? teamId = null,
    Object? type = null,
    Object? notes = freezed,
    Object? fieldX = freezed,
    Object? fieldY = freezed,
    Object? targetPlayerId = freezed,
    Object? targetPlayerName = freezed,
    Object? turnoverType = freezed,
    Object? timestamp = null,
    Object? stallCount = freezed,
    Object? isSynced = null,
    Object? syncedAt = freezed,
  }) {
    return _then(_$PlayImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String,
      pointId: null == pointId
          ? _value.pointId
          : pointId // ignore: cast_nullable_to_non_nullable
              as String,
      playNumber: null == playNumber
          ? _value.playNumber
          : playNumber // ignore: cast_nullable_to_non_nullable
              as int,
      playerId: freezed == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String?,
      playerName: freezed == playerName
          ? _value.playerName
          : playerName // ignore: cast_nullable_to_non_nullable
              as String?,
      playerJerseyNumber: freezed == playerJerseyNumber
          ? _value.playerJerseyNumber
          : playerJerseyNumber // ignore: cast_nullable_to_non_nullable
              as int?,
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PlayType,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      fieldX: freezed == fieldX
          ? _value.fieldX
          : fieldX // ignore: cast_nullable_to_non_nullable
              as double?,
      fieldY: freezed == fieldY
          ? _value.fieldY
          : fieldY // ignore: cast_nullable_to_non_nullable
              as double?,
      targetPlayerId: freezed == targetPlayerId
          ? _value.targetPlayerId
          : targetPlayerId // ignore: cast_nullable_to_non_nullable
              as String?,
      targetPlayerName: freezed == targetPlayerName
          ? _value.targetPlayerName
          : targetPlayerName // ignore: cast_nullable_to_non_nullable
              as String?,
      turnoverType: freezed == turnoverType
          ? _value.turnoverType
          : turnoverType // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      stallCount: freezed == stallCount
          ? _value.stallCount
          : stallCount // ignore: cast_nullable_to_non_nullable
              as int?,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
      syncedAt: freezed == syncedAt
          ? _value.syncedAt
          : syncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayImpl implements _Play {
  const _$PlayImpl(
      {required this.id,
      required this.gameId,
      required this.pointId,
      required this.playNumber,
      this.playerId,
      this.playerName,
      this.playerJerseyNumber,
      required this.teamId,
      required this.type,
      this.notes,
      this.fieldX,
      this.fieldY,
      this.targetPlayerId,
      this.targetPlayerName,
      this.turnoverType,
      required this.timestamp,
      this.stallCount,
      this.isSynced = false,
      this.syncedAt});

  factory _$PlayImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayImplFromJson(json);

  @override
  final String id;
  @override
  final String gameId;
  @override
  final String pointId;
  @override
  final int playNumber;
// Sequential within the point
// Player info
  @override
  final String? playerId;
  @override
  final String? playerName;
  @override
  final int? playerJerseyNumber;
  @override
  final String teamId;
// Action details
  @override
  final PlayType type;
  @override
  final String? notes;
// Field position (normalized 0-1 coordinates)
// 0,0 is home team's defended end zone corner
// 1,1 is away team's defended end zone corner
  @override
  final double? fieldX;
  @override
  final double? fieldY;
// For throws: who received (if completed)
  @override
  final String? targetPlayerId;
  @override
  final String? targetPlayerName;
// For turnovers: additional context
  @override
  final String? turnoverType;
// 'throwaway', 'drop', 'stall', 'OB'
// Timing
  @override
  final DateTime timestamp;
  @override
  final int? stallCount;
// 0-10, at time of action
// Sync status
  @override
  @JsonKey()
  final bool isSynced;
  @override
  final DateTime? syncedAt;

  @override
  String toString() {
    return 'Play(id: $id, gameId: $gameId, pointId: $pointId, playNumber: $playNumber, playerId: $playerId, playerName: $playerName, playerJerseyNumber: $playerJerseyNumber, teamId: $teamId, type: $type, notes: $notes, fieldX: $fieldX, fieldY: $fieldY, targetPlayerId: $targetPlayerId, targetPlayerName: $targetPlayerName, turnoverType: $turnoverType, timestamp: $timestamp, stallCount: $stallCount, isSynced: $isSynced, syncedAt: $syncedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.gameId, gameId) || other.gameId == gameId) &&
            (identical(other.pointId, pointId) || other.pointId == pointId) &&
            (identical(other.playNumber, playNumber) ||
                other.playNumber == playNumber) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.playerName, playerName) ||
                other.playerName == playerName) &&
            (identical(other.playerJerseyNumber, playerJerseyNumber) ||
                other.playerJerseyNumber == playerJerseyNumber) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.fieldX, fieldX) || other.fieldX == fieldX) &&
            (identical(other.fieldY, fieldY) || other.fieldY == fieldY) &&
            (identical(other.targetPlayerId, targetPlayerId) ||
                other.targetPlayerId == targetPlayerId) &&
            (identical(other.targetPlayerName, targetPlayerName) ||
                other.targetPlayerName == targetPlayerName) &&
            (identical(other.turnoverType, turnoverType) ||
                other.turnoverType == turnoverType) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.stallCount, stallCount) ||
                other.stallCount == stallCount) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced) &&
            (identical(other.syncedAt, syncedAt) ||
                other.syncedAt == syncedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        gameId,
        pointId,
        playNumber,
        playerId,
        playerName,
        playerJerseyNumber,
        teamId,
        type,
        notes,
        fieldX,
        fieldY,
        targetPlayerId,
        targetPlayerName,
        turnoverType,
        timestamp,
        stallCount,
        isSynced,
        syncedAt
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayImplCopyWith<_$PlayImpl> get copyWith =>
      __$$PlayImplCopyWithImpl<_$PlayImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayImplToJson(
      this,
    );
  }
}

abstract class _Play implements Play {
  const factory _Play(
      {required final String id,
      required final String gameId,
      required final String pointId,
      required final int playNumber,
      final String? playerId,
      final String? playerName,
      final int? playerJerseyNumber,
      required final String teamId,
      required final PlayType type,
      final String? notes,
      final double? fieldX,
      final double? fieldY,
      final String? targetPlayerId,
      final String? targetPlayerName,
      final String? turnoverType,
      required final DateTime timestamp,
      final int? stallCount,
      final bool isSynced,
      final DateTime? syncedAt}) = _$PlayImpl;

  factory _Play.fromJson(Map<String, dynamic> json) = _$PlayImpl.fromJson;

  @override
  String get id;
  @override
  String get gameId;
  @override
  String get pointId;
  @override
  int get playNumber;
  @override // Sequential within the point
// Player info
  String? get playerId;
  @override
  String? get playerName;
  @override
  int? get playerJerseyNumber;
  @override
  String get teamId;
  @override // Action details
  PlayType get type;
  @override
  String? get notes;
  @override // Field position (normalized 0-1 coordinates)
// 0,0 is home team's defended end zone corner
// 1,1 is away team's defended end zone corner
  double? get fieldX;
  @override
  double? get fieldY;
  @override // For throws: who received (if completed)
  String? get targetPlayerId;
  @override
  String? get targetPlayerName;
  @override // For turnovers: additional context
  String? get turnoverType;
  @override // 'throwaway', 'drop', 'stall', 'OB'
// Timing
  DateTime get timestamp;
  @override
  int? get stallCount;
  @override // 0-10, at time of action
// Sync status
  bool get isSynced;
  @override
  DateTime? get syncedAt;
  @override
  @JsonKey(ignore: true)
  _$$PlayImplCopyWith<_$PlayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GamePoint _$GamePointFromJson(Map<String, dynamic> json) {
  return _GamePoint.fromJson(json);
}

/// @nodoc
mixin _$GamePoint {
  String get id => throw _privateConstructorUsedError;
  String get gameId => throw _privateConstructorUsedError;
  int get pointNumber => throw _privateConstructorUsedError; // Teams
  String get startingTeamId =>
      throw _privateConstructorUsedError; // Team that pulled (on D)
  String get receivingTeamId =>
      throw _privateConstructorUsedError; // Team that received (on O)
  String? get scoringTeamId =>
      throw _privateConstructorUsedError; // null until point ends
// Line info
  LineType get homeLineType =>
      throw _privateConstructorUsedError; // O or D for home team
  LineType get awayLineType =>
      throw _privateConstructorUsedError; // O or D for away team
// Players on field at start
  List<String> get homePlayersOnField => throw _privateConstructorUsedError;
  List<String> get awayPlayersOnField =>
      throw _privateConstructorUsedError; // Stats for this point
  int get totalTurnovers => throw _privateConstructorUsedError;
  int get homeTurnovers => throw _privateConstructorUsedError;
  int get awayTurnovers => throw _privateConstructorUsedError; // Timing
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime =>
      throw _privateConstructorUsedError; // Score at start of point
  int get homeScoreAtStart => throw _privateConstructorUsedError;
  int get awayScoreAtStart => throw _privateConstructorUsedError; // Sync
  bool get isSynced => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GamePointCopyWith<GamePoint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GamePointCopyWith<$Res> {
  factory $GamePointCopyWith(GamePoint value, $Res Function(GamePoint) then) =
      _$GamePointCopyWithImpl<$Res, GamePoint>;
  @useResult
  $Res call(
      {String id,
      String gameId,
      int pointNumber,
      String startingTeamId,
      String receivingTeamId,
      String? scoringTeamId,
      LineType homeLineType,
      LineType awayLineType,
      List<String> homePlayersOnField,
      List<String> awayPlayersOnField,
      int totalTurnovers,
      int homeTurnovers,
      int awayTurnovers,
      DateTime startTime,
      DateTime? endTime,
      int homeScoreAtStart,
      int awayScoreAtStart,
      bool isSynced});
}

/// @nodoc
class _$GamePointCopyWithImpl<$Res, $Val extends GamePoint>
    implements $GamePointCopyWith<$Res> {
  _$GamePointCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? gameId = null,
    Object? pointNumber = null,
    Object? startingTeamId = null,
    Object? receivingTeamId = null,
    Object? scoringTeamId = freezed,
    Object? homeLineType = null,
    Object? awayLineType = null,
    Object? homePlayersOnField = null,
    Object? awayPlayersOnField = null,
    Object? totalTurnovers = null,
    Object? homeTurnovers = null,
    Object? awayTurnovers = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? homeScoreAtStart = null,
    Object? awayScoreAtStart = null,
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
      pointNumber: null == pointNumber
          ? _value.pointNumber
          : pointNumber // ignore: cast_nullable_to_non_nullable
              as int,
      startingTeamId: null == startingTeamId
          ? _value.startingTeamId
          : startingTeamId // ignore: cast_nullable_to_non_nullable
              as String,
      receivingTeamId: null == receivingTeamId
          ? _value.receivingTeamId
          : receivingTeamId // ignore: cast_nullable_to_non_nullable
              as String,
      scoringTeamId: freezed == scoringTeamId
          ? _value.scoringTeamId
          : scoringTeamId // ignore: cast_nullable_to_non_nullable
              as String?,
      homeLineType: null == homeLineType
          ? _value.homeLineType
          : homeLineType // ignore: cast_nullable_to_non_nullable
              as LineType,
      awayLineType: null == awayLineType
          ? _value.awayLineType
          : awayLineType // ignore: cast_nullable_to_non_nullable
              as LineType,
      homePlayersOnField: null == homePlayersOnField
          ? _value.homePlayersOnField
          : homePlayersOnField // ignore: cast_nullable_to_non_nullable
              as List<String>,
      awayPlayersOnField: null == awayPlayersOnField
          ? _value.awayPlayersOnField
          : awayPlayersOnField // ignore: cast_nullable_to_non_nullable
              as List<String>,
      totalTurnovers: null == totalTurnovers
          ? _value.totalTurnovers
          : totalTurnovers // ignore: cast_nullable_to_non_nullable
              as int,
      homeTurnovers: null == homeTurnovers
          ? _value.homeTurnovers
          : homeTurnovers // ignore: cast_nullable_to_non_nullable
              as int,
      awayTurnovers: null == awayTurnovers
          ? _value.awayTurnovers
          : awayTurnovers // ignore: cast_nullable_to_non_nullable
              as int,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      homeScoreAtStart: null == homeScoreAtStart
          ? _value.homeScoreAtStart
          : homeScoreAtStart // ignore: cast_nullable_to_non_nullable
              as int,
      awayScoreAtStart: null == awayScoreAtStart
          ? _value.awayScoreAtStart
          : awayScoreAtStart // ignore: cast_nullable_to_non_nullable
              as int,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GamePointImplCopyWith<$Res>
    implements $GamePointCopyWith<$Res> {
  factory _$$GamePointImplCopyWith(
          _$GamePointImpl value, $Res Function(_$GamePointImpl) then) =
      __$$GamePointImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String gameId,
      int pointNumber,
      String startingTeamId,
      String receivingTeamId,
      String? scoringTeamId,
      LineType homeLineType,
      LineType awayLineType,
      List<String> homePlayersOnField,
      List<String> awayPlayersOnField,
      int totalTurnovers,
      int homeTurnovers,
      int awayTurnovers,
      DateTime startTime,
      DateTime? endTime,
      int homeScoreAtStart,
      int awayScoreAtStart,
      bool isSynced});
}

/// @nodoc
class __$$GamePointImplCopyWithImpl<$Res>
    extends _$GamePointCopyWithImpl<$Res, _$GamePointImpl>
    implements _$$GamePointImplCopyWith<$Res> {
  __$$GamePointImplCopyWithImpl(
      _$GamePointImpl _value, $Res Function(_$GamePointImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? gameId = null,
    Object? pointNumber = null,
    Object? startingTeamId = null,
    Object? receivingTeamId = null,
    Object? scoringTeamId = freezed,
    Object? homeLineType = null,
    Object? awayLineType = null,
    Object? homePlayersOnField = null,
    Object? awayPlayersOnField = null,
    Object? totalTurnovers = null,
    Object? homeTurnovers = null,
    Object? awayTurnovers = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? homeScoreAtStart = null,
    Object? awayScoreAtStart = null,
    Object? isSynced = null,
  }) {
    return _then(_$GamePointImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      gameId: null == gameId
          ? _value.gameId
          : gameId // ignore: cast_nullable_to_non_nullable
              as String,
      pointNumber: null == pointNumber
          ? _value.pointNumber
          : pointNumber // ignore: cast_nullable_to_non_nullable
              as int,
      startingTeamId: null == startingTeamId
          ? _value.startingTeamId
          : startingTeamId // ignore: cast_nullable_to_non_nullable
              as String,
      receivingTeamId: null == receivingTeamId
          ? _value.receivingTeamId
          : receivingTeamId // ignore: cast_nullable_to_non_nullable
              as String,
      scoringTeamId: freezed == scoringTeamId
          ? _value.scoringTeamId
          : scoringTeamId // ignore: cast_nullable_to_non_nullable
              as String?,
      homeLineType: null == homeLineType
          ? _value.homeLineType
          : homeLineType // ignore: cast_nullable_to_non_nullable
              as LineType,
      awayLineType: null == awayLineType
          ? _value.awayLineType
          : awayLineType // ignore: cast_nullable_to_non_nullable
              as LineType,
      homePlayersOnField: null == homePlayersOnField
          ? _value._homePlayersOnField
          : homePlayersOnField // ignore: cast_nullable_to_non_nullable
              as List<String>,
      awayPlayersOnField: null == awayPlayersOnField
          ? _value._awayPlayersOnField
          : awayPlayersOnField // ignore: cast_nullable_to_non_nullable
              as List<String>,
      totalTurnovers: null == totalTurnovers
          ? _value.totalTurnovers
          : totalTurnovers // ignore: cast_nullable_to_non_nullable
              as int,
      homeTurnovers: null == homeTurnovers
          ? _value.homeTurnovers
          : homeTurnovers // ignore: cast_nullable_to_non_nullable
              as int,
      awayTurnovers: null == awayTurnovers
          ? _value.awayTurnovers
          : awayTurnovers // ignore: cast_nullable_to_non_nullable
              as int,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      homeScoreAtStart: null == homeScoreAtStart
          ? _value.homeScoreAtStart
          : homeScoreAtStart // ignore: cast_nullable_to_non_nullable
              as int,
      awayScoreAtStart: null == awayScoreAtStart
          ? _value.awayScoreAtStart
          : awayScoreAtStart // ignore: cast_nullable_to_non_nullable
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
class _$GamePointImpl implements _GamePoint {
  const _$GamePointImpl(
      {required this.id,
      required this.gameId,
      required this.pointNumber,
      required this.startingTeamId,
      required this.receivingTeamId,
      this.scoringTeamId,
      required this.homeLineType,
      required this.awayLineType,
      final List<String> homePlayersOnField = const [],
      final List<String> awayPlayersOnField = const [],
      this.totalTurnovers = 0,
      this.homeTurnovers = 0,
      this.awayTurnovers = 0,
      required this.startTime,
      this.endTime,
      required this.homeScoreAtStart,
      required this.awayScoreAtStart,
      this.isSynced = false})
      : _homePlayersOnField = homePlayersOnField,
        _awayPlayersOnField = awayPlayersOnField;

  factory _$GamePointImpl.fromJson(Map<String, dynamic> json) =>
      _$$GamePointImplFromJson(json);

  @override
  final String id;
  @override
  final String gameId;
  @override
  final int pointNumber;
// Teams
  @override
  final String startingTeamId;
// Team that pulled (on D)
  @override
  final String receivingTeamId;
// Team that received (on O)
  @override
  final String? scoringTeamId;
// null until point ends
// Line info
  @override
  final LineType homeLineType;
// O or D for home team
  @override
  final LineType awayLineType;
// O or D for away team
// Players on field at start
  final List<String> _homePlayersOnField;
// O or D for away team
// Players on field at start
  @override
  @JsonKey()
  List<String> get homePlayersOnField {
    if (_homePlayersOnField is EqualUnmodifiableListView)
      return _homePlayersOnField;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_homePlayersOnField);
  }

  final List<String> _awayPlayersOnField;
  @override
  @JsonKey()
  List<String> get awayPlayersOnField {
    if (_awayPlayersOnField is EqualUnmodifiableListView)
      return _awayPlayersOnField;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_awayPlayersOnField);
  }

// Stats for this point
  @override
  @JsonKey()
  final int totalTurnovers;
  @override
  @JsonKey()
  final int homeTurnovers;
  @override
  @JsonKey()
  final int awayTurnovers;
// Timing
  @override
  final DateTime startTime;
  @override
  final DateTime? endTime;
// Score at start of point
  @override
  final int homeScoreAtStart;
  @override
  final int awayScoreAtStart;
// Sync
  @override
  @JsonKey()
  final bool isSynced;

  @override
  String toString() {
    return 'GamePoint(id: $id, gameId: $gameId, pointNumber: $pointNumber, startingTeamId: $startingTeamId, receivingTeamId: $receivingTeamId, scoringTeamId: $scoringTeamId, homeLineType: $homeLineType, awayLineType: $awayLineType, homePlayersOnField: $homePlayersOnField, awayPlayersOnField: $awayPlayersOnField, totalTurnovers: $totalTurnovers, homeTurnovers: $homeTurnovers, awayTurnovers: $awayTurnovers, startTime: $startTime, endTime: $endTime, homeScoreAtStart: $homeScoreAtStart, awayScoreAtStart: $awayScoreAtStart, isSynced: $isSynced)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GamePointImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.gameId, gameId) || other.gameId == gameId) &&
            (identical(other.pointNumber, pointNumber) ||
                other.pointNumber == pointNumber) &&
            (identical(other.startingTeamId, startingTeamId) ||
                other.startingTeamId == startingTeamId) &&
            (identical(other.receivingTeamId, receivingTeamId) ||
                other.receivingTeamId == receivingTeamId) &&
            (identical(other.scoringTeamId, scoringTeamId) ||
                other.scoringTeamId == scoringTeamId) &&
            (identical(other.homeLineType, homeLineType) ||
                other.homeLineType == homeLineType) &&
            (identical(other.awayLineType, awayLineType) ||
                other.awayLineType == awayLineType) &&
            const DeepCollectionEquality()
                .equals(other._homePlayersOnField, _homePlayersOnField) &&
            const DeepCollectionEquality()
                .equals(other._awayPlayersOnField, _awayPlayersOnField) &&
            (identical(other.totalTurnovers, totalTurnovers) ||
                other.totalTurnovers == totalTurnovers) &&
            (identical(other.homeTurnovers, homeTurnovers) ||
                other.homeTurnovers == homeTurnovers) &&
            (identical(other.awayTurnovers, awayTurnovers) ||
                other.awayTurnovers == awayTurnovers) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.homeScoreAtStart, homeScoreAtStart) ||
                other.homeScoreAtStart == homeScoreAtStart) &&
            (identical(other.awayScoreAtStart, awayScoreAtStart) ||
                other.awayScoreAtStart == awayScoreAtStart) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      gameId,
      pointNumber,
      startingTeamId,
      receivingTeamId,
      scoringTeamId,
      homeLineType,
      awayLineType,
      const DeepCollectionEquality().hash(_homePlayersOnField),
      const DeepCollectionEquality().hash(_awayPlayersOnField),
      totalTurnovers,
      homeTurnovers,
      awayTurnovers,
      startTime,
      endTime,
      homeScoreAtStart,
      awayScoreAtStart,
      isSynced);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GamePointImplCopyWith<_$GamePointImpl> get copyWith =>
      __$$GamePointImplCopyWithImpl<_$GamePointImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GamePointImplToJson(
      this,
    );
  }
}

abstract class _GamePoint implements GamePoint {
  const factory _GamePoint(
      {required final String id,
      required final String gameId,
      required final int pointNumber,
      required final String startingTeamId,
      required final String receivingTeamId,
      final String? scoringTeamId,
      required final LineType homeLineType,
      required final LineType awayLineType,
      final List<String> homePlayersOnField,
      final List<String> awayPlayersOnField,
      final int totalTurnovers,
      final int homeTurnovers,
      final int awayTurnovers,
      required final DateTime startTime,
      final DateTime? endTime,
      required final int homeScoreAtStart,
      required final int awayScoreAtStart,
      final bool isSynced}) = _$GamePointImpl;

  factory _GamePoint.fromJson(Map<String, dynamic> json) =
      _$GamePointImpl.fromJson;

  @override
  String get id;
  @override
  String get gameId;
  @override
  int get pointNumber;
  @override // Teams
  String get startingTeamId;
  @override // Team that pulled (on D)
  String get receivingTeamId;
  @override // Team that received (on O)
  String? get scoringTeamId;
  @override // null until point ends
// Line info
  LineType get homeLineType;
  @override // O or D for home team
  LineType get awayLineType;
  @override // O or D for away team
// Players on field at start
  List<String> get homePlayersOnField;
  @override
  List<String> get awayPlayersOnField;
  @override // Stats for this point
  int get totalTurnovers;
  @override
  int get homeTurnovers;
  @override
  int get awayTurnovers;
  @override // Timing
  DateTime get startTime;
  @override
  DateTime? get endTime;
  @override // Score at start of point
  int get homeScoreAtStart;
  @override
  int get awayScoreAtStart;
  @override // Sync
  bool get isSynced;
  @override
  @JsonKey(ignore: true)
  _$$GamePointImplCopyWith<_$GamePointImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FieldPosition _$FieldPositionFromJson(Map<String, dynamic> json) {
  return _FieldPosition.fromJson(json);
}

/// @nodoc
mixin _$FieldPosition {
  double get x => throw _privateConstructorUsedError; // 0-1, left to right
  double get y => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FieldPositionCopyWith<FieldPosition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FieldPositionCopyWith<$Res> {
  factory $FieldPositionCopyWith(
          FieldPosition value, $Res Function(FieldPosition) then) =
      _$FieldPositionCopyWithImpl<$Res, FieldPosition>;
  @useResult
  $Res call({double x, double y});
}

/// @nodoc
class _$FieldPositionCopyWithImpl<$Res, $Val extends FieldPosition>
    implements $FieldPositionCopyWith<$Res> {
  _$FieldPositionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
  }) {
    return _then(_value.copyWith(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FieldPositionImplCopyWith<$Res>
    implements $FieldPositionCopyWith<$Res> {
  factory _$$FieldPositionImplCopyWith(
          _$FieldPositionImpl value, $Res Function(_$FieldPositionImpl) then) =
      __$$FieldPositionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double x, double y});
}

/// @nodoc
class __$$FieldPositionImplCopyWithImpl<$Res>
    extends _$FieldPositionCopyWithImpl<$Res, _$FieldPositionImpl>
    implements _$$FieldPositionImplCopyWith<$Res> {
  __$$FieldPositionImplCopyWithImpl(
      _$FieldPositionImpl _value, $Res Function(_$FieldPositionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? x = null,
    Object? y = null,
  }) {
    return _then(_$FieldPositionImpl(
      x: null == x
          ? _value.x
          : x // ignore: cast_nullable_to_non_nullable
              as double,
      y: null == y
          ? _value.y
          : y // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FieldPositionImpl implements _FieldPosition {
  const _$FieldPositionImpl({required this.x, required this.y});

  factory _$FieldPositionImpl.fromJson(Map<String, dynamic> json) =>
      _$$FieldPositionImplFromJson(json);

  @override
  final double x;
// 0-1, left to right
  @override
  final double y;

  @override
  String toString() {
    return 'FieldPosition(x: $x, y: $y)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FieldPositionImpl &&
            (identical(other.x, x) || other.x == x) &&
            (identical(other.y, y) || other.y == y));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, x, y);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FieldPositionImplCopyWith<_$FieldPositionImpl> get copyWith =>
      __$$FieldPositionImplCopyWithImpl<_$FieldPositionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FieldPositionImplToJson(
      this,
    );
  }
}

abstract class _FieldPosition implements FieldPosition {
  const factory _FieldPosition(
      {required final double x, required final double y}) = _$FieldPositionImpl;

  factory _FieldPosition.fromJson(Map<String, dynamic> json) =
      _$FieldPositionImpl.fromJson;

  @override
  double get x;
  @override // 0-1, left to right
  double get y;
  @override
  @JsonKey(ignore: true)
  _$$FieldPositionImplCopyWith<_$FieldPositionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
