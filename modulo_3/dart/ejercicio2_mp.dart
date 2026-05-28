import 'dart:io';

void main() {
  print('Ingrese el cambio en su racha de hoy: ');
  String? input = stdin.readLineSync();
  int cambio = int.tryParse(input ?? '0') ?? 0;

  if (cambio > 0) {
    print('¡Racha positiva! Has avanzado.');
  } else if (cambio < 0) {
    print('Racha negativa. ¡No te desanimes!');
  } else {
    print('Racha neutra. Manten tu constancia.');
  }
}
