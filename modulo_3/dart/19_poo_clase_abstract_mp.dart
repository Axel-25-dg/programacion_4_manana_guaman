abstract class ElementoEstudio {
  String get titulo;
  int calcularXP();
  double calcularProgreso();

  void describir() {
    print('$titulo — XP: ${calcularXP()}, Progreso: ${(calcularProgreso() * 100).toStringAsFixed(1)}%');
  }
}

class LeccionVocabulario extends ElementoEstudio {
  final int palabrasTotales;
  final int palabrasAprendidas;
  LeccionVocabulario(this.palabrasTotales, this.palabrasAprendidas);

  @override String get titulo => 'Leccion de Vocabulario';
  @override int calcularXP() => palabrasAprendidas * 5;
  @override double calcularProgreso() => palabrasAprendidas / palabrasTotales;
}

class ExamenNivel extends ElementoEstudio {
  final int preguntasTotales;
  final int preguntasCorrectas;
  ExamenNivel(this.preguntasTotales, this.preguntasCorrectas);

  @override String get titulo => 'Examen de Nivel';
  @override int calcularXP() => preguntasCorrectas * 20;
  @override double calcularProgreso() => preguntasCorrectas / preguntasTotales;
}

void main() {
  final elementos = <ElementoEstudio>[
    LeccionVocabulario(20, 15),
    ExamenNivel(10, 8)
  ];
  for (final e in elementos) {
    e.describir();
  }
}
