import 'package:flutter/material.dart';
import 'widgets/tarjeta_log.dart';
import 'widgets/fila_estado.dart';
import 'widgets/avatar_badge.dart';
import 'widgets/customized_sized_box.dart'; // ← Nueva importación del Paso 5

// ┌──────────────────────────────────────────────────────────────────┐
// │  Cambia este número y guarda (Ctrl+S) para navegar entre pasos. │
// │  1  Paso 1  Container — decoración y espaciado                  │
// │  2  Paso 2  Column — TarjetaLog                                 │
// │  3  Paso 3  Row + Expanded + Spacer — FilaEstado                │
// │  4  Paso 4  Stack + Positioned — AvatarBadge                   │
// │  5  Paso 5  SizedBox, Padding, Align, Wrap                      │
// └──────────────────────────────────────────────────────────────────┘
const int paso = 5; // ← Cambia a 5 para visualizarlo de inmediato

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: switch (paso) {
    1 => _paso1(),
    2 => Scaffold(
      body: ListView(
        children: [
          TarjetaLog(nivel: 'ERROR', componente: 'auth-service',
              mensaje:   'Token expirado — usuario forzado a re-login',
              timestamp: DateTime.now()),
          TarjetaLog(nivel: 'WARN',  componente: 'db-pool',
              mensaje:   'Conexiones disponibles: 2 / 10',
              timestamp: DateTime.now().subtract(const Duration(minutes: 2))),
          TarjetaLog(nivel: 'INFO',  componente: 'scheduler',
              mensaje:   'Tarea de backup completada',
              timestamp: DateTime.now().subtract(const Duration(minutes: 5))),
          TarjetaLog(nivel: 'DEBUG', componente: 'http-client',
              mensaje:   'GET /api/status → 200 OK (38ms)',
              timestamp: DateTime.now().subtract(const Duration(minutes: 8))),
        ],
      ),
    ),
    3 => const Scaffold(
      body: Column(
        children: [
          FilaEstado(nombre: 'nginx-proxy',   detalle: '10.0.0.5 · 45ms',          activo: true),
          Divider(height: 1),
          FilaEstado(nombre: 'db-primary',    detalle: '10.0.0.12 · 8ms',           activo: true),
          Divider(height: 1),
          FilaEstado(nombre: 'backup-worker', detalle: '10.0.0.30 · sin respuesta', activo: false),
          Divider(height: 1),
          FilaEstado(nombre: 'api-gateway-produccion-region-us-east',
                     detalle: '10.0.0.8 · 12ms', activo: true),
        ],
      ),
    ),
    4 => const Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AvatarBadge(nombre: 'web-01', alertas: 2,  activo: true),
            SizedBox(width: 24),
            AvatarBadge(nombre: 'db-01',  alertas: 0,  activo: true),
            SizedBox(width: 24),
            AvatarBadge(nombre: 'worker', alertas: 0,  activo: false),
            SizedBox(width: 24),
            AvatarBadge(nombre: 'cache',  alertas: 15, activo: true),
          ],
        ),
      ),
    ),
    5 => const Scaffold( 
      body: CustomizedSizedBox(
        nombre: 'Nodo Central',
        detalle: 'Configuración de Red',
        activo: true,
      ),
    ),
    _ => Scaffold(body: Center(child: Text('Paso $paso: crea el widget primero'))),
  },
));

Widget _paso1() => Scaffold(
  body: Center(
    child: Container(
      width:   double.infinity,
      height:  80,
      margin:  const EdgeInsets.all(24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color:        Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(40),
        border:       const Border(left: BorderSide(color: Colors.indigo, width: 4)),
        boxShadow: [
          BoxShadow(
            color:      Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset:     const Offset(0, 2),
          ),
        ],
      ),
      child: const Text('Servidor web-01',
          style: TextStyle(fontWeight: FontWeight.bold)),
    ),
  ),
);