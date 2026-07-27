// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modulo10_riverpod/main.dart';

void main() {
  testWidgets('Servers list smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: AppMonitoreo()));

    // Verify that our servers are listed.
    expect(find.text('prod-web-01'), findsOneWidget);
    expect(find.text('prod-db-01'), findsOneWidget);
    expect(find.text('staging-api'), findsOneWidget);
  });
}
