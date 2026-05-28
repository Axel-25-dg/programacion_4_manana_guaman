void bienvenida() {
  print('Bienvenido a la App de Idiomas');
}

void mostrarXPMeta() {
  print('Meta diaria: 500 XP');
}

int calcularTotalXP(int base, int bono) {
  return base + bono;
}

int duplicarPuntaje(int puntaje) => puntaje * 2;

void imprimirSeccion(String titulo) {
  print('*** $titulo ***');
}

String formatearXP(int xp) => '$xp XP acumulados';

formatearXPSinTipo(int xp) => '$xp XP';

void main() {
  bienvenida();
  mostrarXPMeta();
  print(calcularTotalXP(100, 50));
  print(duplicarPuntaje(75));
  imprimirSeccion('Modulo 1');
  print(formatearXP(1500));
  print(formatearXPSinTipo(2000));
}
