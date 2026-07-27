import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/servidores_provider.dart';

class PantallaBusqueda extends ConsumerWidget {
  const PantallaBusqueda({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servidores = ref.watch(servidoresFiltradosProvider);
    final busqueda   = ref.watch(busquedaProvider);
    final cs         = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title:           const Text('Buscar cursos'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: SearchBar(
            hintText: 'Buscar por nombre, idioma, categoría o nivel...',
            leading:  const Icon(Icons.search),
            trailing: busqueda.isNotEmpty
                ? [IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () =>
                        ref.read(busquedaProvider.notifier).state = '',
                  )]
                : null,
            onChanged: (v) =>
                ref.read(busquedaProvider.notifier).state = v,
            padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
        if (busqueda.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${servidores.length} resultado${servidores.length == 1 ? '' : 's'}',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: cs.onSurfaceVariant,
                ),
              ),
            ),
          ),
        Expanded(
          child: servidores.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.search_off,
                          size: 56, color: cs.onSurfaceVariant),
                      const SizedBox(height: 12),
                      Text(
                        busqueda.isEmpty
                            ? 'Sin cursos'
                            : 'Sin resultados para "$busqueda"',
                        style: TextStyle(color: cs.onSurfaceVariant),
                      ),
                      if (busqueda.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () =>
                              ref.read(busquedaProvider.notifier).state = '',
                          child: const Text('Limpiar búsqueda'),
                        ),
                      ],
                    ],
                  ),
                )
              : ListView.separated(
                  itemCount:        servidores.length,
                  separatorBuilder: (_, __) =>
                      const Divider(height: 1, indent: 72),
                  itemBuilder: (_, i) {
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
                      title:    Text(s.nombre,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text('${s.idioma} · ${s.nivel} · ${s.categoria}'),
                      trailing: s.favorito
                          ? const Icon(Icons.star, color: Colors.amber, size: 18)
                          : null,
                    );
                  },
                ),
        ),
      ]),
    );
  }
}
