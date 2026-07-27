import 'package:go_router/go_router.dart';
import '../screens/scaffold_con_nav.dart';
import '../screens/pantalla_servidores.dart';
import '../screens/pantalla_detalle.dart';
import '../screens/pantalla_metricas.dart';
import '../screens/pantalla_ajustes.dart';
import '../screens/pantalla_dashboard.dart';
import '../models/servidor_ssh.dart';

final appRouterPaso4 = GoRouter(
  initialLocation: '/cursos',
  debugLogDiagnostics: true,
  routes: [
    ShellRoute(
      builder: (context, state, child) => ScaffoldConNav(child: child),
      routes: [
        GoRoute(
          path:    '/cursos',
          builder: (_, __) => const PantallaServidores(),
          routes: [
            GoRoute(
              path:    ':id',
              builder: (context, state) {
                final id       = state.pathParameters['id']!;
                final servidor = state.extra as ServidorSSH?;
                return PantallaDetalle(id: id, servidor: servidor);
              },
            ),
          ],
        ),
        GoRoute(
          path:    '/progreso',
          builder: (_, __) => const PantallaMetricas(),
        ),
        GoRoute(
          path:    '/ajustes',
          builder: (_, __) => const PantallaAjustes(),
        ),
        GoRoute(
          path:    '/dashboard',
          builder: (_, __) => const PantallaDashboard(),
        )
      ],
    ),
  ],
);
