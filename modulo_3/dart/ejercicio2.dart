import 'dart:io';
void main() {
    print("Ingrese un numero entero: ");
    int numero = int.parse(stdin.readLineSync()!);

    if (numero > 0) {
    print('positivo');
    } else if (numero < 0) {
    print('negativo');
    }else {
    print('cero');
    }
    
}