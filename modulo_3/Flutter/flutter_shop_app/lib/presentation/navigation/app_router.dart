// lib/presentation/navigation/app_router.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/model/auth_state.dart';
import '../providers/auth_provider.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/catalog/catalog_screen.dart';
import '../screens/catalog/home_screen.dart';
import 'public_shell.dart';

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
}

class _PlaceholderScreen extends ConsumerWidget {
  final String title;
  const _PlaceholderScreen(this.title);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authProvider.notifier).logout();
              if (context.mounted) {
                context.go('/login');
              }
            },
          ),
        ],
      ),
      body: Center(child: Text(title, style: const TextStyle(fontSize: 18))),
    );
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: _AuthStateListenable(ref),
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isChecking = authState.isChecking;
      final isAuth = authState.isAuthenticated;
      final isStaff = authState.isStaff;
      final location = state.matchedLocation;

      if (isChecking) {
        return location == '/splash' ? null : '/splash';
      }

      final isAuthRoute = location == '/login' || location == '/register';
      final isSplash = location == '/splash';

      if (isSplash) return isAuth ? (isStaff ? '/admin' : '/') : '/login';
      if (!isAuth && !isAuthRoute) return '/login';
      if (isAuth && isAuthRoute) return isStaff ? '/admin' : '/';
      if (isAuth && !isStaff && location.startsWith('/admin')) return '/';
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (_, __) => const _SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (_, __) => const RegisterScreen(),
      ),
      ShellRoute(
        builder: (_, __, child) => PublicShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            builder: (_, __) => const HomeScreen(),
          ),
          GoRoute(
            path: '/catalog',
            builder: (_, __) => const CatalogScreen(),
          ),
          GoRoute(
            path: '/product/:id',
            builder: (_, state) => _PlaceholderScreen('Detalle #${state.pathParameters['id']} — M5'),
          ),
          GoRoute(
            path: '/cart',
            builder: (_, __) => const _PlaceholderScreen('Carrito — M5'),
          ),
          GoRoute(
            path: '/orders',
            builder: (_, __) => const _PlaceholderScreen('Mis pedidos — M6'),
          ),
          GoRoute(
            path: '/orders/:id',
            builder: (_, state) => _PlaceholderScreen('Pedido #${state.pathParameters['id']} — M6'),
          ),
          GoRoute(
            path: '/profile',
            builder: (_, __) => const _PlaceholderScreen('Perfil — M6'),
          ),
        ],
      ),
      GoRoute(
        path: '/admin',
        builder: (_, __) => const _PlaceholderScreen('Dashboard — M8'),
      ),
      GoRoute(
        path: '/admin/categories',
        builder: (_, __) => const _PlaceholderScreen('Categorías — M9'),
      ),
      GoRoute(
        path: '/admin/products',
        builder: (_, __) => const _PlaceholderScreen('Productos — M10'),
      ),
      GoRoute(
        path: '/admin/orders',
        builder: (_, __) => const _PlaceholderScreen('Pedidos admin — M11'),
      ),
      GoRoute(
        path: '/admin/orders/:id',
        builder: (_, state) => _PlaceholderScreen('Pedido admin #${state.pathParameters['id']} — M11'),
      ),
      GoRoute(
        path: '/admin/users',
        builder: (_, __) => const _PlaceholderScreen('Usuarios — M12'),
      ),
    ],
  );
});

class _AuthStateListenable extends ChangeNotifier {
  _AuthStateListenable(Ref ref) {
    ref.listen<AuthState>(authProvider, (_, __) => notifyListeners());
  }
}
