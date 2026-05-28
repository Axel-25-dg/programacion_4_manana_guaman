void main() {
  int xpGanada = 150;
  double xpDecimal = xpGanada.toDouble();
  String xpTexto = xpGanada.toString();

  int rachaDesdeTexto = int.parse('15');
  double precisionDesdeTexto = double.parse('92.5');

  int? errorEnRacha = int.tryParse('diez');
  double? errorEnPrecision = double.tryParse('n/a');

  Object datosEstudiante = 'Nivel Intermedio';
  if (datosEstudiante is String) {
    print('Longitud del estado: ${datosEstudiante.length}');
  }

  Object idObjeto = 'USR-001';
  String idEstudiante = idObjeto as String;

  String? cursoActual = null;
  int longitudCurso = cursoActual?.length ?? 0;
  print('Caracteres del curso: $longitudCurso');

  print('Limite de XP: ${double.maxFinite}');
  print('Valor no definido de XP: ${double.nan}');
}
