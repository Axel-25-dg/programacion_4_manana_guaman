import 'dart:io';

void main() {
  print('Ingrese el puntaje de su leccion interactiva (0-100): ');
  String? input = stdin.readLineSync();
  int puntaje = int.tryParse(input ?? '0') ?? 0;

  if (puntaje >= 70) {
    print('Leccion Aprobada. ¡Buen trabajo!');
  } else {
    print('Leccion Reprobada. Necesitas mas practica.');
  }
}
