import 'dart:io';

void main() {
  int totalPalabras = 0;
  int contadorEstudiantes = 0;

  while (true) {
    stdout.write('Ingrese horas de estudio (0 para salir): ');
    String? entradaHoras = stdin.readLineSync();
    if (entradaHoras == null) continue;
    double? horas = double.tryParse(entradaHoras);

    if (horas == null || horas < 0) {
      print('Dato no valido.');
      continue;
    }

    if (horas == 0) {
      break;
    }

    stdout.write('Ingrese cantidad de palabras aprendidas: ');
    String? entradaPalabras = stdin.readLineSync();
    if (entradaPalabras == null) continue;
    int? palabras = int.tryParse(entradaPalabras);

    if (palabras == null || palabras < 0) {
      print('Dato no valido.');
      continue;
    }

    double rendimiento = palabras / horas;

    if (rendimiento < 5) {
      print('Rendimiento bajo');
    } else if (rendimiento >= 5 && rendimiento <= 15) {
      print('Rendimiento normal');
    } else {
      print('Rendimiento alto');
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
    print('Sin registros.');
  }
}
