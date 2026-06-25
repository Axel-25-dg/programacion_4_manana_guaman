import 'package:flutter_test/flutter_test.dart';
import 'package:modulo09_formularios/main.dart' as app;

void main() {
  testWidgets('SSH Connection form smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    app.main();
    await tester.pumpAndSettle();

    // Verify that the Step 3 components are present.
    expect(find.text('Servidores (4)'), findsOneWidget);
    expect(find.text('prod-web-01'), findsOneWidget);
    expect(find.text('prod-db-01'), findsOneWidget);
    expect(find.text('staging-api'), findsOneWidget);
    expect(find.text('dev-sandbox'), findsOneWidget);
  });
}
