import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/servidor_ssh.dart';

class PantallaDetalle extends StatelessWidget {
  final String      id;
  final ServidorSSH? servidor;

  const PantallaDetalle({super.key, required this.id, this.servidor});

  @override
  Widget build(BuildContext context) {
    final srv = servidor ??
        servidoresSimulados.where((s) => s.id == id).firstOrNull;

    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title:           Text('Curso: ${srv?.nombre ?? id}'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
      ),
      body: srv == null
          ? Center(child: Text('Curso $id no encontrado'))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Fila('ID',           srv.id),
                  _Fila('Nombre',       srv.nombre),
                  _Fila('Idioma',       srv.idioma),
                  _Fila('Nivel MCER',   srv.nivel),
                  _Fila('Duración',     '${srv.duracionHoras} horas'),
                  _Fila('Certificado',  srv.certificado ? 'Incluye certificado' : 'Sin certificado'),
                  const SizedBox(height: 24),
                  Row(children: [
                    OutlinedButton.icon(
                      onPressed: () => context.pop(),
                      icon:  const Icon(Icons.arrow_back),
                      label: const Text('Volver a cursos'),
                    ),
                    const SizedBox(width: 12),
                    FilledButton.icon(
                      onPressed: () => context.push('/cursos/${srv.id}/lecciones'),
                      icon:  const Icon(Icons.menu_book),
                      label: const Text('Ver lecciones'),
                    ),
                  ]),
                ],
              ),
            ),
    );
  }
}

class _Fila extends StatelessWidget {
  final String label;
  final String valor;
  const _Fila(this.label, this.valor);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(children: [
        SizedBox(
          width: 110,
          child: Text(label,
              style: TextStyle(color: cs.onSurfaceVariant,
                  fontWeight: FontWeight.w600, fontSize: 12)),
        ),
        Text(valor, style: const TextStyle(fontSize: 15)),
      ]),
    );
  }
}
