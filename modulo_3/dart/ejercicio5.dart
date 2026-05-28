import 'dart:io';

void main() {
  int totalSillas = 0;
  int contadorEmpleados = 0;

  while (true) {
    stdout.write('Ingrese las horas trabajadas por el empleado (0 para salir): ');
    String? entradaHoras = stdin.readLineSync();
    if (entradaHoras == null) continue;
    double? horas = double.tryParse(entradaHoras);

    if (horas == null || horas < 0) {
      print('Por favor, ingrese un valor numérico válido.');
      continue;
    }

    if (horas == 0) {
      break;
    }

    stdout.write('Ingrese la cantidad de sillas fabricadas: ');
    String? entradaSillas = stdin.readLineSync();
    if (entradaSillas == null) continue;
    int? sillas = int.tryParse(entradaSillas);

    if (sillas == null || sillas < 0) {
      print('Por favor, ingrese una cantidad válida de sillas.');
      continue;
    }

    double sillasPorHora = sillas / horas;

    if (sillasPorHora < 2) {
      print('Producción baja');
    } else if (sillasPorHora >= 2 && sillasPorHora <= 4) {
      print('Producción normal');
    } else {
      print('Producción alta');
    }

    totalSillas += sillas;
    contadorEmpleados++;
  }

  print('Total de sillas fabricadas: $totalSillas');
  print('Cantidad de empleados registrados: $contadorEmpleados');

  if (contadorEmpleados > 0) {
    double promedio = totalSillas / contadorEmpleados;
    print('Promedio de sillas por empleado: ${promedio.toStringAsFixed(2)}');
  } else {
    print('Promedio de sillas por empleado: 0.00 (No se registraron empleados)');
  }
}