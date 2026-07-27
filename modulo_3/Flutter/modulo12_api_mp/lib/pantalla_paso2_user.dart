import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import 'user_dto.dart';

class PantallaPaso2User extends StatelessWidget {
  const PantallaPaso2User({super.key});

  Future<List<EstudianteDto>> _fetchEstudiantes() async {
    final res = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/users?_limit=15'),
    );
    if (res.statusCode != 200) {
      throw Exception('Status ${res.statusCode}');
    }
    final lista = jsonDecode(res.body) as List<dynamic>;
    return lista
        .map((e) => EstudianteDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paso 2 · DTO Estudiantes inscritos'),
        leading: BackButton(onPressed: () => context.go('/')),
      ),
      body: FutureBuilder<List<EstudianteDto>>(
        future: _fetchEstudiantes(),
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

          final estudiantes = snap.data!;
          final ciudadesUnicas = estudiantes.map((e) => e.direccion.ciudad).toSet().length;
          final academiasUnicas = estudiantes.map((e) => e.academia.nombre).toSet().length;

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
                      avatar: const Icon(Icons.groups,
                          size: 16, color: Colors.green),
                      label: Text('${estudiantes.length} estudiantes'),
                      backgroundColor: Colors.green[100],
                    ),
                    Chip(
                      avatar: const Icon(Icons.location_city,
                          size: 16, color: Colors.blue),
                      label: Text('$ciudadesUnicas ciudades'),
                      backgroundColor: Colors.blue[100],
                    ),
                    Chip(
                      avatar: const Icon(Icons.school,
                          size: 16, color: Colors.purple),
                      label: Text('$academiasUnicas academias'),
                      backgroundColor: Colors.purple[100],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                child: Text(
                  'Estudiantes inscritos en cursos',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.indigo,
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: estudiantes.length,
                  itemBuilder: (context, i) {
                    final est = estudiantes[i];
                    return Card(
                      margin:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      child: ListTile(
                        contentPadding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                        title: Text(
                          est.nombre,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '@${est.nombreUsuario} · ${est.email}\n${est.direccion.ciudad} · ${est.academia.nombre}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        isThreeLine: true,
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                          child: Text(
                            est.nombre.isNotEmpty ? est.nombre[0] : '?',
                            style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),
                          ),
                        ),
                      ),
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
