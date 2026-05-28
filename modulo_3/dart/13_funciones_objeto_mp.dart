int calcularXPBasico(int n) => n * 10;
int calcularXPPremium(int n) => n * 20;

void main() {
  int Function(int) calculador;

  calculador = calcularXPBasico;
  print('XP Basico para 5 palabras: ${calculador(5)}');

  calculador = calcularXPPremium;
  print('XP Premium para 5 palabras: ${calculador(5)}');

  final listaCalculos = <int Function(int)>[calcularXPBasico, calcularXPPremium];
  for (final fn in listaCalculos) {
    print('Resultado del calculo: ${fn(10)}');
  }
}
