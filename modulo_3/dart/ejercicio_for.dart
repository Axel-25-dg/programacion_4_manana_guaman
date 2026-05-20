import 'dart:io';
void main() {
    print("Ingrese un numero entero: ");
    int i = int.parse(stdin.readLineSync()!);

    for ( i = 0; i< 10; i*5) {
    print('Multiplicacion : $i');
    }
    
    
}