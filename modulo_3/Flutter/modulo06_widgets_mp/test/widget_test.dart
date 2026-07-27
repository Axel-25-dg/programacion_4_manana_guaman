import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:modulo06_widgets/main.dart';

void main() {
  testWidgets('Verifica que la aplicación corra según el paso actual', (WidgetTester tester) async {
    // Construye la aplicación basada en el main actual
    await tester.pumpWidget(
      MaterialApp(
        home: switch (paso) {
          1 => const Scaffold(body: Center(child: Saludo())),
          _ => const Scaffold(body: Text('Test genérico')),
        },
      ),
    );

    // Agrega tus verificaciones según el paso que estés probando
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}