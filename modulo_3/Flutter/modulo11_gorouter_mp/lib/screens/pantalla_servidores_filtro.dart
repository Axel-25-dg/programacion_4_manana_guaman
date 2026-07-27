import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/servidor_ssh.dart';

class PantallaServidoresFiltro extends StatelessWidget {
  final bool soloCertificado;
  const PantallaServidoresFiltro({super.key, this.soloCertificado = false});

  @override
  Widget build(BuildContext context) {
    final filtrados = soloCertificado
        ? servidoresSimulados.where((s) => s.certificado).toList()
        : servidoresSimulados;

    return Scaffold(
      appBar: AppBar(
        title:   Text('Mis Cursos${soloCertificado ? ' (con Certificado)' : ''}'),
        actions: [
          IconButton(
            icon:    Icon(soloCertificado ? Icons.workspace_premium : Icons.workspace_premium_outlined),
            tooltip: soloCertificado ? 'Ver todos' : 'Solo con certificado',
            onPressed: () => soloCertificado
                ? context.go('/cursos')
                : context.go('/cursos?soloCertificado=true'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount:   filtrados.length,
        itemBuilder: (context, i) {
          final s = filtrados[i];
          return ListTile(
            leading: Icon(Icons.language,
                color: s.certificado ? Colors.green : Colors.grey),
            title:    Text(s.nombre),
            subtitle: Text('${s.idioma} · Nivel ${s.nivel}'),
            onTap: () => context.push(
              '/cursos/${s.id}',
              extra: s,
            ),
          );
        },
      ),
    );
  }
}
