class ServidorSSH {
  final String id;
  final String nombre;
  final String idioma;
  final String nivel;
  final int    duracionHoras;
  final bool   certificado;

  const ServidorSSH({
    required this.id,
    required this.nombre,
    required this.idioma,
    required this.nivel,
    required this.duracionHoras,
    required this.certificado,
  });
}

const servidoresSimulados = [
  ServidorSSH(id: '1', nombre: 'Inglés Conversacional Avanzado',    idioma: 'Inglés',  nivel: 'B2', duracionHoras: 60, certificado: true),
  ServidorSSH(id: '2', nombre: 'Gramática Francesa A2',             idioma: 'Francés', nivel: 'A2', duracionHoras: 40, certificado: true),
  ServidorSSH(id: '3', nombre: 'Kanjis N5-N4 Básico',               idioma: 'Japonés', nivel: 'N5', duracionHoras: 80, certificado: false),
];
