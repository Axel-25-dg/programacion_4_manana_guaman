// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'router/app_router.dart';
import 'router/app_router_paso2.dart';
import 'router/app_router_paso3.dart';
import 'router/app_router_paso4.dart';
import 'router/app_router_paso5.dart';
import 'providers/auth_provider.dart';


// ┌──────────────────────────────────────────────────────────────────┐
// │  Cambia este número y guarda (Ctrl+S) para navegar entre pasos. │
// │  1  Paso 1  Rutas básicas + context.go / push / pop             │
// │  2  Paso 2  pathParameters + pantalla de detalle                │
// │  3  Paso 3  queryParameters + extras + ShellRoute               │
// │  4  Paso 4  ShellRoute completo + NavigationBar persistente     │
// │  5  Paso 5  Guard redirect + pantalla de login + Riverpod       │
// └──────────────────────────────────────────────────────────────────┘
const int paso = 5;

void main() {
  runApp(
    ProviderScope(
      child: AppMonitoreo(paso: paso),
    ),
  );
}

class AppMonitoreo extends ConsumerWidget {
  final int paso;
  const AppMonitoreo({super.key, required this.paso});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observamos el estado de auth para que el router se regenere al cambiar
    ref.watch(authProvider);

    final router = switch (paso) {
      1 => appRouter,
      2 => appRouterPaso2,
      3 => appRouterPaso3,
      4 => appRouterPaso4,
      5 => appRouterPaso5(ref),
      _ => appRouter,
    };

    return MaterialApp.router(
      title:        'Monitor SSH',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D47A1)),
        useMaterial3: true,
      ),
    );
  }
}
