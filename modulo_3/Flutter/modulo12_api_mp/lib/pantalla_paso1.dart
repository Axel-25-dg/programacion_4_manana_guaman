import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class PantallaPaso1 extends StatefulWidget {
  const PantallaPaso1({super.key});

  @override
  State<PantallaPaso1> createState() => _PantallaPaso1State();
}

class _PantallaPaso1State extends State<PantallaPaso1> {
  int _id = 1;
  static const int _minId = 1;
  static const int _maxId = 200;

  late Future<Map<String, dynamic>> _futuroEjercicio;

  @override
  void initState() {
    super.initState();
    _futuroEjercicio = _fetchEjercicio(_id);
  }

  Future<Map<String, dynamic>> _fetchEjercicio(int id) async {
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
      _futuroEjercicio = _fetchEjercicio(_id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paso 1 · Ejercicio de Vocabulario'),
        leading: BackButton(onPressed: () => context.go('/')),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: FutureBuilder<Map<String, dynamic>>(
                future: _futuroEjercicio,
                builder: (context, snap) {
                  if (snap.connectionState != ConnectionState.done) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Descargando ejercicio…',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    );
                  }

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
                            _futuroEjercicio = _fetchEjercicio(_id);
                          }),
                        ),
                      ],
                    );
                  }

                  final ejercicio = snap.data!;
                  final completado = ejercicio['completed'] as bool;

                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          completado ? Icons.check_circle : Icons.quiz_outlined,
                          size: 56,
                          color: completado ? Colors.green : Colors.orange,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'ID: ${ejercicio['id']}  ·  Lección: ${ejercicio['userId']}',
                          style:
                              const TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          ejercicio['title'] as String,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Chip(
                          label: Text(
                            completado ? 'Ejercicio resuelto ✓' : 'Pendiente de resolver',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          backgroundColor: completado
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

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 16),
                      label: const Text('Ejercicio anterior'),
                      onPressed: _id > _minId ? () => _ir(-1) : null,
                    ),
                  ),
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
