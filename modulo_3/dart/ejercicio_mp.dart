import 'dart:io';

void main() {
  print('Ingrese un año para verificar si fue bisiesto para la app: ');
  int? anio = int.tryParse(stdin.readLineSync() ?? '');

  if (anio != null) {
    bool esBisiesto = (anio % 4 == 0 && anio % 100 != 0) || (anio % 400 == 0);
    if (esBisiesto) {
      print('El año $anio fue bisiesto. ¡Un dia extra para practicar!');
    } else {
      print('El año $anio no fue bisiesto.');
    }
  }

  print('\nVerificacion de racha:');
  int racha = 15;
  if (racha >= 10) {
    print('Racha excelente. ¡Mantén el ritmo!');
  } else {
    print('Sigue practicando para aumentar tu racha.');
  }
}
