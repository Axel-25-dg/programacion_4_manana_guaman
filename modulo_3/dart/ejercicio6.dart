import 'dart:io';

void main() {
  int totalPacientes = 0;
  int cantidadDoctores = 0;

  while (true) {
    stdout.write('Ingrese las horas trabajadas por doctor (0 para salir): ');
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

    stdout.write('Ingrese la cantidad de pacientes atendidos: ');
    String? entradaPacientes = stdin.readLineSync();
    if (entradaPacientes == null) continue;
    int? pacientes = int.tryParse(entradaPacientes);

    if (pacientes == null || pacientes < 0) {
      print('Por favor, ingrese una cantidad de paciemtes atendidos.');
      continue;
    }

    double pacientesPorHora = pacientes / horas;

    if (pacientesPorHora > 6) {
      print('Atencion rapida');
    } else if (pacientesPorHora < 3) {
      print('Atencion rapida');
    } else {
      print('Atencion normal');
    }

    totalPacientes += pacientes;
    cantidadDoctores++;
  }

  print('Total de pacientes atendidos: $totalPacientes');
  print('Cantidad de Doctores registrados: $cantidadDoctores');

  if (cantidadDoctores > 0) {
    double promedio = totalPacientes / cantidadDoctores;
    print('Promedio de pacientes por Doctor: ${promedio.toStringAsFixed(2)}');
  } else {
    print('Promedio de pacientes por Doctor: 0.00 (No se registraron empleados)');
  }
}