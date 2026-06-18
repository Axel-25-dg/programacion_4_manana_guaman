// lib/main.dart
import 'package:flutter/material.dart';
import 'package:modulo06_widgets/widgets/catalogo_basicos.dart';
import 'package:modulo06_widgets/widgets/etiqueta.dart';
import 'package:modulo06_widgets/widgets/servicio_estado.dart';
import 'package:modulo06_widgets/widgets/contador_limitado.dart';
import 'package:modulo06_widgets/widgets/reloj.dart';
import 'package:modulo06_widgets/screens/pantalla_contexto.dart';
import 'package:modulo06_widgets/widgets/indicador.dart'; // <-- Nuevo import

// ┌──────────────────────────────────────────────────────────────────┐
// │  Cambia este número y guarda (Ctrl+S) para navegar entre pasos.  │
// │  1  Paso 1   StatelessWidget mínimo                              │
// │  2  Paso 1b  Widgets básicos — catálogo                          │
// │  3  Paso 2   StatelessWidget con parámetros                      │
// │  4  Paso 3   StatefulWidget / setState / cambio de estatus       │
// │  5  Paso 3b  Parámetros en StatefulWidget                        │
// │  6  Paso 4   Ciclo de vida con Timer                             │
// │  7  Paso 5   BuildContext                                        │
// │  8  Paso 6   Composición de widgets                              │
// └──────────────────────────────────────────────────────────────────┘
const int paso = 8; // <-- Cambiado a 8

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.teal,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  ),
  home: switch (paso) {
    1 => const Scaffold(body: Center(child: Saludo())),
    2 => const CatalogoBasicos(),
    3 => const Scaffold(
      body: Center(
        child: Wrap(
          spacing:    12,
          runSpacing: 8,
          children: [
            Etiqueta(texto: 'Activo',    color: Colors.green),
            Etiqueta(texto: 'Error',     color: Colors.red,    relleno: true),
            Etiqueta(texto: 'En espera', color: Colors.orange),
            Etiqueta(texto: 'Crítico',   color: Colors.red,    fontSize: 16, relleno: true),
            Etiqueta(texto: 'Info',      color: Colors.blue,   fontSize: 11),
          ],
        ),
      ),
    ),
    4 => const Scaffold(
      body: Center(
        child: ServicioEstado(nombre: 'nginx-proxy'),
      ),
    ),
    5 => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ContadorLimitado(
              etiqueta: 'Intentos de login',
              limite:   1,
              color:    Colors.deepPurple,
              textoBoton: 'Intentar',
              pasoIncremento: 1,
              onLimite: () => debugPrint('¡Cuenta bloqueada!'),
            ),
            const SizedBox(height: 40),
            ContadorLimitado(
              etiqueta: 'Conexiones activas',
              limite:   10,
              color:    Colors.indigo,
            ),
          ],
        ),
      ),
    ),
    6 => Scaffold(
      appBar: AppBar(title: const Text('Cronómetro')),
      body: const Center(child: Reloj()),
    ),
    7 => const PantallaContexto(),
    8 => const Scaffold( // <-- Nuevo caso para el Paso 6
      body: Center(
        child: Wrap(
          spacing:    32,
          runSpacing: 24,
          alignment:  WrapAlignment.center,
          children: [
            Indicador(
              label: 'Servidores activos', 
              valor: '8',
              color: Colors.green, 
              icono: Icons.dns,
            ),
            Indicador(
              label: 'Alertas críticas',   
              valor: '2',
              color: Colors.red,   
              icono: Icons.warning_amber,
              subtitulo: 'Requieren atención',
              opacidad: 0.5, // Aplicando prueba de opacidad reducida
            ),
            Indicador(
              label: 'Tráfico',            
              valor: '4.2 GB',
              color: Colors.indigo,
              icono: Icons.cloud, // Aplicando prueba de nuevo icono sin alterar el widget
            ),
            Indicador(
              label: 'Uptime',             
              valor: '99.8%',
              color: Colors.teal, 
              subtitulo: 'Últimos 30 días',
            ),
            Indicador( // Aplicando prueba de duplicado con diferente color
              label: 'Uptime',             
              valor: '92.1%',
              color: Colors.orange, 
              subtitulo: 'Región alternativa',
            ),
          ],
        ),
      ),
    ),
    _ => Scaffold(body: Center(child: Text('Paso $paso: crea el widget primero'))),
  },
));

class Saludo extends StatelessWidget {
  const Saludo({super.key});

  @override
  Widget build(BuildContext context) {   
    return const SelectableText(
      'La Tri está obligada a ganar tras la derrota ante Costa de Marfil.',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold, 
        letterSpacing: 4,
        color: Colors.deepPurple,
        shadows: [
          Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(2,2)),
        ]
      ),
      textAlign: TextAlign.left,
      maxLines: 3,
    );
  }
}