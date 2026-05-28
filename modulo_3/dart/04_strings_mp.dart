void main() {
  final estudiante = 'Henry';
  final racha = 15;

  print('¡Hola, $estudiante!');

  print('Estudiante: ${estudiante.toUpperCase()} | Racha siguiente: ${racha + 1} dias');

  final perfilEstudiante = '''
Estudiante: $estudiante
Racha actual: $racha dias
Estado Premium: ${racha >= 10 ? 'Activado' : 'Desactivado'}
  ''';
  print(perfilEstudiante);

  final rutaConfig = r'C:\AppIdiomas\config\perfil.json';
  print(rutaConfig);

  print('japones'.toUpperCase());
  print('  Curso de Aleman  '.trim());
  print('Frances'.contains('ran'));
  print('Vocabulario'.replaceAll('a', 'A'));
  print('Ingles,Frances,Japones'.split(','));
  print('Estudiante'.substring(0, 4));
  print('Nivel A1'.startsWith('Nivel'));
  print('5'.padLeft(3, '0'));
  print('XP'.padRight(5, '-'));
}
