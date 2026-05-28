void configurarLeccion({
  required String titulo,
  required int dificultad,
  bool esPremium = false,
  int tiempoLimiteMin = 15,
}) {
  final tipo = esPremium ? 'Premium' : 'Gratuita';
  print('Iniciando leccion $tipo: $titulo (Dificultad: $dificultad, Tiempo: ${tiempoLimiteMin}min)');
}

void main() {
  configurarLeccion(
    titulo: 'Verbos Irregulares',
    dificultad: 3,
    esPremium: true,
    tiempoLimiteMin: 20,
  );

  configurarLeccion(
    titulo: 'Presentaciones',
    dificultad: 1,
  );
}
