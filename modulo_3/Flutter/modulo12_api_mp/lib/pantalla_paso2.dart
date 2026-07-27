import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import 'todo_dto.dart';

class PantallaPaso2 extends StatelessWidget {
  const PantallaPaso2({super.key});

  Future<List<EjercicioDto>> _fetchEjercicios() async {
    final res = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/todos?_limit=15'),
    );
    if (res.statusCode != 200) {
      throw Exception('Status ${res.statusCode}');
    }
    final lista = jsonDecode(res.body) as List<dynamic>;
    return lista
        .map((e) => EjercicioDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paso 2 · DTO Ejercicios de Vocabulario'),
        leading: BackButton(onPressed: () => context.go('/')),
      ),
      body: FutureBuilder<List<EjercicioDto>>(
        future: _fetchEjercicios(),
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

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

          final ejercicios = snap.data!;
          final sinResolver = ejercicios.where((e) => e.sinResolver).toList();
          final enunciadosLargos =
              ejercicios.where((e) => e.enunciado.length > 30).length;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    Chip(
                      avatar: const Icon(Icons.check_circle,
                          size: 16, color: Colors.green),
                      label: Text(
                          '${ejercicios.where((e) => e.completado).length} resueltos'),
                      backgroundColor: Colors.green[100],
                    ),
                    Chip(
                      avatar: const Icon(Icons.quiz_outlined,
                          size: 16, color: Colors.orange),
                      label: Text('${sinResolver.length} sin resolver'),
                      backgroundColor: Colors.orange[100],
                    ),
                    Chip(
                      avatar: const Icon(Icons.text_fields,
                          size: 16, color: Colors.blue),
                      label: Text('$enunciadosLargos enunciados > 30 chars'),
                      backgroundColor: Colors.blue[100],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                child: Text(
                  'Ejercicios sin resolver: (${sinResolver.length})',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.orange,
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: sinResolver.length,
                  itemBuilder: (context, i) {
                    final e = sinResolver[i];
                    return CheckboxListTile(
                      title: Text(
                        e.enunciado,
                        style: TextStyle(
                          fontWeight: e.enunciado.length > 30
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      subtitle: Text(
                        'ID: ${e.id}  ·  ${e.enunciado.length} chars',
                        style:
                            const TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      value: e.completado,
                      onChanged: null,
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
