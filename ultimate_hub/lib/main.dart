import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'core/services/supabase_client.dart';
import 'core/storage/hive_adapters.dart';
import 'features/live_game/domain/entities/game.dart';
import 'features/live_game/domain/entities/play.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  // NOTE: You must create a .env file with your Supabase credentials
  // Copy .env.example to .env and fill in your values from https://app.supabase.com
  await dotenv.load(fileName: ".env");

  // Initialize Supabase before everything else
  await SupabaseService.init(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  // Set preferred orientations (allow both portrait and landscape for field tracking)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF0A1628),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // Initialize Hive for local storage
  await Hive.initFlutter();

  // Register Hive type adapters
  registerHiveAdapters();

  // Open Hive boxes for offline-first data storage
  await Hive.openBox<Game>('games');
  await Hive.openBox<Play>('plays');
  await Hive.openBox<GamePoint>('game_points');
  await Hive.openBox<Map>('sync_queue'); // For offline sync queue

  runApp(
    const ProviderScope(
      child: UltimateHubApp(),
    ),
  );
}
