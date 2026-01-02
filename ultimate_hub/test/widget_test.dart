// Basic Flutter widget test for Ultimate Hub app

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ultimate_hub/app.dart';

void main() {
  testWidgets('App renders home screen', (WidgetTester tester) async {
    // Build the app with ProviderScope
    await tester.pumpWidget(
      const ProviderScope(
        child: UltimateHubApp(),
      ),
    );

    // Wait for initial frame
    await tester.pumpAndSettle();

    // Verify app title is displayed
    expect(find.text('Ultimate Hub'), findsOneWidget);
  });
}
