import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldConNav extends StatelessWidget {
  final Widget child;
  const ScaffoldConNav({super.key, required this.child});

  int _indiceActivo(BuildContext context) {
    final loc = GoRouterState.of(context).uri.path;
    if (loc.startsWith('/progreso'))  return 1;
    if (loc.startsWith('/ajustes'))   return 2;
    if (loc.startsWith('/dashboard')) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    print('construyendo ScaffoldConNav');
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex:         _indiceActivo(context),
        onDestinationSelected: (i) {
          switch (i) {
            case 0: context.go('/cursos');
            case 1: context.go('/progreso');
            case 2: context.go('/ajustes');
            case 3: context.go('/dashboard');
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book),
            label: 'Cursos',
          ),
          NavigationDestination(
            icon: Icon(Icons.show_chart_outlined), selectedIcon: Icon(Icons.show_chart),
            label: 'Progreso',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
        ],
      ),
    );
  }
}
