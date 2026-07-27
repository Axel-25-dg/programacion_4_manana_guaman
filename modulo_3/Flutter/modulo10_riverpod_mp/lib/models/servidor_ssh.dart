class ServidorSSH {
  final String id;
  final String nombre;
  final String idioma;
  final String nivel;
  final int    duracionHoras;
  final String modalidad;
  final bool   certificado;
  bool         favorito;
  final String categoria;

  ServidorSSH({
    required this.id,
    required this.nombre,
    required this.idioma,
    required this.nivel,
    required this.duracionHoras,
    required this.modalidad,
    required this.certificado,
    this.favorito = false,
    this.categoria = 'vocabulario',
  });
}
