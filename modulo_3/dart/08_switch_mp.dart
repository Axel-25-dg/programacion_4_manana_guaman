void main() {
  String nivelIdioma = 'B1';

  switch (nivelIdioma) {
    case 'A1':
      print('Principiante');
    case 'A2':
      print('Elemental');
    case 'B1':
      print('Intermedio');
    case 'B2':
      print('Intermedio Alto');
    case 'C1':
      print('Avanzado');
    case 'C2':
      print('Maestria');
    default:
      print('Nivel no reconocido');
  }

  String descripcionNivel = switch (nivelIdioma) {
    'A1' => 'Nivel de entrada: frases basicas',
    'A2' => 'Nivel elemental: comunicación simple',
    'B1' => 'Nivel intermedio: situaciones cotidianas',
    'B2' => 'Nivel intermedio alto: argumentos complejos',
    'C1' => 'Nivel avanzado: uso flexible y efectivo',
    'C2' => 'Nivel de maestria: comprensión total',
    _    => 'Descripción no disponible',
  };
  
  print(descripcionNivel);

  int rachaDias = 31;
  String categoriaRacha = switch (rachaDias) {
    1 || 2 || 3 || 4 || 5 || 6 => 'Novato de racha',
    int d when d >= 7 && d < 30 => 'Constante',
    int d when d >= 30 && d < 100 => 'Maestro de racha',
    int d when d >= 100 => 'Leyenda',
    _ => 'Sin racha activa',
  };

  print('Categoría de racha: $categoriaRacha');

  double precision = 92.5;
  String alertaDesempeno = switch (precision) {
    double p when p >= 95.0 => '🏆 EXCELENTE — Sigue asi',
    double p when p >= 85.0 => '🥈 MUY BUENO — Casi perfecto',
    double p when p >= 70.0 => '🥉 BUENO — Sigue practicando',
    double p when p >= 50.0 => '📙 SUFICIENTE — Necesitas repasar',
    _                       => '❌ INSUFICIENTE — Refuerzo urgente',
  };

  print(alertaDesempeno);
  
  Object perfil = {'id': 101, 'nombre': 'Henry', 'idioma': 'Japones'};

  String infoPerfil = switch (perfil) {
    Map<String, dynamic> m when m.containsKey('baneado') =>
        'Usuario bloqueado: ${m['razon']}',
    Map<String, dynamic> m =>
        'Estudiante: ${m['nombre']} — Idioma: ${m['idioma']}',
    List<dynamic> lista =>
        '${lista.length} cursos inscritos',
    String texto =>
        'Mensaje: $texto',
    _ =>
        'Información no disponible',
  };

  print(infoPerfil);
}