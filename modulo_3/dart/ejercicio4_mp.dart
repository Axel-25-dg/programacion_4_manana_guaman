import 'dart:io';

void main() {
  int totalPalabras = 0;
  int contadorEstudiantes = 0;

  while (true) {
    stdout.write('Ingrese palabras aprendidas por el estudiante (0 para salir): ');
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

    if (palabras > 50) {
      print('Desempeño excelente');
    } else if (palabras < 20) {
      print('Desempeño bajo');
    } else {
      print('Desempeño normal');
    }

    totalPalabras += palabras;
    contadorEstudiantes++;
  }

  print('Total de palabras aprendidas: $totalPalabras');
  print('Estudiantes registrados: $contadorEstudiantes');

  if (contadorEstudiantes > 0) {
    double promedio = totalPalabras / contadorEstudiantes;
    print('Promedio de palabras por estudiante: ${promedio.toStringAsFixed(2)}');
  } else {
    print('No se registraron estudiantes.');
  }
}
