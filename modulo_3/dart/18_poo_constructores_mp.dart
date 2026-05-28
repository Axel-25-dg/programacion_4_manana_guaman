class CursoIdiomas {
  final String nombre;
  final String idioma;
  final int nivel;
  final bool esPremium;

  CursoIdiomas({
    required this.nombre,
    required this.idioma,
    required this.nivel,
    this.esPremium = false,
  });

  CursoIdiomas.basico({required this.nombre, required this.idioma})
      : nivel = 1,
        esPremium = false;

  CursoIdiomas.avanzado({required this.nombre, required this.idioma})
      : nivel = 5,
        esPremium = true;

  factory CursoIdiomas.desdeCodigo(String codigo) {
    final partes = codigo.split('-');
    final lang = partes[0];
    final n = int.parse(partes[1]);
    return CursoIdiomas(
      nombre: 'Curso de $lang Nivel $n',
      idioma: lang,
      nivel: n,
      esPremium: n > 3,
    );
  }

  @override
  String toString() =>
      'Curso: $nombre ($idioma) - Nivel: $nivel ${esPremium ? "[Premium]" : "[Gratis]"}';
}

void main() {
  final c1 = CursoIdiomas(nombre: 'Ingles Tecnico', idioma: 'Ingles', nivel: 3);
  final c2 = CursoIdiomas.basico(nombre: 'Saludos Japoneses', idioma: 'Japones');
  final c3 = CursoIdiomas.avanzado(nombre: 'Literatura Francesa', idioma: 'Frances');
  final c4 = CursoIdiomas.desdeCodigo('Aleman-4');

  print(c1);
  print(c2);
  print(c3);
  print(c4);
}
