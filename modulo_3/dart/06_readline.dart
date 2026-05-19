import 'dart:io';

void main () {
    print("Ingrese su nombre: ");
    String? nombre = stdin.readLineSync();
    print ('Hola $nombre');

    print("Ingrese un numero entero: ");
    int numero = int.parse(stdin.readLineSync()!);
    print ('Numero: $numero');

    print("Ingrese un decimal: ");
    double? valor = double.parse(stdin.readLineSync()!);
    print ('Hola $valor');

    print("Ingrese el primer numero: ");
    int a = int.parse(stdin.readLineSync()!);

    print("Ingrese el segundo numero: ");
    int b = int.parse(stdin.readLineSync()!);

    int suma = a+b;

    print('La suma es: $suma');
    
}