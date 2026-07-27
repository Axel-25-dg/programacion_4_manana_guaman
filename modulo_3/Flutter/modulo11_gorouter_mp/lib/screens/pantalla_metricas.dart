import 'package:flutter/material.dart';

class PantallaMetricas extends StatelessWidget {
  const PantallaMetricas({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: const Center(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.show_chart, size: 56),
        SizedBox(height: 8),
        Text('Mi Progreso de Aprendizaje', style: TextStyle(fontSize: 18)),
      ],
    )),
  );
}
