// ABSTRACCIÓN: el usuario de DispositivoRed solo sabe QUÉ puede pedirle.
// No necesita saber cómo se implementa internamente cada dispositivo.
abstract class DispositivoRed {
  final String id;
  final String nombre;
  final String ip;

  DispositivoRed({
    required this.id,
    required this.nombre,
    required this.ip,
  });

  // Interfaz pública — QUÉ puede hacer cualquier dispositivo
  void encender();
  void apagar();
  Map<String, dynamic> obtenerMetricas();

  // Método concreto compartido — construido sobre la abstracción
  void verificarSalud() {
    final metricas = obtenerMetricas();  // llama al método abstracto
    print('[$nombre] Métricas: $metricas');
  }

  bool get activo;
  String get estado => activo ? 'en línea' : 'fuera de línea';

  @override
  String toString() => '$nombre ($ip) — $estado';
}

class Switch extends DispositivoRed {
  final int puertos;
  int  paquetesPorSeg;
  bool _activo = false;

  Switch({
    required super.id,
    required super.nombre,
    required super.ip,
    required this.puertos,
    this.paquetesPorSeg = 0,
  });

  @override bool get activo => _activo;
  @override void encender() { _activo = true;  print('$nombre: encendido ✅'); }
  @override void apagar()   { _activo = false; print('$nombre: apagado ❌');   }

  @override
  Map<String, dynamic> obtenerMetricas() => {
    'puertos':      puertos,
    'paquetes_seg': paquetesPorSeg,
  };
}

class PuntoAccesoWifi extends DispositivoRed {
  final String ssid;
  int  clientesConectados;
  bool _activo = false;

  PuntoAccesoWifi({
    required super.id,
    required super.nombre,
    required super.ip,
    required this.ssid,
    this.clientesConectados = 0,
  });

  @override bool get activo => _activo;
  @override void encender() { _activo = true;  print('$nombre: transmitiendo SSID "$ssid" ✅'); }
  @override void apagar()   { _activo = false; print('$nombre: SSID "$ssid" apagado ❌');        }

  @override
  Map<String, dynamic> obtenerMetricas() => {
    'ssid':     ssid,
    'clientes': clientesConectados,
  };
}

void main() {
  final sw = Switch(
    id: 'SW-001', nombre: 'core-switch',
    ip: '10.0.0.1', puertos: 48, paquetesPorSeg: 42000,
  );
  final ap = PuntoAccesoWifi(
    id: 'AP-001', nombre: 'sala-wifi',
    ip: '10.0.0.5', ssid: 'Oficina-5G', clientesConectados: 12,
  );

  sw.encender();
  ap.encender();

  // verificarSalud no sabe qué tipo de dispositivo es — solo usa la abstracción
  for (final dispositivo in [sw, ap]) {
    dispositivo.verificarSalud();
  }
}