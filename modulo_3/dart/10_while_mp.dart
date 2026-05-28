void main() {
  int xpPorGanar = 500;
  int sesiones = 0;

  while (xpPorGanar > 0) {
    final avance = xpPorGanar > 100 ? 100 : xpPorGanar;
    sesiones++;
    xpPorGanar -= avance;
    print('Sesion de estudio $sesiones: Ganaste $avance XP (Restante para meta: $xpPorGanar)');
  }

  int intentosExamen = 0;
  bool examenAprobado = false;

  do {
    intentosExamen++;
    print('Intento de examen #$intentosExamen...');
    if (intentosExamen == 2) examenAprobado = true;
  } while (!examenAprobado && intentosExamen < 3);

  print(examenAprobado
      ? 'Examen aprobado tras $intentosExamen intentos'
      : 'Has agotado tus intentos por hoy');
}
