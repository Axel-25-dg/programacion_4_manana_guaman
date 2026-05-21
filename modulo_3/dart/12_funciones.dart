// required → el parámetro es obligatorio
// sin required → es opcional (necesita valor por defecto o ser nullable)
void configurarServidor({
  required String host,
  required int    puerto,
  bool   ssl        = true,
  int    timeoutSeg = 30,
}) {
  final protocolo = ssl ? 'https' : 'http';
  print('Conectando a $protocolo://$host:$puerto (timeout: ${timeoutSeg}s)');
}

void main() {
  // Los nombrados pueden pasarse en cualquier orden
  configurarServidor(
    host:       'db.miempresa.com',
    puerto:     5432,
    ssl:        false,
    timeoutSeg: 60,
  );

  // Solo los obligatorios — los opcionales toman su valor por defecto
  configurarServidor(
    host:   'api.miempresa.com',
    puerto: 443,
  );
}