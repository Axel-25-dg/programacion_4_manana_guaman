import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/servidor_ssh.dart';
import '../providers/servidores_provider.dart';

class PantallaServidores extends ConsumerWidget {
  const PantallaServidores({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servidores = ref.watch(servidoresProvider);
    final cs         = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title:           Text('Mis cursos (${servidores.length})'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
      ),
      body: servidores.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.translate_outlined, size: 56, color: cs.onSurfaceVariant),
                  const SizedBox(height: 12),
                  Text('Sin cursos inscritos',
                      style: TextStyle(color: cs.onSurfaceVariant)),
                ],
              ),
            )
          : ListView.separated(
              itemCount:        servidores.length,
              separatorBuilder: (_, _) =>
                  const Divider(height: 1, indent: 72),
              itemBuilder: (context, i) {
                final s = servidores[i];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: s.certificado
                        ? cs.primaryContainer
                        : cs.surfaceContainerHighest,
                    child: Icon(Icons.language,
                        color: s.certificado ? cs.onPrimaryContainer : cs.onSurfaceVariant),
                  ),
                  title:    Text(s.nombre,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${s.idioma} · Nivel ${s.nivel} · ${s.duracionHoras}h (${s.modalidad})',
                          style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
                      const SizedBox(height: 2),
                      Text('Categoría: ${s.categoria}',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: cs.primary,
                          )),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          s.favorito ? Icons.star : Icons.star_border,
                          color: s.favorito ? Colors.amber : cs.outline,
                        ),
                        onPressed: () => ref
                            .read(servidoresProvider.notifier)
                            .toggleFavorito(s.id),
                        tooltip: s.favorito ? 'Quitar favorito' : 'Agregar a favoritos',
                      ),
                      IconButton(
                        icon: Icon(Icons.delete_outline, color: cs.error),
                        onPressed: () => ref
                            .read(servidoresProvider.notifier)
                            .eliminar(s.id),
                        tooltip: 'Eliminar curso',
                      ),
                    ],
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final id = DateTime.now().millisecondsSinceEpoch.toString();
          final opciones = [
            ('Coreano para principiantes', 'Coreano', 'A1', 30, 'Online', false, 'conversación'),
            ('Ruso A2', 'Ruso', 'A2', 50, 'Presencial', true, 'gramática'),
            ('Árabe Básico', 'Árabe', 'A1', 45, 'Online', false, 'vocabulario'),
          ];
          final opcion = opciones[(servidores.length) % opciones.length];
          ref.read(servidoresProvider.notifier).agregar(
            ServidorSSH(
              id:          id,
              nombre:      opcion.$1,
              idioma:      opcion.$2,
              nivel:       opcion.$3,
              duracionHoras: opcion.$4,
              modalidad:   opcion.$5,
              certificado: opcion.$6,
              categoria:   opcion.$7,
            ),
          );
        },
        tooltip: 'Agregar curso',
        child: const Icon(Icons.add),
      ),
    );
  }
}
