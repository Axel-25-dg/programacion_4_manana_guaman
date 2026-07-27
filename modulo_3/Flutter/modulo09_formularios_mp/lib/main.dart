// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/formulario_servidor.dart';
import 'models/servidor_ssh.dart';
import 'widgets/fila_servidor.dart';
import 'screens/pantalla_servidores.dart';
import 'screens/pantalla_busqueda.dart';

// ┌──────────────────────────────────────────────────────────────────┐
// │  Cambia este número y guarda (Ctrl+S) para navegar entre pasos. │
// │  1  Paso 1  TextField + TextEditingController + FocusNode       │
// │  2  Paso 2  Form + TextFormField + validación                   │
// │  3  Paso 3  Modelo + ListView.builder + ListTile acciones       │
// │  4  Paso 4  GridView.builder + toggle lista/grid                │
// │  5  Paso 5  SearchBar + filtrado en tiempo real                 │
// └──────────────────────────────────────────────────────────────────┘
const int paso = 5;

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF1B5E20),
    ),
    useMaterial3: true,
  ),
  home: switch (paso) {
    1 => const _Paso1(),
    2 => const _Paso2(),
    3 => const _Paso3(),
    4 => const PantallaServidores(),
    5 => const PantallaBusqueda(),
    _ => Scaffold(body: Center(child: Text('Paso $paso no definido'))),
  },
));

// ─── Paso 1 ────────────────────────────────────────────────────────────
class _Paso1 extends StatefulWidget {
  const _Paso1();
  @override
  State<_Paso1> createState() => _Paso1State();
}

class _Paso1State extends State<_Paso1> {
  final _ctrlNombreCurso = TextEditingController();
  final _ctrlIdioma      = TextEditingController();
  final _ctrlHoras       = TextEditingController(text: '40');
  final _focusIdioma     = FocusNode();
  final _focusHoras      = FocusNode();

  @override
  void dispose() {
    _ctrlNombreCurso.dispose();
    _ctrlIdioma.dispose();
    _ctrlHoras.dispose();
    _focusIdioma.dispose();
    _focusHoras.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title:           const Text('Inscribirse a curso'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller:      _ctrlNombreCurso,
              decoration:      const InputDecoration(
                labelText:  'Nombre del curso',
                hintText:   'Inglés Conversacional Intermedio',
                prefixIcon: Icon(Icons.menu_book),
                border:     OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
              onSubmitted:     (_) => _focusIdioma.requestFocus(),
            ),
            const SizedBox(height: 12),
            TextField(
              controller:      _ctrlIdioma,
              focusNode:       _focusIdioma,
              decoration:      const InputDecoration(
                labelText:  'Idioma',
                hintText:   'Inglés, Francés, Japonés...',
                prefixIcon: Icon(Icons.translate),
                border:     OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
              onSubmitted:     (_) => _focusHoras.requestFocus(),
            ),
            const SizedBox(height: 12),
            TextField(
              controller:      _ctrlHoras,
              focusNode:       _focusHoras,
              decoration:      const InputDecoration(
                labelText:  'Duración en horas',
                prefixIcon: Icon(Icons.timelapse),
                border:     OutlineInputBorder(),
              ),
              keyboardType:    TextInputType.number,
              textInputAction: TextInputAction.done,
              onSubmitted:     (_) => FocusScope.of(context).unfocus(),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () {
                FocusScope.of(context).unfocus();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Inscribiéndose al curso "${_ctrlNombreCurso.text}" '
                      '(${_ctrlIdioma.text} · ${_ctrlHoras.text}h)',
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon:  const Icon(Icons.how_to_reg),
              label: const Text('Inscribirme'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () {
                _ctrlNombreCurso.clear();
                _ctrlIdioma.clear();
                _ctrlHoras.text = '40';
              },
              child: const Text('Limpiar campos'),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Paso 2 ────────────────────────────────────────────────────────────
class _Paso2 extends StatelessWidget {
  const _Paso2();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title:           const Text('Nuevo curso'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: FormularioServidor(
          onGuardar: (datos) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'Guardado: ${datos['nombre']} — ${datos['idioma']} (${datos['nivel']}) · ${datos['duracionHoras']}h'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
      ),
    );
  }
}

// ─── Paso 3 ────────────────────────────────────────────────────────────
class _Paso3 extends StatefulWidget {
  const _Paso3();
  @override
  State<_Paso3> createState() => _Paso3State();
}

class _Paso3State extends State<_Paso3> {
  final _cursos = [
    ServidorSSH(id:'1', nombre:'Inglés Conversacional', idioma:'Inglés', nivel:'B2', duracionHoras:60, modalidad:'Online',    certificado:true,  favorito:true,  categoria:'conversación'),
    ServidorSSH(id:'2', nombre:'Gramática Francesa',   idioma:'Francés', nivel:'A2', duracionHoras:40, modalidad:'Presencial', certificado:true,  categoria:'gramática'),
    ServidorSSH(id:'3', nombre:'Kanjis N5-N4',         idioma:'Japonés', nivel:'N5', duracionHoras:80, modalidad:'Online',    certificado:false, categoria:'vocabulario'),
    ServidorSSH(id:'4', nombre:'Alemán para viajar',   idioma:'Alemán',  nivel:'A1', duracionHoras:20, modalidad:'Híbrido',   certificado:false, categoria:'frases útiles'),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title:           Text('Cursos (${_cursos.length})'),
        backgroundColor: cs.primaryContainer,
        foregroundColor: cs.onPrimaryContainer,
      ),
      body: _cursos.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.translate_outlined, size: 56, color: cs.onSurfaceVariant),
                  const SizedBox(height: 12),
                  Text('Sin cursos inscritos',
                      style: TextStyle(color: cs.onSurfaceVariant)),
                ],
              ),
            )
          : ListView.separated(
              itemCount:        _cursos.length,
              separatorBuilder: (_, __) =>
                  const Divider(height: 1, indent: 72),
              itemBuilder: (ctx, i) => FilaServidor(
                servidor:   _cursos[i],
                onFavorito: () => setState(() =>
                    _cursos[i].favorito = !_cursos[i].favorito),
                onEliminar: () =>
                    setState(() => _cursos.removeAt(i)),
              ),
            ),
    );
  }
}
