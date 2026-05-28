class RecursoAprendizaje {
  final String titulo;
  final String idioma;

  RecursoAprendizaje(this.titulo, this.idioma);

  String obtenerTipo() => 'Generico';

  void mostrarInfo() {
    print('Recurso: $titulo [$idioma] - Tipo: ${obtenerTipo()}');
  }
}

class LeccionAudio extends RecursoAprendizaje {
  LeccionAudio(super.titulo, super.idioma);

  @override
  String obtenerTipo() => 'Audio';

  void reproducir() => print('Reproduciendo audio de $titulo...');
}

class LeccionEscrita extends RecursoAprendizaje {
  LeccionEscrita(super.titulo, super.idioma);

  @override
  String obtenerTipo() => 'Texto';

  void leer() => print('Abriendo lectura de $titulo...');
}

void main() {
  final audio = LeccionAudio('Podcast Nivel A2', 'Frances');
  final texto = LeccionEscrita('Gramatica de Articulos', 'Ingles');

  audio.mostrarInfo();
  texto.mostrarInfo();

  audio.reproducir();
  texto.leer();
}
