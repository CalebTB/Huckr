import 'package:supabase_flutter/supabase_flutter.dart';

/// Singleton service for Supabase client
/// Provides a single point of access to the Supabase client throughout the app
class SupabaseService {
  static SupabaseClient? _client;

  /// Get the Supabase client instance
  /// Throws an exception if Supabase has not been initialized
  static SupabaseClient get client {
    if (_client == null) {
      throw Exception(
        'Supabase not initialized. Call SupabaseService.init() first.',
      );
    }
    return _client!;
  }

  /// Initialize Supabase with URL and anon key
  /// Must be called before accessing the client
  ///
  /// Usage:
  /// ```dart
  /// await SupabaseService.init(
  ///   url: 'https://your-project.supabase.co',
  ///   anonKey: 'your-anon-key',
  /// );
  /// ```
  static Future<void> init({
    required String url,
    required String anonKey,
  }) async {
    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
      ),
    );
    _client = Supabase.instance.client;
  }

  /// Check if Supabase has been initialized
  static bool get isInitialized => _client != null;
}
