// lib/main.dart
import 'package:flutter/material.dart';
import 'package:modulo06_widgets/widgets/catalogo_basicos.dart';
import 'package:modulo06_widgets/widgets/etiqueta.dart';
import 'package:modulo06_widgets/widgets/servicio_estado.dart';
import 'package:modulo06_widgets/widgets/contador_limitado.dart';
import 'package:modulo06_widgets/widgets/reloj.dart';
import 'package:modulo06_widgets/screens/pantalla_contexto.dart';
import 'package:modulo06_widgets/widgets/indicador.dart';

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
const int paso = 8;

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
            Etiqueta(texto: 'Principiante A1', color: Colors.green),
            Etiqueta(texto: 'Avanzado C1',    color: Colors.red,    relleno: true),
            Etiqueta(texto: 'Intermedio B1',  color: Colors.orange),
            Etiqueta(texto: 'Experto C2',     color: Colors.purple, fontSize: 16, relleno: true),
            Etiqueta(texto: 'Elemental A2',   color: Colors.blue,   fontSize: 11),
          ],
        ),
      ),
    ),
    4 => const Scaffold(
      body: Center(
        child: ServicioEstado(nombre: 'Curso de Inglés'),
      ),
    ),
    5 => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ContadorLimitado(
              etiqueta: 'Palabras por aprender hoy',
              limite:   20,
              color:    Colors.deepPurple,
              textoBoton: 'Aprender palabra',
              pasoIncremento: 1,
              onLimite: () => debugPrint('¡Meta diaria completada!'),
            ),
            const SizedBox(height: 40),
            ContadorLimitado(
              etiqueta: 'Lecciones completadas',
              limite:   10,
              color:    Colors.indigo,
            ),
          ],
        ),
      ),
    ),
    6 => Scaffold(
      appBar: AppBar(title: const Text('Cronómetro de Estudio')),
      body: const Center(child: Reloj()),
    ),
    7 => const PantallaContexto(),
    8 => const Scaffold(
      body: Center(
        child: Wrap(
          spacing:    32,
          runSpacing: 24,
          alignment:  WrapAlignment.center,
          children: [
            Indicador(
              label: 'Palabras aprendidas', 
              valor: '348',
              color: Colors.green, 
              icono: Icons.menu_book,
            ),
            Indicador(
              label: 'Lecciones pendientes',   
              valor: '5',
              color: Colors.red,   
              icono: Icons.assignment_late,
              subtitulo: 'Revisar hoy',
              opacidad: 0.5,
            ),
            Indicador(
              label: 'Racha de días',            
              valor: '23',
              color: Colors.indigo,
              icono: Icons.local_fire_department,
            ),
            Indicador(
              label: 'Progreso total',             
              valor: '68%',
              color: Colors.teal, 
              subtitulo: 'Curso de Francés',
            ),
            Indicador(
              label: 'Horas de estudio',             
              valor: '42h',
              color: Colors.orange, 
              subtitulo: 'Último mes',
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
      'Aprender un nuevo idioma abre puertas a culturas, oportunidades y conexiones globales.',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold, 
        letterSpacing: 1,
        color: Colors.deepPurple,
        shadows: [
          Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(2,2)),
        ]
      ),
      textAlign: TextAlign.center,
      maxLines: 3,
    );
  }
}
