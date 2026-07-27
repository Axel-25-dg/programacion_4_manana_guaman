import 'package:flutter/material.dart';

class FormularioServidor extends StatefulWidget {
  final void Function(Map<String, String> datos) onGuardar;
  const FormularioServidor({super.key, required this.onGuardar});

  @override
  State<FormularioServidor> createState() => _FormularioServidorState();
}

class _FormularioServidorState extends State<FormularioServidor> {
  final _formKey = GlobalKey<FormState>();

  final _ctrlNombre    = TextEditingController();
  final _ctrlIdioma    = TextEditingController();
  final _ctrlDuracion  = TextEditingController(text: '40');
  final _ctrlCategoria = TextEditingController();

  final _focusIdioma    = FocusNode();
  final _focusDuracion  = FocusNode();
  final _focusCategoria = FocusNode();

  String _nivel       = 'B1';
  String _modalidad   = 'Online';
  bool   _certificado = true;

  static final _regexDuracion = RegExp(r'^\d+$');
  static const  _nivelesValidos = ['A1','A2','B1','B2','C1','C2','N5','N4','N3','N2','N1'];

  @override
  void dispose() {
    _ctrlNombre.dispose();
    _ctrlIdioma.dispose();
    _ctrlDuracion.dispose();
    _ctrlCategoria.dispose();
    _focusIdioma.dispose();
    _focusDuracion.dispose();
    _focusCategoria.dispose();
    super.dispose();
  }

  void _guardar() {
    if (!_formKey.currentState!.validate()) return;

    widget.onGuardar({
      'nombre':        _ctrlNombre.text,
      'idioma':        _ctrlIdioma.text,
      'duracionHoras': _ctrlDuracion.text,
      'categoria':     _ctrlCategoria.text,
      'nivel':         _nivel,
      'modalidad':     _modalidad,
      'certificado':   _certificado.toString(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView( 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller:      _ctrlNombre,
              decoration:      const InputDecoration(
                labelText:  'Nombre del curso',
                hintText:   'Inglés Conversacional Avanzado',
                prefixIcon: Icon(Icons.menu_book),
                border:     OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => _focusIdioma.requestFocus(),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'El nombre del curso es obligatorio';
                if (v.length < 3)                  return 'Mínimo 3 caracteres';
                return null;
              },
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller:      _ctrlIdioma,
              focusNode:       _focusIdioma,
              decoration:      const InputDecoration(
                labelText:  'Idioma',
                hintText:   'Inglés, Francés, Japonés, Alemán...',
                prefixIcon: Icon(Icons.translate),
                border:     OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => _focusDuracion.requestFocus(),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'El idioma es obligatorio';
                if (v.length < 2) return 'Escribe el nombre completo del idioma';
                return null;
              },
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller:      _ctrlDuracion,
              focusNode:       _focusDuracion,
              decoration:      const InputDecoration(
                labelText:  'Duración (horas)',
                hintText:   '20, 40, 60, 80...',
                prefixIcon: Icon(Icons.timelapse),
                border:     OutlineInputBorder(),
              ),
              keyboardType:    TextInputType.number,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) => _focusCategoria.requestFocus(),
              validator: (v) {
                if (v == null || v.isEmpty) return 'La duración es obligatoria';
                if (!_regexDuracion.hasMatch(v)) return 'Solo números enteros';
                final h = int.tryParse(v);
                if (h == null) return 'Duración inválida';
                if (h < 1 || h > 500) return 'Rango permitido: 1–500 horas';
                return null;
              },
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller:      _ctrlCategoria,
              focusNode:       _focusCategoria,
              decoration:      const InputDecoration(
                labelText:  'Categoría',
                hintText:   'Conversación, Gramática, Vocabulario...',
                prefixIcon: Icon(Icons.label_outline),
                border:     OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'La categoría es obligatoria' : null,
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: _nivel,
              decoration: const InputDecoration(
                labelText:  'Nivel MCER / JLPT',
                prefixIcon: Icon(Icons.school),
                border:     OutlineInputBorder(),
              ),
              items: _nivelesValidos
                  .map((n) => DropdownMenuItem(value: n, child: Text(n)))
                  .toList(),
              onChanged: (v) => setState(() => _nivel = v!),
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: _modalidad,
              decoration: const InputDecoration(
                labelText:  'Modalidad',
                prefixIcon: Icon(Icons.place_outlined),
                border:     OutlineInputBorder(),
              ),
              items: ['Online', 'Presencial', 'Híbrido', 'Autodidacta']
                  .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                  .toList(),
              onChanged: (v) => setState(() => _modalidad = v!),
            ),
            const SizedBox(height: 12),

            SwitchListTile(
              title:     const Text('Incluye certificado'),
              subtitle:  const Text('Certificado oficial al finalizar'),
              value:     _certificado,
              onChanged: (v) => setState(() => _certificado = v),
              secondary: const Icon(Icons.workspace_premium),
            ),
            const SizedBox(height: 16),

            Row(children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    _formKey.currentState?.reset();
                    setState(() {
                      _nivel       = 'B1';
                      _modalidad   = 'Online';
                      _certificado = true;
                    });
                    _ctrlDuracion.text = '40';
                  },
                  child: const Text('Limpiar'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: FilledButton.icon(
                  onPressed: _guardar,
                  icon:  const Icon(Icons.how_to_reg),
                  label: const Text('Guardar curso'),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
