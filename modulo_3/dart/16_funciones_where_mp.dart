void main() {
  final calificaciones = [65, 88, 92, 45, 78, 95, 55];

  final aprobados = calificaciones.where((c) => c >= 70);
  print('Lecciones aprobadas: ${aprobados.toList()}');

  final excelentes = calificaciones.where((c) => c >= 90);
  print('Lecciones excelentes: ${excelentes.toList()}');
}
