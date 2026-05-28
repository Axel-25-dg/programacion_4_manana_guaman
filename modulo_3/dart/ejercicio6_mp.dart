import 'dart:io';

void main() {
  int totalDudasResueltas = 0;
  int cantidadTutores = 0;

  while (true) {
    stdout.write('Ingrese horas trabajadas por el tutor (0 para salir): ');
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

    stdout.write('Ingrese cantidad de dudas resueltas: ');
    String? entradaDudas = stdin.readLineSync();
    if (entradaDudas == null) continue;
    int? dudas = int.tryParse(entradaDudas);

    if (dudas == null || dudas < 0) {
      print('Dato no valido.');
      continue;
    }

    double dudasPorHora = dudas / horas;

    if (dudasPorHora > 10) {
      print('Soporte muy rapido');
    } else if (dudasPorHora < 4) {
      print('Soporte lento');
    } else {
      print('Soporte normal');
    }

    totalDudasResueltas += dudas;
    cantidadTutores++;
  }

  print('Total de dudas resueltas: $totalDudasResueltas');
  print('Cantidad de tutores registrados: $cantidadTutores');

  if (cantidadTutores > 0) {
    double promedio = totalDudasResueltas / cantidadTutores;
    print('Promedio de dudas por tutor: ${promedio.toStringAsFixed(2)}');
  } else {
    print('Sin tutores registrados.');
  }
}
