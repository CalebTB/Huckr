// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Game _$GameFromJson(Map<String, dynamic> json) {
  return _Game.fromJson(json);
}

/// @nodoc
mixin _$Game {
  String get id => throw _privateConstructorUsedError;
  String? get tournamentId => throw _privateConstructorUsedError;
  String? get poolId => throw _privateConstructorUsedError;
  String? get bracketPosition => throw _privateConstructorUsedError; // Teams
  String get homeTeamId => throw _privateConstructorUsedError;
  String get awayTeamId => throw _privateConstructorUsedError;
  String get homeTeamName => throw _privateConstructorUsedError;
  String get awayTeamName => throw _privateConstructorUsedError;
  String? get homeTeamLogo => throw _privateConstructorUsedError;
  String? get awayTeamLogo => throw _privateConstructorUsedError; // Score
  int get homeScore => throw _privateConstructorUsedError;
  int get awayScore => throw _privateConstructorUsedError;
  int? get halftimeHomeScore => throw _privateConstructorUsedError;
  int? get halftimeAwayScore =>
      throw _privateConstructorUsedError; // Game settings
  int get gameToPoints =>
      throw _privateConstructorUsedError; // Current target (changes when caps hit)
  int? get originalGameToPoints =>
      throw _privateConstructorUsedError; // Original target (for halftime calculation), null = same as gameToPoints
  int get hardCapPoints => throw _privateConstructorUsedError;
  int? get halftimeAtOverride =>
      throw _privateConstructorUsedError; // Optional override, null = use formula: (gameToPoints / 2).ceil()
  int get softCapMinutes => throw _privateConstructorUsedError;
  int get hardCapMinutes => throw _privateConstructorUsedError; // Status
  GameStatus get status => throw _privateConstructorUsedError;
  int get currentPoint => throw _privateConstructorUsedError;
  String? get currentPossession => throw _privateConstructorUsedError; // teamId
// Timing
  DateTime? get scheduledAt => throw _privateConstructorUsedError;
  DateTime? get startedAt => throw _privateConstructorUsedError;
  DateTime? get halftimeStartedAt => throw _privateConstructorUsedError;
  DateTime? get softCapStartedAt => throw _privateConstructorUsedError;
  DateTime? get hardCapStartedAt => throw _privateConstructorUsedError;
  DateTime? get endedAt => throw _privateConstructorUsedError; // Delays
  bool get isDelayed => throw _privateConstructorUsedError;
  DelayReason? get delayReason => throw _privateConstructorUsedError;
  String? get delayNotes => throw _privateConstructorUsedError;
  DateTime? get delayStartedAt =>
      throw _privateConstructorUsedError; // Conditions
  String? get windSpeed => throw _privateConstructorUsedError;
  String? get windDirection => throw _privateConstructorUsedError;
  String? get weatherNotes => throw _privateConstructorUsedError;
  String? get gameNotes =>
      throw _privateConstructorUsedError; // Post-game notes (injuries, notable plays, comments)
// Tracking
  bool get isBeingTracked => throw _privateConstructorUsedError;
  String? get trackedByUserId => throw _privateConstructorUsedError;
  String? get trackedByUserName => throw _privateConstructorUsedError;
  bool get isSimpleTracking =>
      throw _privateConstructorUsedError; // Simple mode = faster entry, Advanced = full stats
// Sync
  bool get isSynced => throw _privateConstructorUsedError;
  DateTime? get lastSyncedAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameCopyWith<Game> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameCopyWith<$Res> {
  factory $GameCopyWith(Game value, $Res Function(Game) then) =
      _$GameCopyWithImpl<$Res, Game>;
  @useResult
  $Res call(
      {String id,
      String? tournamentId,
      String? poolId,
      String? bracketPosition,
      String homeTeamId,
      String awayTeamId,
      String homeTeamName,
      String awayTeamName,
      String? homeTeamLogo,
      String? awayTeamLogo,
      int homeScore,
      int awayScore,
      int? halftimeHomeScore,
      int? halftimeAwayScore,
      int gameToPoints,
      int? originalGameToPoints,
      int hardCapPoints,
      int? halftimeAtOverride,
      int softCapMinutes,
      int hardCapMinutes,
      GameStatus status,
      int currentPoint,
      String? currentPossession,
      DateTime? scheduledAt,
      DateTime? startedAt,
      DateTime? halftimeStartedAt,
      DateTime? softCapStartedAt,
      DateTime? hardCapStartedAt,
      DateTime? endedAt,
      bool isDelayed,
      DelayReason? delayReason,
      String? delayNotes,
      DateTime? delayStartedAt,
      String? windSpeed,
      String? windDirection,
      String? weatherNotes,
      String? gameNotes,
      bool isBeingTracked,
      String? trackedByUserId,
      String? trackedByUserName,
      bool isSimpleTracking,
      bool isSynced,
      DateTime? lastSyncedAt,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$GameCopyWithImpl<$Res, $Val extends Game>
    implements $GameCopyWith<$Res> {
  _$GameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tournamentId = freezed,
    Object? poolId = freezed,
    Object? bracketPosition = freezed,
    Object? homeTeamId = null,
    Object? awayTeamId = null,
    Object? homeTeamName = null,
    Object? awayTeamName = null,
    Object? homeTeamLogo = freezed,
    Object? awayTeamLogo = freezed,
    Object? homeScore = null,
    Object? awayScore = null,
    Object? halftimeHomeScore = freezed,
    Object? halftimeAwayScore = freezed,
    Object? gameToPoints = null,
    Object? originalGameToPoints = freezed,
    Object? hardCapPoints = null,
    Object? halftimeAtOverride = freezed,
    Object? softCapMinutes = null,
    Object? hardCapMinutes = null,
    Object? status = null,
    Object? currentPoint = null,
    Object? currentPossession = freezed,
    Object? scheduledAt = freezed,
    Object? startedAt = freezed,
    Object? halftimeStartedAt = freezed,
    Object? softCapStartedAt = freezed,
    Object? hardCapStartedAt = freezed,
    Object? endedAt = freezed,
    Object? isDelayed = null,
    Object? delayReason = freezed,
    Object? delayNotes = freezed,
    Object? delayStartedAt = freezed,
    Object? windSpeed = freezed,
    Object? windDirection = freezed,
    Object? weatherNotes = freezed,
    Object? gameNotes = freezed,
    Object? isBeingTracked = null,
    Object? trackedByUserId = freezed,
    Object? trackedByUserName = freezed,
    Object? isSimpleTracking = null,
    Object? isSynced = null,
    Object? lastSyncedAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tournamentId: freezed == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String?,
      poolId: freezed == poolId
          ? _value.poolId
          : poolId // ignore: cast_nullable_to_non_nullable
              as String?,
      bracketPosition: freezed == bracketPosition
          ? _value.bracketPosition
          : bracketPosition // ignore: cast_nullable_to_non_nullable
              as String?,
      homeTeamId: null == homeTeamId
          ? _value.homeTeamId
          : homeTeamId // ignore: cast_nullable_to_non_nullable
              as String,
      awayTeamId: null == awayTeamId
          ? _value.awayTeamId
          : awayTeamId // ignore: cast_nullable_to_non_nullable
              as String,
      homeTeamName: null == homeTeamName
          ? _value.homeTeamName
          : homeTeamName // ignore: cast_nullable_to_non_nullable
              as String,
      awayTeamName: null == awayTeamName
          ? _value.awayTeamName
          : awayTeamName // ignore: cast_nullable_to_non_nullable
              as String,
      homeTeamLogo: freezed == homeTeamLogo
          ? _value.homeTeamLogo
          : homeTeamLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      awayTeamLogo: freezed == awayTeamLogo
          ? _value.awayTeamLogo
          : awayTeamLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      homeScore: null == homeScore
          ? _value.homeScore
          : homeScore // ignore: cast_nullable_to_non_nullable
              as int,
      awayScore: null == awayScore
          ? _value.awayScore
          : awayScore // ignore: cast_nullable_to_non_nullable
              as int,
      halftimeHomeScore: freezed == halftimeHomeScore
          ? _value.halftimeHomeScore
          : halftimeHomeScore // ignore: cast_nullable_to_non_nullable
              as int?,
      halftimeAwayScore: freezed == halftimeAwayScore
          ? _value.halftimeAwayScore
          : halftimeAwayScore // ignore: cast_nullable_to_non_nullable
              as int?,
      gameToPoints: null == gameToPoints
          ? _value.gameToPoints
          : gameToPoints // ignore: cast_nullable_to_non_nullable
              as int,
      originalGameToPoints: freezed == originalGameToPoints
          ? _value.originalGameToPoints
          : originalGameToPoints // ignore: cast_nullable_to_non_nullable
              as int?,
      hardCapPoints: null == hardCapPoints
          ? _value.hardCapPoints
          : hardCapPoints // ignore: cast_nullable_to_non_nullable
              as int,
      halftimeAtOverride: freezed == halftimeAtOverride
          ? _value.halftimeAtOverride
          : halftimeAtOverride // ignore: cast_nullable_to_non_nullable
              as int?,
      softCapMinutes: null == softCapMinutes
          ? _value.softCapMinutes
          : softCapMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      hardCapMinutes: null == hardCapMinutes
          ? _value.hardCapMinutes
          : hardCapMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      currentPoint: null == currentPoint
          ? _value.currentPoint
          : currentPoint // ignore: cast_nullable_to_non_nullable
              as int,
      currentPossession: freezed == currentPossession
          ? _value.currentPossession
          : currentPossession // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduledAt: freezed == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      halftimeStartedAt: freezed == halftimeStartedAt
          ? _value.halftimeStartedAt
          : halftimeStartedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      softCapStartedAt: freezed == softCapStartedAt
          ? _value.softCapStartedAt
          : softCapStartedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hardCapStartedAt: freezed == hardCapStartedAt
          ? _value.hardCapStartedAt
          : hardCapStartedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endedAt: freezed == endedAt
          ? _value.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isDelayed: null == isDelayed
          ? _value.isDelayed
          : isDelayed // ignore: cast_nullable_to_non_nullable
              as bool,
      delayReason: freezed == delayReason
          ? _value.delayReason
          : delayReason // ignore: cast_nullable_to_non_nullable
              as DelayReason?,
      delayNotes: freezed == delayNotes
          ? _value.delayNotes
          : delayNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      delayStartedAt: freezed == delayStartedAt
          ? _value.delayStartedAt
          : delayStartedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      windSpeed: freezed == windSpeed
          ? _value.windSpeed
          : windSpeed // ignore: cast_nullable_to_non_nullable
              as String?,
      windDirection: freezed == windDirection
          ? _value.windDirection
          : windDirection // ignore: cast_nullable_to_non_nullable
              as String?,
      weatherNotes: freezed == weatherNotes
          ? _value.weatherNotes
          : weatherNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      gameNotes: freezed == gameNotes
          ? _value.gameNotes
          : gameNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      isBeingTracked: null == isBeingTracked
          ? _value.isBeingTracked
          : isBeingTracked // ignore: cast_nullable_to_non_nullable
              as bool,
      trackedByUserId: freezed == trackedByUserId
          ? _value.trackedByUserId
          : trackedByUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      trackedByUserName: freezed == trackedByUserName
          ? _value.trackedByUserName
          : trackedByUserName // ignore: cast_nullable_to_non_nullable
              as String?,
      isSimpleTracking: null == isSimpleTracking
          ? _value.isSimpleTracking
          : isSimpleTracking // ignore: cast_nullable_to_non_nullable
              as bool,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSyncedAt: freezed == lastSyncedAt
          ? _value.lastSyncedAt
          : lastSyncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameImplCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$$GameImplCopyWith(
          _$GameImpl value, $Res Function(_$GameImpl) then) =
      __$$GameImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? tournamentId,
      String? poolId,
      String? bracketPosition,
      String homeTeamId,
      String awayTeamId,
      String homeTeamName,
      String awayTeamName,
      String? homeTeamLogo,
      String? awayTeamLogo,
      int homeScore,
      int awayScore,
      int? halftimeHomeScore,
      int? halftimeAwayScore,
      int gameToPoints,
      int? originalGameToPoints,
      int hardCapPoints,
      int? halftimeAtOverride,
      int softCapMinutes,
      int hardCapMinutes,
      GameStatus status,
      int currentPoint,
      String? currentPossession,
      DateTime? scheduledAt,
      DateTime? startedAt,
      DateTime? halftimeStartedAt,
      DateTime? softCapStartedAt,
      DateTime? hardCapStartedAt,
      DateTime? endedAt,
      bool isDelayed,
      DelayReason? delayReason,
      String? delayNotes,
      DateTime? delayStartedAt,
      String? windSpeed,
      String? windDirection,
      String? weatherNotes,
      String? gameNotes,
      bool isBeingTracked,
      String? trackedByUserId,
      String? trackedByUserName,
      bool isSimpleTracking,
      bool isSynced,
      DateTime? lastSyncedAt,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$GameImplCopyWithImpl<$Res>
    extends _$GameCopyWithImpl<$Res, _$GameImpl>
    implements _$$GameImplCopyWith<$Res> {
  __$$GameImplCopyWithImpl(_$GameImpl _value, $Res Function(_$GameImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? tournamentId = freezed,
    Object? poolId = freezed,
    Object? bracketPosition = freezed,
    Object? homeTeamId = null,
    Object? awayTeamId = null,
    Object? homeTeamName = null,
    Object? awayTeamName = null,
    Object? homeTeamLogo = freezed,
    Object? awayTeamLogo = freezed,
    Object? homeScore = null,
    Object? awayScore = null,
    Object? halftimeHomeScore = freezed,
    Object? halftimeAwayScore = freezed,
    Object? gameToPoints = null,
    Object? originalGameToPoints = freezed,
    Object? hardCapPoints = null,
    Object? halftimeAtOverride = freezed,
    Object? softCapMinutes = null,
    Object? hardCapMinutes = null,
    Object? status = null,
    Object? currentPoint = null,
    Object? currentPossession = freezed,
    Object? scheduledAt = freezed,
    Object? startedAt = freezed,
    Object? halftimeStartedAt = freezed,
    Object? softCapStartedAt = freezed,
    Object? hardCapStartedAt = freezed,
    Object? endedAt = freezed,
    Object? isDelayed = null,
    Object? delayReason = freezed,
    Object? delayNotes = freezed,
    Object? delayStartedAt = freezed,
    Object? windSpeed = freezed,
    Object? windDirection = freezed,
    Object? weatherNotes = freezed,
    Object? gameNotes = freezed,
    Object? isBeingTracked = null,
    Object? trackedByUserId = freezed,
    Object? trackedByUserName = freezed,
    Object? isSimpleTracking = null,
    Object? isSynced = null,
    Object? lastSyncedAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$GameImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      tournamentId: freezed == tournamentId
          ? _value.tournamentId
          : tournamentId // ignore: cast_nullable_to_non_nullable
              as String?,
      poolId: freezed == poolId
          ? _value.poolId
          : poolId // ignore: cast_nullable_to_non_nullable
              as String?,
      bracketPosition: freezed == bracketPosition
          ? _value.bracketPosition
          : bracketPosition // ignore: cast_nullable_to_non_nullable
              as String?,
      homeTeamId: null == homeTeamId
          ? _value.homeTeamId
          : homeTeamId // ignore: cast_nullable_to_non_nullable
              as String,
      awayTeamId: null == awayTeamId
          ? _value.awayTeamId
          : awayTeamId // ignore: cast_nullable_to_non_nullable
              as String,
      homeTeamName: null == homeTeamName
          ? _value.homeTeamName
          : homeTeamName // ignore: cast_nullable_to_non_nullable
              as String,
      awayTeamName: null == awayTeamName
          ? _value.awayTeamName
          : awayTeamName // ignore: cast_nullable_to_non_nullable
              as String,
      homeTeamLogo: freezed == homeTeamLogo
          ? _value.homeTeamLogo
          : homeTeamLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      awayTeamLogo: freezed == awayTeamLogo
          ? _value.awayTeamLogo
          : awayTeamLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      homeScore: null == homeScore
          ? _value.homeScore
          : homeScore // ignore: cast_nullable_to_non_nullable
              as int,
      awayScore: null == awayScore
          ? _value.awayScore
          : awayScore // ignore: cast_nullable_to_non_nullable
              as int,
      halftimeHomeScore: freezed == halftimeHomeScore
          ? _value.halftimeHomeScore
          : halftimeHomeScore // ignore: cast_nullable_to_non_nullable
              as int?,
      halftimeAwayScore: freezed == halftimeAwayScore
          ? _value.halftimeAwayScore
          : halftimeAwayScore // ignore: cast_nullable_to_non_nullable
              as int?,
      gameToPoints: null == gameToPoints
          ? _value.gameToPoints
          : gameToPoints // ignore: cast_nullable_to_non_nullable
              as int,
      originalGameToPoints: freezed == originalGameToPoints
          ? _value.originalGameToPoints
          : originalGameToPoints // ignore: cast_nullable_to_non_nullable
              as int?,
      hardCapPoints: null == hardCapPoints
          ? _value.hardCapPoints
          : hardCapPoints // ignore: cast_nullable_to_non_nullable
              as int,
      halftimeAtOverride: freezed == halftimeAtOverride
          ? _value.halftimeAtOverride
          : halftimeAtOverride // ignore: cast_nullable_to_non_nullable
              as int?,
      softCapMinutes: null == softCapMinutes
          ? _value.softCapMinutes
          : softCapMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      hardCapMinutes: null == hardCapMinutes
          ? _value.hardCapMinutes
          : hardCapMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      currentPoint: null == currentPoint
          ? _value.currentPoint
          : currentPoint // ignore: cast_nullable_to_non_nullable
              as int,
      currentPossession: freezed == currentPossession
          ? _value.currentPossession
          : currentPossession // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduledAt: freezed == scheduledAt
          ? _value.scheduledAt
          : scheduledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      halftimeStartedAt: freezed == halftimeStartedAt
          ? _value.halftimeStartedAt
          : halftimeStartedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      softCapStartedAt: freezed == softCapStartedAt
          ? _value.softCapStartedAt
          : softCapStartedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hardCapStartedAt: freezed == hardCapStartedAt
          ? _value.hardCapStartedAt
          : hardCapStartedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endedAt: freezed == endedAt
          ? _value.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isDelayed: null == isDelayed
          ? _value.isDelayed
          : isDelayed // ignore: cast_nullable_to_non_nullable
              as bool,
      delayReason: freezed == delayReason
          ? _value.delayReason
          : delayReason // ignore: cast_nullable_to_non_nullable
              as DelayReason?,
      delayNotes: freezed == delayNotes
          ? _value.delayNotes
          : delayNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      delayStartedAt: freezed == delayStartedAt
          ? _value.delayStartedAt
          : delayStartedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      windSpeed: freezed == windSpeed
          ? _value.windSpeed
          : windSpeed // ignore: cast_nullable_to_non_nullable
              as String?,
      windDirection: freezed == windDirection
          ? _value.windDirection
          : windDirection // ignore: cast_nullable_to_non_nullable
              as String?,
      weatherNotes: freezed == weatherNotes
          ? _value.weatherNotes
          : weatherNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      gameNotes: freezed == gameNotes
          ? _value.gameNotes
          : gameNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      isBeingTracked: null == isBeingTracked
          ? _value.isBeingTracked
          : isBeingTracked // ignore: cast_nullable_to_non_nullable
              as bool,
      trackedByUserId: freezed == trackedByUserId
          ? _value.trackedByUserId
          : trackedByUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      trackedByUserName: freezed == trackedByUserName
          ? _value.trackedByUserName
          : trackedByUserName // ignore: cast_nullable_to_non_nullable
              as String?,
      isSimpleTracking: null == isSimpleTracking
          ? _value.isSimpleTracking
          : isSimpleTracking // ignore: cast_nullable_to_non_nullable
              as bool,
      isSynced: null == isSynced
          ? _value.isSynced
          : isSynced // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSyncedAt: freezed == lastSyncedAt
          ? _value.lastSyncedAt
          : lastSyncedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameImpl implements _Game {
  const _$GameImpl(
      {required this.id,
      this.tournamentId,
      this.poolId,
      this.bracketPosition,
      required this.homeTeamId,
      required this.awayTeamId,
      required this.homeTeamName,
      required this.awayTeamName,
      this.homeTeamLogo,
      this.awayTeamLogo,
      this.homeScore = 0,
      this.awayScore = 0,
      this.halftimeHomeScore,
      this.halftimeAwayScore,
      this.gameToPoints = 15,
      this.originalGameToPoints,
      this.hardCapPoints = 17,
      this.halftimeAtOverride,
      this.softCapMinutes = 75,
      this.hardCapMinutes = 90,
      this.status = GameStatus.scheduled,
      this.currentPoint = 1,
      this.currentPossession,
      this.scheduledAt,
      this.startedAt,
      this.halftimeStartedAt,
      this.softCapStartedAt,
      this.hardCapStartedAt,
      this.endedAt,
      this.isDelayed = false,
      this.delayReason,
      this.delayNotes,
      this.delayStartedAt,
      this.windSpeed,
      this.windDirection,
      this.weatherNotes,
      this.gameNotes,
      this.isBeingTracked = false,
      this.trackedByUserId,
      this.trackedByUserName,
      this.isSimpleTracking = true,
      this.isSynced = false,
      this.lastSyncedAt,
      required this.createdAt,
      required this.updatedAt});

  factory _$GameImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameImplFromJson(json);

  @override
  final String id;
  @override
  final String? tournamentId;
  @override
  final String? poolId;
  @override
  final String? bracketPosition;
// Teams
  @override
  final String homeTeamId;
  @override
  final String awayTeamId;
  @override
  final String homeTeamName;
  @override
  final String awayTeamName;
  @override
  final String? homeTeamLogo;
  @override
  final String? awayTeamLogo;
// Score
  @override
  @JsonKey()
  final int homeScore;
  @override
  @JsonKey()
  final int awayScore;
  @override
  final int? halftimeHomeScore;
  @override
  final int? halftimeAwayScore;
// Game settings
  @override
  @JsonKey()
  final int gameToPoints;
// Current target (changes when caps hit)
  @override
  final int? originalGameToPoints;
// Original target (for halftime calculation), null = same as gameToPoints
  @override
  @JsonKey()
  final int hardCapPoints;
  @override
  final int? halftimeAtOverride;
// Optional override, null = use formula: (gameToPoints / 2).ceil()
  @override
  @JsonKey()
  final int softCapMinutes;
  @override
  @JsonKey()
  final int hardCapMinutes;
// Status
  @override
  @JsonKey()
  final GameStatus status;
  @override
  @JsonKey()
  final int currentPoint;
  @override
  final String? currentPossession;
// teamId
// Timing
  @override
  final DateTime? scheduledAt;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? halftimeStartedAt;
  @override
  final DateTime? softCapStartedAt;
  @override
  final DateTime? hardCapStartedAt;
  @override
  final DateTime? endedAt;
// Delays
  @override
  @JsonKey()
  final bool isDelayed;
  @override
  final DelayReason? delayReason;
  @override
  final String? delayNotes;
  @override
  final DateTime? delayStartedAt;
// Conditions
  @override
  final String? windSpeed;
  @override
  final String? windDirection;
  @override
  final String? weatherNotes;
  @override
  final String? gameNotes;
// Post-game notes (injuries, notable plays, comments)
// Tracking
  @override
  @JsonKey()
  final bool isBeingTracked;
  @override
  final String? trackedByUserId;
  @override
  final String? trackedByUserName;
  @override
  @JsonKey()
  final bool isSimpleTracking;
// Simple mode = faster entry, Advanced = full stats
// Sync
  @override
  @JsonKey()
  final bool isSynced;
  @override
  final DateTime? lastSyncedAt;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Game(id: $id, tournamentId: $tournamentId, poolId: $poolId, bracketPosition: $bracketPosition, homeTeamId: $homeTeamId, awayTeamId: $awayTeamId, homeTeamName: $homeTeamName, awayTeamName: $awayTeamName, homeTeamLogo: $homeTeamLogo, awayTeamLogo: $awayTeamLogo, homeScore: $homeScore, awayScore: $awayScore, halftimeHomeScore: $halftimeHomeScore, halftimeAwayScore: $halftimeAwayScore, gameToPoints: $gameToPoints, originalGameToPoints: $originalGameToPoints, hardCapPoints: $hardCapPoints, halftimeAtOverride: $halftimeAtOverride, softCapMinutes: $softCapMinutes, hardCapMinutes: $hardCapMinutes, status: $status, currentPoint: $currentPoint, currentPossession: $currentPossession, scheduledAt: $scheduledAt, startedAt: $startedAt, halftimeStartedAt: $halftimeStartedAt, softCapStartedAt: $softCapStartedAt, hardCapStartedAt: $hardCapStartedAt, endedAt: $endedAt, isDelayed: $isDelayed, delayReason: $delayReason, delayNotes: $delayNotes, delayStartedAt: $delayStartedAt, windSpeed: $windSpeed, windDirection: $windDirection, weatherNotes: $weatherNotes, gameNotes: $gameNotes, isBeingTracked: $isBeingTracked, trackedByUserId: $trackedByUserId, trackedByUserName: $trackedByUserName, isSimpleTracking: $isSimpleTracking, isSynced: $isSynced, lastSyncedAt: $lastSyncedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.tournamentId, tournamentId) ||
                other.tournamentId == tournamentId) &&
            (identical(other.poolId, poolId) || other.poolId == poolId) &&
            (identical(other.bracketPosition, bracketPosition) ||
                other.bracketPosition == bracketPosition) &&
            (identical(other.homeTeamId, homeTeamId) ||
                other.homeTeamId == homeTeamId) &&
            (identical(other.awayTeamId, awayTeamId) ||
                other.awayTeamId == awayTeamId) &&
            (identical(other.homeTeamName, homeTeamName) ||
                other.homeTeamName == homeTeamName) &&
            (identical(other.awayTeamName, awayTeamName) ||
                other.awayTeamName == awayTeamName) &&
            (identical(other.homeTeamLogo, homeTeamLogo) ||
                other.homeTeamLogo == homeTeamLogo) &&
            (identical(other.awayTeamLogo, awayTeamLogo) ||
                other.awayTeamLogo == awayTeamLogo) &&
            (identical(other.homeScore, homeScore) ||
                other.homeScore == homeScore) &&
            (identical(other.awayScore, awayScore) ||
                other.awayScore == awayScore) &&
            (identical(other.halftimeHomeScore, halftimeHomeScore) ||
                other.halftimeHomeScore == halftimeHomeScore) &&
            (identical(other.halftimeAwayScore, halftimeAwayScore) ||
                other.halftimeAwayScore == halftimeAwayScore) &&
            (identical(other.gameToPoints, gameToPoints) ||
                other.gameToPoints == gameToPoints) &&
            (identical(other.originalGameToPoints, originalGameToPoints) ||
                other.originalGameToPoints == originalGameToPoints) &&
            (identical(other.hardCapPoints, hardCapPoints) ||
                other.hardCapPoints == hardCapPoints) &&
            (identical(other.halftimeAtOverride, halftimeAtOverride) ||
                other.halftimeAtOverride == halftimeAtOverride) &&
            (identical(other.softCapMinutes, softCapMinutes) ||
                other.softCapMinutes == softCapMinutes) &&
            (identical(other.hardCapMinutes, hardCapMinutes) ||
                other.hardCapMinutes == hardCapMinutes) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.currentPoint, currentPoint) ||
                other.currentPoint == currentPoint) &&
            (identical(other.currentPossession, currentPossession) ||
                other.currentPossession == currentPossession) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.halftimeStartedAt, halftimeStartedAt) ||
                other.halftimeStartedAt == halftimeStartedAt) &&
            (identical(other.softCapStartedAt, softCapStartedAt) ||
                other.softCapStartedAt == softCapStartedAt) &&
            (identical(other.hardCapStartedAt, hardCapStartedAt) ||
                other.hardCapStartedAt == hardCapStartedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.isDelayed, isDelayed) ||
                other.isDelayed == isDelayed) &&
            (identical(other.delayReason, delayReason) ||
                other.delayReason == delayReason) &&
            (identical(other.delayNotes, delayNotes) ||
                other.delayNotes == delayNotes) &&
            (identical(other.delayStartedAt, delayStartedAt) ||
                other.delayStartedAt == delayStartedAt) &&
            (identical(other.windSpeed, windSpeed) ||
                other.windSpeed == windSpeed) &&
            (identical(other.windDirection, windDirection) ||
                other.windDirection == windDirection) &&
            (identical(other.weatherNotes, weatherNotes) ||
                other.weatherNotes == weatherNotes) &&
            (identical(other.gameNotes, gameNotes) ||
                other.gameNotes == gameNotes) &&
            (identical(other.isBeingTracked, isBeingTracked) ||
                other.isBeingTracked == isBeingTracked) &&
            (identical(other.trackedByUserId, trackedByUserId) ||
                other.trackedByUserId == trackedByUserId) &&
            (identical(other.trackedByUserName, trackedByUserName) ||
                other.trackedByUserName == trackedByUserName) &&
            (identical(other.isSimpleTracking, isSimpleTracking) ||
                other.isSimpleTracking == isSimpleTracking) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced) &&
            (identical(other.lastSyncedAt, lastSyncedAt) ||
                other.lastSyncedAt == lastSyncedAt) &&
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
        tournamentId,
        poolId,
        bracketPosition,
        homeTeamId,
        awayTeamId,
        homeTeamName,
        awayTeamName,
        homeTeamLogo,
        awayTeamLogo,
        homeScore,
        awayScore,
        halftimeHomeScore,
        halftimeAwayScore,
        gameToPoints,
        originalGameToPoints,
        hardCapPoints,
        halftimeAtOverride,
        softCapMinutes,
        hardCapMinutes,
        status,
        currentPoint,
        currentPossession,
        scheduledAt,
        startedAt,
        halftimeStartedAt,
        softCapStartedAt,
        hardCapStartedAt,
        endedAt,
        isDelayed,
        delayReason,
        delayNotes,
        delayStartedAt,
        windSpeed,
        windDirection,
        weatherNotes,
        gameNotes,
        isBeingTracked,
        trackedByUserId,
        trackedByUserName,
        isSimpleTracking,
        isSynced,
        lastSyncedAt,
        createdAt,
        updatedAt
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameImplCopyWith<_$GameImpl> get copyWith =>
      __$$GameImplCopyWithImpl<_$GameImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameImplToJson(
      this,
    );
  }
}

