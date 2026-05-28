import 'dart:io';

void main() {
  print('Ingrese el multiplicador de puntaje: ');
  String? input = stdin.readLineSync();
  int multiplicador = int.tryParse(input ?? '1') ?? 1;

  print('Proyeccion de puntuaciones:');
  for (int i = 1; i <= 10; i++) {
    print('Base $i x Multiplicador $multiplicador = ${i * multiplicador} XP');
  }
}
