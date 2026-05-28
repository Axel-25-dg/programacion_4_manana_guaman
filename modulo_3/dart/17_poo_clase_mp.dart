abstract class ActividadEstudio {
  final String id;
  final String titulo;
  final int xpRecompensa;

  ActividadEstudio({
    required this.id,
    required this.titulo,
    required this.xpRecompensa,
  });

  void iniciar();
  void finalizar();
  Map<String, dynamic> obtenerEstadisticas();

  void mostrarResumen() {
    final stats = obtenerEstadisticas();
    print('[$titulo] Estadisticas finales: $stats');
  }

  bool get completada;
  String get estado => completada ? 'Completada' : 'Pendiente';

  @override
  String toString() => '$titulo ($xpRecompensa XP) — $estado';
}

class LeccionVocabulario extends ActividadEstudio {
  final int totalPalabras;
  int palabrasAprendidas;
  bool _completada = false;

  LeccionVocabulario({
    required super.id,
    required super.titulo,
    required super.xpRecompensa,
    required this.totalPalabras,
    this.palabrasAprendidas = 0,
  });

  @override bool get completada => _completada;
  @override void iniciar() { print('Iniciando vocabulario: $titulo'); }
  @override void finalizar() { _completada = true; print('Leccion finalizada: $titulo'); }

  @override
  Map<String, dynamic> obtenerEstadisticas() => {
    'total_palabras': totalPalabras,
    'aprendidas': palabrasAprendidas,
  };
}

class RetoPronunciacion extends ActividadEstudio {
  final double precisionMinima;
  double precisionAlcanzada;
  bool _completada = false;

  RetoPronunciacion({
    required super.id,
    required super.titulo,
    required super.xpRecompensa,
    required this.precisionMinima,
    this.precisionAlcanzada = 0.0,
  });

  @override bool get completada => _completada;
  @override void iniciar() { print('Reto de pronunciacion: $titulo. ¡Habla ahora!'); }
  @override void finalizar() { _completada = true; print('Reto finalizado.'); }

  @override
  Map<String, dynamic> obtenerEstadisticas() => {
    'minima': precisionMinima,
    'alcanzada': precisionAlcanzada,
  };
}

void main() {
  final v1 = LeccionVocabulario(
    id: 'VOC-01', titulo: 'Frutas y Verduras',
    xpRecompensa: 50, totalPalabras: 20, palabrasAprendidas: 18,
  );
  final r1 = RetoPronunciacion(
    id: 'PRON-01', titulo: 'La letra R en Frances',
    xpRecompensa: 100, precisionMinima: 0.85, precisionAlcanzada: 0.92,
  );

  v1.iniciar();
  r1.iniciar();

  for (final actividad in [v1, r1]) {
    actividad.finalizar();
    actividad.mostrarResumen();
  }
}
