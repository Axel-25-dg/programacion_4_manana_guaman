abstract class Progreso {
  String get nombreActividad;
  int calcularXP();
}

class LeccionVocabulario extends Progreso {
  final int palabras;
  LeccionVocabulario(this.palabras);
  @override String get nombreActividad => 'Vocabulario';
  @override int calcularXP() => palabras * 10;
}

class RetoEscucha extends Progreso {
  final int minutos;
  RetoEscucha(this.minutos);
  @override String get nombreActividad => 'Escucha';
  @override int calcularXP() => minutos * 50;
}

class ExamenFinal extends Progreso {
  final int nota;
  ExamenFinal(this.nota);
  @override String get nombreActividad => 'Examen';
  @override int calcularXP() => nota * 5;
}

void procesarProgreso(Progreso p) {
  print('${p.nombreActividad}: Ganaste ${p.calcularXP()} XP');
}

void main() {
  final actividades = <Progreso>[
    LeccionVocabulario(20),
    RetoEscucha(15),
    ExamenFinal(85),
  ];

  for (final a in actividades) {
    procesarProgreso(a);
  }

  final actividadMaxXP = actividades.reduce((a, b) => a.calcularXP() > b.calcularXP() ? a : b);
  print('\nActividad con mayor recompensa: ${actividadMaxXP.nombreActividad}');
}
