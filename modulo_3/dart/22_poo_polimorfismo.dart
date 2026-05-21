// Reusamos la jerarquía de Forma del ejercicio 1a
abstract class Figura {
  String get nombre;
  double calcularArea();
}

class Cuadrado extends Figura {
  final double lado;
  Cuadrado(this.lado);
  @override String get nombre => 'Cuadrado';
  @override double calcularArea() => lado * lado;
}

class TrianguloRectangulo extends Figura {
  final double base, altura;
  TrianguloRectangulo(this.base, this.altura);
  @override String get nombre => 'Triángulo';
  @override double calcularArea() => (base * altura) / 2;
}

class CirculoPoli extends Figura {
  final double radio;
  CirculoPoli(this.radio);
  @override String get nombre => 'Círculo';
  @override double calcularArea() => 3.1416 * radio * radio;
}

// POLIMORFISMO: una sola función trabaja con cualquier Figura
void imprimirArea(Figura figura) {
  print('${figura.nombre}: ${figura.calcularArea().toStringAsFixed(2)} u²');
}

void main() {
  final figuras = <Figura>[
    Cuadrado(4),
    TrianguloRectangulo(6, 3),
    CirculoPoli(5),
  ];

  // Misma llamada — comportamiento diferente según el tipo real
  for (final f in figuras) {
    imprimirArea(f);
  }

  // Figura con mayor área — POLIMORFISMO con reduce
  final mayor = figuras.reduce((a, b) => a.calcularArea() > b.calcularArea() ? a : b);
  print('\nFigura más grande: ${mayor.nombre}');
}