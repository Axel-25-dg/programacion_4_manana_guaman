import 'package:flutter/material.dart';

class PantallaAppBar extends StatelessWidget {
  const PantallaAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final cursos = [
      (nombre: 'Inglés Intermedio B2', nivel: '68% completado'),
      (nombre: 'Francés Elemental A2',  nivel: '41% completado'),
      (nombre: 'Japonés Básico N5',    nivel: '58% completado'),
      (nombre: 'Alemán Principiante A1', nivel: '15% completado'),
      (nombre: 'Italiano Conversación', nivel: '75% completado'),
      (nombre: 'Portugués Brasilero',   nivel: '30% completado'),
      (nombre: 'Coreano Básico',        nivel: '22% completado'),
      (nombre: 'Chino Mandarín',        nivel: '8% completado'),
      (nombre: 'Árabe Moderno',         nivel: '12% completado'),
      (nombre: 'Ruso A2',               nivel: '35% completado'),
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar — colapsa al hacer scroll
          SliverAppBar.large(
            title:           const Text('Mis Cursos'),
            pinned:          true,
            backgroundColor: cs.primaryContainer,
            foregroundColor: cs.onPrimaryContainer,
            actions: [
              IconButton(
                icon:      const Icon(Icons.filter_list),
                onPressed: () {},
                tooltip:   'Filtrar por nivel',
              ),
              IconButton(
                icon:      const Icon(Icons.search),
                onPressed: () {},
                tooltip:   'Buscar curso',
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: cs.primaryContainer,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 56),
                    Icon(Icons.menu_book, size: 48, color: cs.onPrimaryContainer),
                    const SizedBox(height: 8),
                    Text(
                      '10 cursos activos · 4 idiomas en estudio',
                      style: TextStyle(color: cs.onPrimaryContainer),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Lista de cursos
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => Card(
                  child: ListTile(
                    leading:  Icon(Icons.language, color: cs.primary),
                    title:    Text(cursos[i].nombre),
                    subtitle: Text(cursos[i].nivel),
                    trailing: Chip(
                      label:           const Text('EN CURSO'),
                      backgroundColor: cs.primaryContainer,
                      labelStyle:      TextStyle(color: cs.onPrimaryContainer),
                    ),
                    onTap: () {},
                  ),
                ),
                childCount: cursos.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
