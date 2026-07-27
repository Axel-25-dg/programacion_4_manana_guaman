import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/servidor_ssh.dart';

class PantallaServidores extends StatelessWidget {
  const PantallaServidores({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final servidores = servidoresSimulados;

    return Scaffold(
      appBar: AppBar(
        title:           const Text('Mis Cursos'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
      ),
      body: ListView.builder(
        itemCount:   servidores.length,
        itemBuilder: (context, i) {
          final s = servidores[i];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: s.certificado
                  ? cs.primaryContainer
                  : cs.surfaceContainerHighest,
              child: Icon(Icons.language,
                  color: s.certificado ? cs.onPrimaryContainer : cs.onSurfaceVariant,
                  size: 20),
            ),
            title: Text(s.nombre),
            subtitle: Text('${s.idioma} · Nivel ${s.nivel} · ${s.duracionHoras}h'),
            onTap: () {
              context.push(
                '/cursos/${s.id}',
                extra: s,
              );
            },
          );
        },
      ),
    );
  }
}
