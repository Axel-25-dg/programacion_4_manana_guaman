import 'package:go_router/go_router.dart';
import '../screens/pantalla_inicio.dart';
import '../screens/pantalla_servidores_filtro.dart';
import '../screens/pantalla_detalle.dart';
import '../models/servidor_ssh.dart';

final appRouterPaso3 = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path:    '/',
      builder: (context, state) => const PantallaInicio(),
    ),
    GoRoute(
      path:    '/cursos',
      builder: (context, state) {
        final soloCertificado = state.uri.queryParameters['soloCertificado'] == 'true';
        return PantallaServidoresFiltro(soloCertificado: soloCertificado);
      },
    ),
    GoRoute(
      path:    '/cursos/:id',
      builder: (context, state) {
        final id       = state.pathParameters['id']!;
        final servidor = state.extra as ServidorSSH?;
        return PantallaDetalle(id: id, servidor: servidor);
      },
    ),
  ],
);
