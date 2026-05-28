void main() {
  final bonoXP = (int base) => base * 2;
  print('Bono aplicado: ${bonoXP(100)}');

  final calcularXPFinal = (int base, double multiplicador) {
    final extra = base * (multiplicador - 1);
    return base + extra.toInt();
  };
  print('XP Final: ${calcularXPFinal(100, 1.5)}');

  final rachas = [15, 30, 5, 45, 10];
  rachas.sort((a, b) => b.compareTo(a));
  print('Rachas ordenadas: $rachas');
}
