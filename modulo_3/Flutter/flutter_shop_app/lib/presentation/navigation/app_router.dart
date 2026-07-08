// lib/presentation/navigation/app_router.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shop_app/presentation/screens/admin/categoriesadminscreen.dart';
import 'package:flutter_shop_app/presentation/screens/admin/dashboard_screen.dart';
import 'package:flutter_shop_app/presentation/screens/admin/productsadminscreen.dart';
import 'package:flutter_shop_app/presentation/screens/auth/profile_screen.dart';
import 'package:flutter_shop_app/presentation/screens/cart/cart_screen.dart';
import 'package:flutter_shop_app/presentation/screens/catalog/product_detail_screen.dart';
import 'package:flutter_shop_app/presentation/screens/orders/orderdetailscreen.dart';
import 'package:flutter_shop_app/presentation/screens/orders/orders_screen.dart';
import 'package:flutter_shop_app/presentation/widgets/admin_shell.dart';
import 'package:go_router/go_router.dart';
import '../../domain/model/auth_state.dart';
import '../providers/auth_provider.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/catalog/catalog_screen.dart';
import '../screens/catalog/home_screen.dart';
import '../screens/admin/dashboard_screen.dart';
import '../screens/admin/categories_admin_screen.dart';
import '../screens/admin/products_admin_screen.dart';
import '../screens/admin/orders_admin_screen.dart';
import '../screens/admin/order_admin_detail_screen.dart';
import '../widgets/admin_shell.dart';
import 'public_shell.dart';

// ignore: unused_element
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
              // Cerrar sesión y volver al login
              await ref.read(authProvider.notifier).logout();
              context.go('/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Text(title, style: const TextStyle(color: Color(0xFF8888AA), fontSize: 16)),
      ),
    );
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    refreshListenable: _AuthStateListenable(ref),
    redirect: (context, state) {
      final auth     = ref.read(authProvider);
      final location = state.matchedLocation;

      if (auth.isChecking)        return null;

      final isAuthRoute = location == '/login' || location == '/register';

      if (!auth.isAuthenticated && !isAuthRoute) return '/login';
      if ( auth.isAuthenticated &&  isAuthRoute) return auth.isStaff ? '/admin' : '/';
      if ( auth.isAuthenticated && !auth.isStaff && location.startsWith('/admin')) return '/';

      return null;
    },
    routes: [
      // ── Auth ──────────────────────────────────────────────
      GoRoute(path: '/login',    builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),

      // ── Zona pública con BottomNavBar ──────────────────────
      ShellRoute(
        builder: (_, __, child) => PublicShell(child: child),
        routes: [
          GoRoute(path: '/',        builder: (_, __) => const HomeScreen()),
          GoRoute(
            path: '/catalog', 
            builder: (_, __) => const CatalogScreen(),
            routes: [
              GoRoute(
                path: ':id', // /catalog/1 → id=1
                builder: (_, state) {
                  final id = int.parse(state.pathParameters['id']!);
                  return ProductDetailScreen(productId: id);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/cart',
            builder: (_, __) => const CartScreen(),
          ),
          GoRoute(
            path: '/orders',
            builder: (_, __) => const OrdersScreen(),
          ),
          GoRoute(
            path: '/orders/:id',
            builder: (_, s) => OrderDetailScreen(
              orderId: int.parse(s.pathParameters['id']!),
            ),
          ),
          GoRoute(
            path: '/profile',
            builder: (_, __) => const ProfileScreen(),
          ),
        ],
      ),

      // ── Admin ─────────────────────────────────────────────
      GoRoute(
        path: '/admin',
        builder: (_, state) => AdminShell(
          title:        'Dashboard',
          currentRoute: state.matchedLocation,
          child:        const DashboardScreen(),
        ),
      ),
      GoRoute(
        path: '/admin/categories',
        builder: (_, state) => AdminShell(
          title: 'Categorías',
          currentRoute: state.matchedLocation,
          child: const CategoriesAdminScreen(),
        ),
      ),
      GoRoute(
        path: '/admin/products',
        builder: (_, state) => AdminShell(
          title: 'Productos',
          currentRoute: state.matchedLocation,
          child: const ProductsAdminScreen(),
        ),
      ),
      GoRoute(
        path: '/admin/orders',
        builder: (_, state) => AdminShell(
          title: 'Pedidos',
          currentRoute: state.matchedLocation,
          child: const OrdersAdminScreen(),
        ),
      ),
      GoRoute(
        path: '/admin/orders/:id',
        builder: (_, state) => AdminShell(
          title: 'Detalle pedido #${state.pathParameters['id']}',
          currentRoute: '/admin/orders',
          child: OrderAdminDetailScreen(
            orderId: int.parse(state.pathParameters['id']!),
          ),
        ),
      ),
      
      GoRoute(
        path: '/admin/users',
        builder: (_, state) => AdminShell(
          title:        'Usuarios',
          currentRoute: state.matchedLocation,
          child:        const _AdminPlaceholder('Usuarios — M11'),
        ),
      ),
    ],
  );
});

class _AuthStateListenable extends ChangeNotifier {
  _AuthStateListenable(Ref ref) {
    ref.listen<AuthState>(authProvider, (_, __) => notifyListeners());
  }
}

class _AdminPlaceholder extends StatelessWidget {
  final String title;
  const _AdminPlaceholder(this.title);

  @override
  Widget build(BuildContext context) => Center(
        child: Text(title,
            style: const TextStyle(color: Color(0xFF8888AA), fontSize: 16)),
      );
}