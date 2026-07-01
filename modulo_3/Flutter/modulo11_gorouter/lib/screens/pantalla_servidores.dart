// lib/screens/pantalla_servidores.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/servidor_ssh.dart';

class PantallaServidores extends StatelessWidget {
  const PantallaServidores({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final servidores = servidoresSimulados; // Simulación de datos

    return Scaffold(
      appBar: AppBar(
        title:           const Text('Servidores'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
      ),
      body: ListView.builder(
        itemCount:   servidores.length,
        itemBuilder: (context, i) {
          final s = servidores[i];
          return ListTile(
            leading: const Icon(Icons.dns),
            title: Text(s.nombre),
            onTap: () {
              // Navegar con extras — pasa el objeto completo evitando una segunda búsqueda
              context.push(
                '/servidores/${s.id}',
                extra: s,   // ServidorSSH completo
              );
            },
          );
        },
      ),
    );
  }
}
