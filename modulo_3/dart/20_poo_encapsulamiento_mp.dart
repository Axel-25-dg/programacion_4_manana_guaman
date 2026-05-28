class ProgresoEstudiante {
  final String nombre;
  int _xp;

  ProgresoEstudiante(this.nombre, int xpInicial)
      : _xp = xpInicial;

  int get xp => _xp;

  void ganarXP(int cantidad) {
    if (cantidad <= 0) return;
    _xp += cantidad;
    print('$nombre gano $cantidad XP. Total: $_xp');
  }

  void penalizarXP(int cantidad) {
    if (cantidad <= 0) return;
    _xp = (_xp - cantidad < 0) ? 0 : _xp - cantidad;
    print('$nombre perdio $cantidad XP. Total: $_xp');
  }
}

void main() {
  final estudiante = ProgresoEstudiante('Henry', 100);

  estudiante.ganarXP(50);
  estudiante.penalizarXP(20);
  print('XP final de ${estudiante.nombre}: ${estudiante.xp}');
}
