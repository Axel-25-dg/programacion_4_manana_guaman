import 'dart:io';

void main() {
  int totalPalabras = 0;

  while (true) {
    stdout.write('Ingrese palabras estudiadas hoy (0 para finalizar): ');
    String? entrada = stdin.readLineSync();

    if (entrada == null) continue;

    int? palabras = int.tryParse(entrada);

    if (palabras == null) {
      print('Dato no valido.');
      continue;
    }

    if (palabras == 0) {
      break;
    }

    if (palabras < 10) {
      print('Sesion corta de vocabulario.');
    } else {
      print('Sesion intensa de vocabulario.');
    }

    totalPalabras += palabras;
  }

  print('Total de palabras estudiadas en la sesion: $totalPalabras');
}
