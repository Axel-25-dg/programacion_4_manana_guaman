import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

// ── Mini-ejercicio: StatefulWidget con navegación por ID ──────────────────────
class PantallaPaso1 extends StatefulWidget {
  const PantallaPaso1({super.key});

  @override
  State<PantallaPaso1> createState() => _PantallaPaso1State();
}

class _PantallaPaso1State extends State<PantallaPaso1> {
  int _id = 1;
  // Límites conocidos de JSONPlaceholder (200 todos)
  static const int _minId = 1;
  static const int _maxId = 200;

  // Cada vez que _id cambia, se crea un nuevo Future → FutureBuilder se reconstruye
  late Future<Map<String, dynamic>> _futuroTodo;

  @override
  void initState() {
    super.initState();
    _futuroTodo = _fetchTodo(_id);
  }

  Future<Map<String, dynamic>> _fetchTodo(int id) async {
    final res = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/todos/$id'),
    );
    if (res.statusCode != 200) {
      throw Exception('Status ${res.statusCode}');
    }
    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  void _ir(int delta) {
    final nuevoId = _id + delta;
    if (nuevoId < _minId || nuevoId > _maxId) return;
    setState(() {
      _id = nuevoId;
      _futuroTodo = _fetchTodo(_id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paso 1 · FutureBuilder crudo'),
        leading: BackButton(onPressed: () => context.go('/')),
      ),
      body: Column(
        children: [
          // ── Contenido principal ────────────────────────────────────────────
          Expanded(
            child: Center(
              child: FutureBuilder<Map<String, dynamic>>(
                future: _futuroTodo,
                builder: (context, snap) {
                  // Estado 1: esperando respuesta
                  if (snap.connectionState != ConnectionState.done) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Descargando tarea…',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    );
                  }

                  // Estado 2: error de red
                  if (snap.hasError) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.wifi_off, size: 48, color: Colors.red),
                        const SizedBox(height: 8),
                        Text(
                          'Error: ${snap.error}',
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        FilledButton.icon(
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reintentar'),
                          onPressed: () => setState(() {
                            _futuroTodo = _fetchTodo(_id);
                          }),
                        ),
                      ],
                    );
                  }

                  // Estado 3: datos disponibles
                  final todo = snap.data!;
                  final completada = todo['completed'] as bool;

                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          completada ? Icons.task_alt : Icons.radio_button_unchecked,
                          size: 56,
                          color: completada ? Colors.green : Colors.orange,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'ID: ${todo['id']}  ·  userId: ${todo['userId']}',
                          style:
                              const TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          todo['title'] as String,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Chip(
                          label: Text(
                            completada ? 'Completada ✓' : 'Pendiente',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          backgroundColor: completada
                              ? Colors.green[100]
                              : Colors.orange[100],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // ── Botones de navegación (mini-ejercicio) ─────────────────────────
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              child: Row(
                children: [
                  // Botón Anterior
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 16),
                      label: const Text('Anterior'),
                      onPressed: _id > _minId ? () => _ir(-1) : null,
                    ),
                  ),
                  // Contador central
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Text(
                          '$_id',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'de $_maxId',
                          style: const TextStyle(
                              fontSize: 11, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  // Botón Siguiente
                  Expanded(
                    child: FilledButton.icon(
                      icon: const Icon(Icons.arrow_forward_ios, size: 16),
                      label: const Text('Siguiente'),
                      onPressed: _id < _maxId ? () => _ir(1) : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
