// lib/providers/servidores_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/servidor_ssh.dart';

// NotifierProvider — estado complejo con métodos propios
class ServidoresNotifier extends Notifier<List<ServidorSSH>> {
  @override
  List<ServidorSSH> build() => [
    ServidorSSH(id:'1', nombre:'prod-web-01', ip:'10.0.2.10', puerto:22,   ssl:true,  favorito:true),
    ServidorSSH(id:'2', nombre:'prod-db-01',  ip:'10.0.2.20', puerto:22,   ssl:true),
    ServidorSSH(id:'3', nombre:'staging-api', ip:'10.0.3.10', puerto:2222, ssl:false),
    ServidorSSH(id:'4', nombre:'dev-db-api',  ip:'10.0.1.10', puerto:22,   ssl:true),
  ];

  void toggleFavorito(String id) {
    state = state.map((s) =>
        s.id == id
          ? ServidorSSH(id:s.id, nombre:s.nombre, ip:s.ip,
                        puerto:s.puerto, ssl:s.ssl,
                        favorito:!s.favorito)
          : s
    ).toList();
  }

  void eliminar(String id) {
    state = state.where((s) => s.id != id).toList();
  }

  void agregar(ServidorSSH servidor) {
    state = [...state, servidor];
  }
}

final servidoresProvider =
    NotifierProvider<ServidoresNotifier, List<ServidorSSH>>(
  ServidoresNotifier.new,
);

// Filtro de búsqueda — estado primitivo
final busquedaProvider = StateProvider<String>((ref) => '');

// Provider DERIVADO — se recalcula cuando cualquiera de sus dependencias cambia
final servidoresFiltradosProvider = Provider<List<ServidorSSH>>((ref) {
  final todos    = ref.watch(servidoresProvider);
  final busqueda = ref.watch(busquedaProvider);

  if (busqueda.isEmpty) return todos;

  final q = busqueda.toLowerCase();
  return todos.where((s) =>
      s.nombre.toLowerCase().contains(q) || s.ip.contains(q)
  ).toList();
  // Cuando 'servidoresProvider' o 'busquedaProvider' cambian,
  // este provider se recalcula automáticamente.
});

