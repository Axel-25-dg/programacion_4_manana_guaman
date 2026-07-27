import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import 'todo_dto.dart';

class PantallaPaso2 extends StatelessWidget {
  const PantallaPaso2({super.key});

  Future<List<TodoDto>> _fetchTodos() async {
    final res = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/todos?_limit=15'),
    );
    if (res.statusCode != 200) {
      throw Exception('Status ${res.statusCode}');
    }
    final lista = jsonDecode(res.body) as List<dynamic>;
    return lista
        .map((e) => TodoDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paso 2 · DTO simple'),
        leading: BackButton(onPressed: () => context.go('/')),
      ),
      body: FutureBuilder<List<TodoDto>>(
        future: _fetchTodos(),
        builder: (context, snap) {
          // Estado 1: cargando
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          // Estado 2: error
          if (snap.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 48, color: Colors.red),
                  const SizedBox(height: 8),
                  Text('Error: ${snap.error}',
                      style: const TextStyle(color: Colors.red)),
                ],
              ),
            );
          }

          // Estado 3: datos disponibles
          final todos = snap.data!;

          // ── Mini-ejercicio 2.2: filtrar solo pendientes ─────────────────
          final pendientes = todos.where((t) => t.pendiente).toList();

          // ── Mini-ejercicio 2.3: títulos con más de 30 caracteres ────────
          final titulosLargos =
              todos.where((t) => t.title.length > 30).length;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Chips de resumen ────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    Chip(
                      avatar: const Icon(Icons.task_alt,
                          size: 16, color: Colors.green),
                      label: Text(
                          '${todos.where((t) => t.completed).length} completadas'),
                      backgroundColor: Colors.green[100],
                    ),
                    Chip(
                      avatar: const Icon(Icons.radio_button_unchecked,
                          size: 16, color: Colors.orange),
                      label: Text('${pendientes.length} pendientes'),
                      backgroundColor: Colors.orange[100],
                    ),
                    // Mini-ejercicio 2.3
                    Chip(
                      avatar: const Icon(Icons.text_fields,
                          size: 16, color: Colors.blue),
                      label: Text('$titulosLargos títulos > 30 chars'),
                      backgroundColor: Colors.blue[100],
                    ),
                  ],
                ),
              ),

              // ── Mini-ejercicio 2.2: sección "Tareas pendientes" ─────────
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                child: Text(
                  'Tareas pendientes: (${pendientes.length})',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.orange,
                  ),
                ),
              ),

              // ── Lista solo de pendientes ─────────────────────────────────
              Expanded(
                child: ListView.builder(
                  itemCount: pendientes.length,
                  itemBuilder: (context, i) {
                    final t = pendientes[i];
                    return CheckboxListTile(
                      title: Text(
                        t.title,
                        style: TextStyle(
                          // Destaca títulos largos en negrita
                          fontWeight: t.title.length > 30
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      subtitle: Text(
                        'ID: ${t.id}  ·  ${t.title.length} chars',
                        style:
                            const TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      value: t.completed,
                      onChanged: null, // solo lectura
                      activeColor: Colors.green,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
