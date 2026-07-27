import 'package:flutter/material.dart';
import 'widgets/tarjeta_log.dart';
import 'widgets/fila_estado.dart';
import 'widgets/avatar_badge.dart';
import 'widgets/customized_sized_box.dart';

// ┌──────────────────────────────────────────────────────────────────┐
// │  Cambia este número y guarda (Ctrl+S) para navegar entre pasos. │
// │  1  Paso 1  Container — decoración y espaciado                  │
// │  2  Paso 2  Column — TarjetaLog                                 │
// │  3  Paso 3  Row + Expanded + Spacer — FilaEstado                │
// │  4  Paso 4  Stack + Positioned — AvatarBadge                   │
// │  5  Paso 5  SizedBox, Padding, Align, Wrap                      │
// └──────────────────────────────────────────────────────────────────┘
const int paso = 1;

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: switch (paso) {
    1 => _paso1(),
    2 => Scaffold(
      body: ListView(
        children: [
          TarjetaLog(nivel: 'ERROR', componente: 'Gramática - Pretérito Imperfecto',
              mensaje:   '3 errores en conjugación de verbos irregulares — repasar la lección',
              timestamp: DateTime.now()),
          TarjetaLog(nivel: 'WARN',  componente: 'Vocabulario - Medio Ambiente',
              mensaje:   'Palabras por repasar: 18 de 50',
              timestamp: DateTime.now().subtract(const Duration(minutes: 2))),
          TarjetaLog(nivel: 'INFO',  componente: 'Pronunciación EN',
              mensaje:   'Práctica de listening completada con 92% de aciertos',
              timestamp: DateTime.now().subtract(const Duration(minutes: 5))),
          TarjetaLog(nivel: 'DEBUG', componente: 'Flashcards - Repaso espaciado',
              mensaje:   'Siguiente sesión programada para mañana 08:00',
              timestamp: DateTime.now().subtract(const Duration(minutes: 8))),
        ],
      ),
    ),
    3 => const Scaffold(
      body: Column(
        children: [
          FilaEstado(nombre: 'Inglés Británico',   detalle: 'Nivel B2 · Progreso 72%',          activo: true),
          Divider(height: 1),
          FilaEstado(nombre: 'Francés',    detalle: 'Nivel A2 · Progreso 41%',           activo: true),
          Divider(height: 1),
          FilaEstado(nombre: 'Alemán', detalle: 'Sin práctica · 14 días pendiente', activo: false),
          Divider(height: 1),
          FilaEstado(nombre: 'Japonés - Curso intensivo de kanjis nivel N3',
                     detalle: 'Nivel B1 · Progreso 58%', activo: true),
        ],
      ),
    ),
    4 => const Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AvatarBadge(nombre: 'Inglés', alertas: 5,  activo: true),
            SizedBox(width: 24),
            AvatarBadge(nombre: 'Francés',  alertas: 0,  activo: true),
            SizedBox(width: 24),
            AvatarBadge(nombre: 'Alemán', alertas: 0,  activo: false),
            SizedBox(width: 24),
            AvatarBadge(nombre: 'Japonés',  alertas: 12, activo: true),
          ],
        ),
      ),
    ),
    5 => const Scaffold( 
      body: CustomizedSizedBox(
        nombre: 'Curso de Inglés Avanzado',
        detalle: 'Módulo de Conversación',
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
      child: const Text('Lección: Vocabulario de negocios',
          style: TextStyle(fontWeight: FontWeight.bold)),
    ),
  ),
);
