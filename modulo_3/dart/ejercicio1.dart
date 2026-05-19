import 'dart:io';
void main(){
    print("Ingrese su calificacion: ");
    int calificacion  =int.parse(stdin.readLineSync()!);

    if (calificacion >=7){
        print('Aprobado');
    }else if(calificacion<7){
        print('Reprobado');
    }
}