abstract class _Game implements Game {
  const factory _Game(
      {required final String id,
      final String? tournamentId,
      final String? poolId,
      final String? bracketPosition,
      required final String homeTeamId,
      required final String awayTeamId,
      required final String homeTeamName,
      required final String awayTeamName,
      final String? homeTeamLogo,
      final String? awayTeamLogo,
      final int homeScore,
      final int awayScore,
      final int? halftimeHomeScore,
      final int? halftimeAwayScore,
      final int gameToPoints,
      final int? originalGameToPoints,
      final int hardCapPoints,
      final int? halftimeAtOverride,
      final int softCapMinutes,
      final int hardCapMinutes,
      final GameStatus status,
      final int currentPoint,
      final String? currentPossession,
      final DateTime? scheduledAt,
      final DateTime? startedAt,
      final DateTime? halftimeStartedAt,
      final DateTime? softCapStartedAt,
      final DateTime? hardCapStartedAt,
      final DateTime? endedAt,
      final bool isDelayed,
      final DelayReason? delayReason,
      final String? delayNotes,
      final DateTime? delayStartedAt,
      final String? windSpeed,
      final String? windDirection,
      final String? weatherNotes,
      final String? gameNotes,
      final bool isBeingTracked,
      final String? trackedByUserId,
      final String? trackedByUserName,
      final bool isSimpleTracking,
      final bool isSynced,
      final DateTime? lastSyncedAt,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$GameImpl;

  factory _Game.fromJson(Map<String, dynamic> json) = _$GameImpl.fromJson;

  @override
  String get id;
  @override
  String? get tournamentId;
  @override
  String? get poolId;
  @override
  String? get bracketPosition;
  @override // Teams
  String get homeTeamId;
  @override
  String get awayTeamId;
  @override
  String get homeTeamName;
  @override
  String get awayTeamName;
  @override
  String? get homeTeamLogo;
  @override
  String? get awayTeamLogo;
  @override // Score
  int get homeScore;
  @override
  int get awayScore;
  @override
  int? get halftimeHomeScore;
  @override
  int? get halftimeAwayScore;
  @override // Game settings
  int get gameToPoints;
  @override // Current target (changes when caps hit)
  int? get originalGameToPoints;
  @override // Original target (for halftime calculation), null = same as gameToPoints
  int get hardCapPoints;
  @override
  int? get halftimeAtOverride;
  @override // Optional override, null = use formula: (gameToPoints / 2).ceil()
  int get softCapMinutes;
  @override
  int get hardCapMinutes;
  @override // Status
  GameStatus get status;
  @override
  int get currentPoint;
  @override
  String? get currentPossession;
  @override // teamId
// Timing
  DateTime? get scheduledAt;
  @override
  DateTime? get startedAt;
  @override
  DateTime? get halftimeStartedAt;
  @override
  DateTime? get softCapStartedAt;
  @override
  DateTime? get hardCapStartedAt;
  @override
  DateTime? get endedAt;
  @override // Delays
  bool get isDelayed;
  @override
  DelayReason? get delayReason;
  @override
  String? get delayNotes;
  @override
  DateTime? get delayStartedAt;
  @override // Conditions
  String? get windSpeed;
  @override
  String? get windDirection;
  @override
  String? get weatherNotes;
  @override
  String? get gameNotes;
  @override // Post-game notes (injuries, notable plays, comments)
// Tracking
  bool get isBeingTracked;
  @override
  String? get trackedByUserId;
  @override
  String? get trackedByUserName;
  @override
  bool get isSimpleTracking;
  @override // Simple mode = faster entry, Advanced = full stats
// Sync
  bool get isSynced;
  @override
  DateTime? get lastSyncedAt;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$GameImplCopyWith<_$GameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QuickGameSetup _$QuickGameSetupFromJson(Map<String, dynamic> json) {
  return _QuickGameSetup.fromJson(json);
}

/// @nodoc
mixin _$QuickGameSetup {
  String get homeTeamName => throw _privateConstructorUsedError;
  String get awayTeamName => throw _privateConstructorUsedError;
  int get gameToPoints => throw _privateConstructorUsedError;
  int get hardCapPoints => throw _privateConstructorUsedError;
  int get softCapMinutes => throw _privateConstructorUsedError;
  int get hardCapMinutes => throw _privateConstructorUsedError;
  String? get windSpeed => throw _privateConstructorUsedError;
  String? get windDirection => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QuickGameSetupCopyWith<QuickGameSetup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuickGameSetupCopyWith<$Res> {
  factory $QuickGameSetupCopyWith(
          QuickGameSetup value, $Res Function(QuickGameSetup) then) =
      _$QuickGameSetupCopyWithImpl<$Res, QuickGameSetup>;
  @useResult
  $Res call(
      {String homeTeamName,
      String awayTeamName,
      int gameToPoints,
      int hardCapPoints,
      int softCapMinutes,
      int hardCapMinutes,
      String? windSpeed,
      String? windDirection});
}

/// @nodoc
class _$QuickGameSetupCopyWithImpl<$Res, $Val extends QuickGameSetup>
    implements $QuickGameSetupCopyWith<$Res> {
  _$QuickGameSetupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeTeamName = null,
    Object? awayTeamName = null,
    Object? gameToPoints = null,
    Object? hardCapPoints = null,
    Object? softCapMinutes = null,
    Object? hardCapMinutes = null,
    Object? windSpeed = freezed,
    Object? windDirection = freezed,
  }) {
    return _then(_value.copyWith(
      homeTeamName: null == homeTeamName
          ? _value.homeTeamName
          : homeTeamName // ignore: cast_nullable_to_non_nullable
              as String,
      awayTeamName: null == awayTeamName
          ? _value.awayTeamName
          : awayTeamName // ignore: cast_nullable_to_non_nullable
              as String,
      gameToPoints: null == gameToPoints
          ? _value.gameToPoints
          : gameToPoints // ignore: cast_nullable_to_non_nullable
              as int,
      hardCapPoints: null == hardCapPoints
          ? _value.hardCapPoints
          : hardCapPoints // ignore: cast_nullable_to_non_nullable
              as int,
      softCapMinutes: null == softCapMinutes
          ? _value.softCapMinutes
          : softCapMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      hardCapMinutes: null == hardCapMinutes
          ? _value.hardCapMinutes
          : hardCapMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      windSpeed: freezed == windSpeed
          ? _value.windSpeed
          : windSpeed // ignore: cast_nullable_to_non_nullable
              as String?,
      windDirection: freezed == windDirection
          ? _value.windDirection
          : windDirection // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QuickGameSetupImplCopyWith<$Res>
    implements $QuickGameSetupCopyWith<$Res> {
  factory _$$QuickGameSetupImplCopyWith(_$QuickGameSetupImpl value,
          $Res Function(_$QuickGameSetupImpl) then) =
      __$$QuickGameSetupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String homeTeamName,
      String awayTeamName,
      int gameToPoints,
      int hardCapPoints,
      int softCapMinutes,
      int hardCapMinutes,
      String? windSpeed,
      String? windDirection});
}

/// @nodoc
class __$$QuickGameSetupImplCopyWithImpl<$Res>
    extends _$QuickGameSetupCopyWithImpl<$Res, _$QuickGameSetupImpl>
    implements _$$QuickGameSetupImplCopyWith<$Res> {
  __$$QuickGameSetupImplCopyWithImpl(
      _$QuickGameSetupImpl _value, $Res Function(_$QuickGameSetupImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeTeamName = null,
    Object? awayTeamName = null,
    Object? gameToPoints = null,
    Object? hardCapPoints = null,
    Object? softCapMinutes = null,
    Object? hardCapMinutes = null,
    Object? windSpeed = freezed,
    Object? windDirection = freezed,
  }) {
    return _then(_$QuickGameSetupImpl(
      homeTeamName: null == homeTeamName
          ? _value.homeTeamName
          : homeTeamName // ignore: cast_nullable_to_non_nullable
              as String,
      awayTeamName: null == awayTeamName
          ? _value.awayTeamName
          : awayTeamName // ignore: cast_nullable_to_non_nullable
              as String,
      gameToPoints: null == gameToPoints
          ? _value.gameToPoints
          : gameToPoints // ignore: cast_nullable_to_non_nullable
              as int,
      hardCapPoints: null == hardCapPoints
          ? _value.hardCapPoints
          : hardCapPoints // ignore: cast_nullable_to_non_nullable
              as int,
      softCapMinutes: null == softCapMinutes
          ? _value.softCapMinutes
          : softCapMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      hardCapMinutes: null == hardCapMinutes
          ? _value.hardCapMinutes
          : hardCapMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      windSpeed: freezed == windSpeed
          ? _value.windSpeed
          : windSpeed // ignore: cast_nullable_to_non_nullable
              as String?,
      windDirection: freezed == windDirection
          ? _value.windDirection
          : windDirection // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QuickGameSetupImpl implements _QuickGameSetup {
  const _$QuickGameSetupImpl(
      {required this.homeTeamName,
      required this.awayTeamName,
      this.gameToPoints = 15,
      this.hardCapPoints = 17,
      this.softCapMinutes = 75,
      this.hardCapMinutes = 90,
      this.windSpeed,
      this.windDirection});

  factory _$QuickGameSetupImpl.fromJson(Map<String, dynamic> json) =>
      _$$QuickGameSetupImplFromJson(json);

  @override
  final String homeTeamName;
  @override
  final String awayTeamName;
  @override
  @JsonKey()
  final int gameToPoints;
  @override
  @JsonKey()
  final int hardCapPoints;
  @override
  @JsonKey()
  final int softCapMinutes;
  @override
  @JsonKey()
  final int hardCapMinutes;
  @override
  final String? windSpeed;
  @override
  final String? windDirection;

  @override
  String toString() {
    return 'QuickGameSetup(homeTeamName: $homeTeamName, awayTeamName: $awayTeamName, gameToPoints: $gameToPoints, hardCapPoints: $hardCapPoints, softCapMinutes: $softCapMinutes, hardCapMinutes: $hardCapMinutes, windSpeed: $windSpeed, windDirection: $windDirection)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuickGameSetupImpl &&
            (identical(other.homeTeamName, homeTeamName) ||
                other.homeTeamName == homeTeamName) &&
            (identical(other.awayTeamName, awayTeamName) ||
                other.awayTeamName == awayTeamName) &&
            (identical(other.gameToPoints, gameToPoints) ||
                other.gameToPoints == gameToPoints) &&
            (identical(other.hardCapPoints, hardCapPoints) ||
                other.hardCapPoints == hardCapPoints) &&
            (identical(other.softCapMinutes, softCapMinutes) ||
                other.softCapMinutes == softCapMinutes) &&
            (identical(other.hardCapMinutes, hardCapMinutes) ||
                other.hardCapMinutes == hardCapMinutes) &&
            (identical(other.windSpeed, windSpeed) ||
                other.windSpeed == windSpeed) &&
            (identical(other.windDirection, windDirection) ||
                other.windDirection == windDirection));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      homeTeamName,
      awayTeamName,
      gameToPoints,
      hardCapPoints,
      softCapMinutes,
      hardCapMinutes,
      windSpeed,
      windDirection);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$QuickGameSetupImplCopyWith<_$QuickGameSetupImpl> get copyWith =>
      __$$QuickGameSetupImplCopyWithImpl<_$QuickGameSetupImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QuickGameSetupImplToJson(
      this,
    );
  }
}

abstract class _QuickGameSetup implements QuickGameSetup {
  const factory _QuickGameSetup(
      {required final String homeTeamName,
      required final String awayTeamName,
      final int gameToPoints,
      final int hardCapPoints,
      final int softCapMinutes,
      final int hardCapMinutes,
      final String? windSpeed,
      final String? windDirection}) = _$QuickGameSetupImpl;

  factory _QuickGameSetup.fromJson(Map<String, dynamic> json) =
      _$QuickGameSetupImpl.fromJson;

  @override
  String get homeTeamName;
  @override
  String get awayTeamName;
  @override
  int get gameToPoints;
  @override
  int get hardCapPoints;
  @override
  int get softCapMinutes;
  @override
  int get hardCapMinutes;
  @override
  String? get windSpeed;
  @override
  String? get windDirection;
  @override
  @JsonKey(ignore: true)
  _$$QuickGameSetupImplCopyWith<_$QuickGameSetupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
