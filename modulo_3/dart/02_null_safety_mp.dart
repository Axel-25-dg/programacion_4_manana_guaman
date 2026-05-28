void main() {
  String nombreEstudiante = 'Henry';
  
  String? metaDiaria = null;
  metaDiaria = 'Aprender 20 palabras';

  String? cursoOpcional = 'Cultura Japonesa';

  print(cursoOpcional?.length);

  String estadoCurso = cursoOpcional ?? 'Sin curso asignado';
  print(estadoCurso);

  String cursoSeguro = cursoOpcional!;

  if (metaDiaria != null) {
    print('Meta de hoy: ${metaDiaria.toUpperCase()}');
  }

  late String idCertificado;
  idCertificado = 'CERT-2024-001';
  print('ID de Certificado: $idCertificado');
}
