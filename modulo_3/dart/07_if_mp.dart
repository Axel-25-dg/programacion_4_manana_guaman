void main() {
  int puntaje = 85;

  if (puntaje >= 90) {
    print('Calificacion: Excelente');
  } else if (puntaje >= 70) {
    print('Calificacion: Aprobado');
  } else {
    print('Calificacion: Reprobado');
  }

  String resultado = puntaje >= 70 ? 'Apto para el siguiente nivel' : 'Debe repetir el nivel';
  print(resultado);

  String? cursoActual;
  String nombreCurso = cursoActual != null ? cursoActual.toUpperCase() : 'Ningun curso activo';
  print(nombreCurso);

  String nombreCursoConciso = cursoActual?.toUpperCase() ?? 'Ningun curso activo';
  print(nombreCursoConciso);

  String? estudiante;
  print(estudiante?.length);

  int longitudNombre = estudiante?.length ?? 0;
  print('Longitud del nombre: $longitudNombre');
}
