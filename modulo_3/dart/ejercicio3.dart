import 'dart:io';

void main() {
  int totalPiezas = 0;

  while (true) {
    stdout.write('Ingrese la cantidad de piezas producidas (0 para salir): ');
    String? entrada = stdin.readLineSync();

    if (entrada == null) continue;

    int? piezas = int.tryParse(entrada);

    if (piezas == null) {
      print('Por favor, ingrese un número válido.');
      continue;
    }

    if (piezas == 0) {
      break;
    }

    if (piezas < 50) {
      print('Producción baja');
    } else {
      print('Producción adecuada');
    }

    totalPiezas += piezas;
  }

  print('El total de piezas producidas es: $totalPiezas');
}