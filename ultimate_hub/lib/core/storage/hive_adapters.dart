import 'package:hive/hive.dart';
import 'package:ultimate_hub/features/live_game/domain/entities/game.dart';
import 'package:ultimate_hub/features/live_game/domain/entities/play.dart';
import 'package:ultimate_hub/core/enums/game_status.dart';
import 'package:ultimate_hub/core/enums/play_type.dart';
import 'package:ultimate_hub/core/enums/line_type.dart';
import 'package:ultimate_hub/core/enums/delay_reason.dart';

/// Hive type adapters for Ultimate Hub entities and enums
///
/// Strategy: Use Freezed JSON serialization with Hive instead of field-by-field adapters
/// This provides a single source of truth for serialization and simplifies maintenance.
///
/// Type IDs:
/// - 0-9: Entity adapters
/// - 10-19: Enum adapters

// ============================================================================
// ENTITY ADAPTERS
// ============================================================================

/// Hive adapter for Game entity
/// Uses Freezed's JSON serialization for persistence
class GameAdapter extends TypeAdapter<Game> {
  @override
  final int typeId = 0;

  @override
  Game read(BinaryReader reader) {
    final json = reader.readMap().cast<String, dynamic>();
    return Game.fromJson(json);
  }

  @override
  void write(BinaryWriter writer, Game obj) {
    writer.writeMap(obj.toJson());
  }
}

/// Hive adapter for Play entity
/// Uses Freezed's JSON serialization for persistence
class PlayAdapter extends TypeAdapter<Play> {
  @override
  final int typeId = 1;

  @override
  Play read(BinaryReader reader) {
    final json = reader.readMap().cast<String, dynamic>();
    return Play.fromJson(json);
  }

  @override
  void write(BinaryWriter writer, Play obj) {
    writer.writeMap(obj.toJson());
  }
}

/// Hive adapter for GamePoint entity
/// Uses Freezed's JSON serialization for persistence
class GamePointAdapter extends TypeAdapter<GamePoint> {
  @override
  final int typeId = 2;

  @override
  GamePoint read(BinaryReader reader) {
    final json = reader.readMap().cast<String, dynamic>();
    return GamePoint.fromJson(json);
  }

  @override
  void write(BinaryWriter writer, GamePoint obj) {
    writer.writeMap(obj.toJson());
  }
}

/// Hive adapter for FieldPosition entity
/// Uses Freezed's JSON serialization for persistence
class FieldPositionAdapter extends TypeAdapter<FieldPosition> {
  @override
  final int typeId = 3;

  @override
  FieldPosition read(BinaryReader reader) {
    final json = reader.readMap().cast<String, dynamic>();
    return FieldPosition.fromJson(json);
  }

  @override
  void write(BinaryWriter writer, FieldPosition obj) {
    writer.writeMap(obj.toJson());
  }
}

// ============================================================================
// ENUM ADAPTERS
// ============================================================================

/// Hive adapter for GameStatus enum
/// Stores as byte index for efficiency
class GameStatusAdapter extends TypeAdapter<GameStatus> {
  @override
  final int typeId = 10;

  @override
  GameStatus read(BinaryReader reader) {
    final index = reader.readByte();
    return GameStatus.values[index];
  }

  @override
  void write(BinaryWriter writer, GameStatus obj) {
    writer.writeByte(obj.index);
  }
}

/// Hive adapter for PlayType enum
/// Stores as byte index for efficiency
class PlayTypeAdapter extends TypeAdapter<PlayType> {
  @override
  final int typeId = 11;

  @override
  PlayType read(BinaryReader reader) {
    final index = reader.readByte();
    return PlayType.values[index];
  }

  @override
  void write(BinaryWriter writer, PlayType obj) {
    writer.writeByte(obj.index);
  }
}

/// Hive adapter for LineType enum
/// Stores as byte index for efficiency
class LineTypeAdapter extends TypeAdapter<LineType> {
  @override
  final int typeId = 12;

  @override
  LineType read(BinaryReader reader) {
    final index = reader.readByte();
    return LineType.values[index];
  }

  @override
  void write(BinaryWriter writer, LineType obj) {
    writer.writeByte(obj.index);
  }
}

/// Hive adapter for DelayReason enum
/// Stores as byte index for efficiency
class DelayReasonAdapter extends TypeAdapter<DelayReason> {
  @override
  final int typeId = 13;

  @override
  DelayReason read(BinaryReader reader) {
    final index = reader.readByte();
    return DelayReason.values[index];
  }

  @override
  void write(BinaryWriter writer, DelayReason obj) {
    writer.writeByte(obj.index);
  }
}

/// Register all Hive type adapters
///
/// Call this function in main.dart before opening Hive boxes
///
/// Example:
/// ```dart
/// await Hive.initFlutter();
/// registerHiveAdapters();
/// await Hive.openBox<Game>('games');
/// ```
void registerHiveAdapters() {
  // Register entity adapters
  Hive.registerAdapter(GameAdapter());
  Hive.registerAdapter(PlayAdapter());
  Hive.registerAdapter(GamePointAdapter());
  Hive.registerAdapter(FieldPositionAdapter());

  // Register enum adapters
  Hive.registerAdapter(GameStatusAdapter());
  Hive.registerAdapter(PlayTypeAdapter());
  Hive.registerAdapter(LineTypeAdapter());
  Hive.registerAdapter(DelayReasonAdapter());
}
