void main() {
  var nombreEstudiante = 'Henry';
  var idioma = 'Japones';
  var nivelActual = 3;
  var suscripcionActiva = true;

  String apellido = 'Guaman';
  int rachaDias = 15;
  double precisionPromedio = 92.5;
  bool metaDiariaCompletada = true;

  final fechaRegistro = DateTime.now();

  const xpPorLeccion = 100;
  const multiplicadorPremium = 1.5;

  print('Estudiante: $nombreEstudiante $apellido');
  print('Idioma: $idioma | Nivel: $nivelActual');
  print('Registro realizado el: $fechaRegistro');

  var leccionesHoy = 0;
  leccionesHoy = 2;

  final listaLecciones = ['Alfabeto', 'Saludos', 'Numeros'];
  listaLecciones.add('Colores');

  const vocabularioFijo = ['Hola', 'Adios'];
}
