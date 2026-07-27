class MetricaServidor {
  final String servidor;
  final double cpu;
  final double ram;
  final double ssd; // <--- 1. Agrega esta línea aquí
  final int conexiones;

  const MetricaServidor({
    required this.servidor,
    required this.cpu,
    required this.ram,
    required this.ssd, // <--- 2. Agrega esta línea en el constructor
    required this.conexiones,
  });
}