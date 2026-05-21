void main() {
  final temperaturas = [36.1, 37.8, 39.2, 36.5, 38.7, 35.9];

  final conFiebre = temperaturas.where((t) => t > 37.5);
  print(conFiebre.toList());  // [37.8, 39.2, 38.7]

  final normales = temperaturas.where((t) => t >= 36.0 && t <= 37.5);
  print(normales.toList());   // [36.1, 36.5]
}