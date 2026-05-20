import 'dart:io';

void main() {
  int totalCajas = 0;
  int contadorEmpleados = 0;

  while (true) {
    stdout.write(
      'Ingrese la cantidad de cajas empaquetadas por empleado (0 para salir): ',
    );
    String? entrada = stdin.readLineSync();

    if (entrada == null) continue;

    int? cajas = int.tryParse(entrada);

    if (cajas == null) {
      print('Por favor, ingrese un numero valido.');
      continue;
    }

    if (cajas == 0) {
      break;
    }

    if (cajas > 50) {
      print('Rendimiento exelente');
    } else if (cajas < 20) {
      print('Rendimineto bajo');
    } else {
      print('Rendimiento normal');
    }

    totalCajas += cajas;
    contadorEmpleados++;
  }

  print('El total de cajas empaquetadas es: $totalCajas');
  print('Cantidad de Empleados registrados es: $contadorEmpleados');

  if(contadorEmpleados > 0) {
    double promedio = totalCajas / contadorEmpleados;
    print('Promedio de cajas por empleado: ${promedio.toStringAsFixed(2)}');
  } else {
    print('Promedio de cajas por empleado: 0.00 (No se registraron empleados)');
  }
}
