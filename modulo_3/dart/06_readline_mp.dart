import 'dart:io';

void main() {
  print('Ingrese su nombre de estudiante: ');
  String? nombre = stdin.readLineSync();
  print('Bienvenido, $nombre');

  print('¿Cuantos dias de racha tiene?: ');
  String? rachaInput = stdin.readLineSync();
  int racha = int.tryParse(rachaInput ?? '0') ?? 0;
  print('Racha registrada: $racha dias');

  print('Ingrese su precision promedio (%): ');
  String? precisionInput = stdin.readLineSync();
  double precision = double.tryParse(precisionInput ?? '0.0') ?? 0.0;
  print('Precision: $precision%');

  print('XP de la leccion 1: ');
  int xp1 = int.parse(stdin.readLineSync() ?? '0');

  print('XP de la leccion 2: ');
  int xp2 = int.parse(stdin.readLineSync() ?? '0');

  int totalXP = xp1 + xp2;
  print('Total XP acumulado: $totalXP');
}
