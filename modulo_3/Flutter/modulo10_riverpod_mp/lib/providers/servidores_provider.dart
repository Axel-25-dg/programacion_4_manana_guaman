import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../models/servidor_ssh.dart';

class ServidoresNotifier extends Notifier<List<ServidorSSH>> {
  @override
  List<ServidorSSH> build() => [
    ServidorSSH(id:'1', nombre:'Inglés Conversacional', idioma:'Inglés',   nivel:'B2', duracionHoras:60, modalidad:'Online',     certificado:true,  favorito:true,  categoria:'conversación'),
    ServidorSSH(id:'2', nombre:'Gramática Francesa',    idioma:'Francés',  nivel:'A2', duracionHoras:40, modalidad:'Presencial', certificado:true,  categoria:'gramática'),
    ServidorSSH(id:'3', nombre:'Kanjis N5-N4',          idioma:'Japonés',  nivel:'N5', duracionHoras:80, modalidad:'Online',     certificado:false, categoria:'vocabulario'),
    ServidorSSH(id:'4', nombre:'Alemán para viajar',    idioma:'Alemán',   nivel:'A1', duracionHoras:20, modalidad:'Híbrido',    certificado:false, categoria:'frases útiles'),
  ];

  void toggleFavorito(String id) {
    state = state.map((s) =>
        s.id == id
          ? ServidorSSH(id:s.id, nombre:s.nombre, idioma:s.idioma,
                        nivel:s.nivel, duracionHoras:s.duracionHoras,
                        modalidad:s.modalidad, certificado:s.certificado,
                        favorito:!s.favorito, categoria:s.categoria)
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

final busquedaProvider = StateProvider<String>((ref) => '');

final servidoresFiltradosProvider = Provider<List<ServidorSSH>>((ref) {
  final todos    = ref.watch(servidoresProvider);
  final busqueda = ref.watch(busquedaProvider);

  if (busqueda.isEmpty) return todos;

  final q = busqueda.toLowerCase();
  return todos.where((s) =>
      s.nombre.toLowerCase().contains(q) ||
      s.idioma.toLowerCase().contains(q) ||
      s.categoria.toLowerCase().contains(q) ||
      s.nivel.toLowerCase().contains(q)
  ).toList();
});
