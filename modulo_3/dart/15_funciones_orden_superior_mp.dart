void main() {
  final puntajes = [100, 250, 50, 400];

  final puntajesConBono = puntajes.map((p) => p * 1.25);
  print('Puntajes con bono: ${puntajesConBono.toList()}');

  final temas = ['gramatica', 'vocabulario', 'escucha'];
  final urlsLecciones = temas.map((t) => 'https://idiomas.app/lecciones/$t');
  print('URLs de lecciones: ${urlsLecciones.toList()}');
}
