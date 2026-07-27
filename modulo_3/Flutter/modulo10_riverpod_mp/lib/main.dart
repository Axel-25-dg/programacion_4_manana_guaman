import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'screens/pantalla_servidores.dart';
import 'screens/pantalla_busqueda.dart';
import 'screens/pantalla_metricas.dart';
import 'screens/pantalla_dashboard.dart';

const int paso = 5;

final contadorProvider = StateProvider<int>((ref) => 20);

void main() {
  runApp(const ProviderScope(child: AppIdiomas()));
}

class AppIdiomas extends StatelessWidget {
  const AppIdiomas({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4A148C)),
        useMaterial3: true,
      ),
      home: switch (paso) {
        1 => const _Paso1(),
        2 => const PantallaServidores(),
        3 => const PantallaBusqueda(),
        4 => const PantallaMetricas(),
        5 => const PantallaDashboard(),
        _ => Scaffold(
            body: Center(child: Text('Paso $paso: crea el widget primero'))),
      },
    );
  }
}

class _Paso1 extends ConsumerWidget {
  const _Paso1();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(contadorProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Palabras aprendidas hoy')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$count', style: Theme.of(context).textTheme.displayLarge),
            const Text('palabras nuevas hoy'),
            const SizedBox(height: 8),
            Icon(
              count >= 30 ? Icons.emoji_events : (count >= 15 ? Icons.local_fire_department : Icons.lightbulb),
              color: count >= 30 ? Colors.amber : Colors.deepPurple,
              size: 42,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'add',
            onPressed: () => ref.read(contadorProvider.notifier).state++,
            tooltip: 'Aprendí una palabra',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'rem',
            onPressed: () {
              if (ref.read(contadorProvider) > 0) {
                ref.read(contadorProvider.notifier).state--;
              }
            },
            tooltip: 'Descontar palabra',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
