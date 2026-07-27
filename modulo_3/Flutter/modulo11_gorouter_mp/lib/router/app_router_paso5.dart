import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../screens/scaffold_con_nav.dart';
import '../screens/pantalla_servidores.dart';
import '../screens/pantalla_detalle.dart';
import '../screens/pantalla_metricas.dart';
import '../screens/pantalla_ajustes.dart';
import '../screens/pantalla_login.dart';
import '../screens/pantalla_dashboard.dart';
import '../models/servidor_ssh.dart';

GoRouter appRouterPaso5(WidgetRef ref) => GoRouter(
  initialLocation: '/cursos',
  debugLogDiagnostics: true,
  redirect: (context, state) {
    final authState     = ref.read(authProvider);
    final autenticado   = authState is Autenticado;
    final enLogin       = state.matchedLocation == '/login';

    if (!autenticado && !enLogin) return '/login';
    if (autenticado && enLogin)   return '/cursos';
    return null;
  },
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
              builder: (context, state) => PantallaDetalle(
                id:       state.pathParameters['id']!,
                servidor: state.extra as ServidorSSH?,
              ),
            ),
          ],
        ),
        GoRoute(path: '/progreso', builder: (_, __) => const PantallaMetricas()),
        GoRoute(path: '/ajustes',  builder: (_, __) => const PantallaAjustes()),
      ],
    ),
    GoRoute(
      path:    '/login',
      builder: (_, __) => const PantallaLogin(),
    ),
    GoRoute(
      path:    '/dashboard',
      builder: (_, __) => const PantallaDashboard(),
    ),
  ],
);
