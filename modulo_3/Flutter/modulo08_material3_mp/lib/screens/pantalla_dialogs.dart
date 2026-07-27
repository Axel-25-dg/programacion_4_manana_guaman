// lib/screens/pantalla_dialogs.dart
import 'package:flutter/material.dart';

class PantallaDialogs extends StatelessWidget {
  const PantallaDialogs({super.key});

  void _mostrarSnackBar(BuildContext context, {String tipo = 'exito'}) {
    final cs = Theme.of(context).colorScheme;
    
    String mensaje = '¡Lección completada! +10 XP ganados';
    Color? fondo;
    String etiquetaAccion = 'Deshacer';
    VoidCallback alPresionar = () {};

    if (tipo == 'error') {
      mensaje = 'Error: respuesta incorrecta en el ejercicio';
      fondo = cs.error;
      etiquetaAccion = 'Reintentar';
    } else if (tipo == 'info') {
      mensaje = 'Sincronizando progreso con la nube...';
      fondo = cs.secondary;
      etiquetaAccion = 'Ver detalle';
      alPresionar = () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cargando estadísticas de aprendizaje...'), behavior: SnackBarBehavior.floating),
        );
      };
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensaje),
        backgroundColor: fondo,
        action: SnackBarAction(
          label: etiquetaAccion,
          textColor: fondo != null ? cs.onInverseSurface : null,
          onPressed: alPresionar,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _mostrarConfirmacion(BuildContext context) async {
    final confirmar = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        icon:    const Icon(Icons.warning_amber, color: Colors.orange, size: 28),
        title:   const Text('Eliminar curso'),
        content: const Text(
          '¿Estás seguro de que deseas eliminar el curso de Francés A2?\n'
          'Todo tu progreso y vocabulario se perderán.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child:     const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
              foregroundColor: Theme.of(ctx).colorScheme.onError,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (!context.mounted) return;

    if (confirmar == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Curso eliminado correctamente'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _mostrarFormulario(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final ctrlNombre = TextEditingController();
    final ctrlNivel  = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Agregar nuevo idioma'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller:  ctrlNombre,
                decoration:  const InputDecoration(
                  labelText: 'Nombre del idioma',
                  prefixIcon: Icon(Icons.translate_outlined),
                  hintText: 'ej. Italiano, Ruso, Árabe',
                ),
                validator:   (v) => v == null || v.trim().isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: ctrlNivel,
                decoration: const InputDecoration(
                  labelText: 'Nivel inicial',
                  prefixIcon: Icon(Icons.school_outlined),
                  hintText: 'A1, A2, B1, B2, C1, C2',
                ),
                validator:  (v) {
                  if (v == null || v.trim().isEmpty) return 'Campo requerido';
                  const niveles = ['A1','A2','B1','B2','C1','C2'];
                  if (!niveles.contains(v.trim().toUpperCase())) {
                    return 'Usa un nivel válido: A1-C2';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child:     const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(ctx);
              }
            },
            child: const Text('Agregar'),
          ),
        ],
      ),
    );

    if (!context.mounted) return;
    
    if (ctrlNombre.text.trim().isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Idioma "${ctrlNombre.text}" (${ctrlNivel.text}) agregado'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _mostrarMeta(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final ctrlNombre = TextEditingController();
    final ctrlIdioma = TextEditingController();
    final ctrlPalabras = TextEditingController(text: '20');

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Configurar meta diaria'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller:  ctrlNombre,
                  decoration:  const InputDecoration(
                    labelText: 'Nombre de la meta',
                    prefixIcon: Icon(Icons.label_outline),
                    hintText: 'Ruta de vocabulario diario',
                  ),
                  validator:   (v) => v == null || v.trim().isEmpty ? 'Campo requerido' : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller:  ctrlIdioma,
                  decoration:  const InputDecoration(
                    labelText: 'Idioma objetivo',
                    prefixIcon: Icon(Icons.language),
                    hintText: 'Inglés, Francés, etc.',
                  ),
                  validator:   (v) => v == null || v.trim().isEmpty ? 'Campo requerido' : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: ctrlPalabras,
                  decoration: const InputDecoration(
                    labelText: 'Palabras por día',
                    prefixIcon: Icon(Icons.format_list_numbered),
                    hintText: '10, 20, 50',
                  ),
                  keyboardType: TextInputType.number,
                  validator:  (v) {
                    if (v == null || v.trim().isEmpty) return 'Campo requerido';
                    final n = int.tryParse(v);
                    if (n == null || n < 1 || n > 200) return 'Valor entre 1 y 200';
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child:     const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(ctx);
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );

    if (!context.mounted) return;
    
    if (ctrlPalabras.text.trim().isNotEmpty && ctrlNombre.text.trim().isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Meta "${ctrlNombre.text}" para ${ctrlIdioma.text}: ${ctrlPalabras.text} palabras/día'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs   = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title:           const Text('SnackBar y Dialog'),
        backgroundColor: cs.surfaceContainerHighest,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // ── SnackBar ──────────────────────────────────────────────
          Text('SnackBar', style: text.labelLarge?.copyWith(color: cs.primary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          FilledButton.icon(
            onPressed: () => _mostrarSnackBar(context, tipo: 'exito'),
            icon:  const Icon(Icons.check_circle_outline),
            label: const Text('SnackBar de éxito (lección completada)'),
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: cs.error,
              foregroundColor: cs.onError,
            ),
            onPressed: () => _mostrarSnackBar(context, tipo: 'error'),
            icon:  const Icon(Icons.error_outline),
            label: const Text('SnackBar de error (ejercicio fallido)'),
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: cs.secondaryContainer,
              foregroundColor: cs.onSecondaryContainer,
            ),
            onPressed: () => _mostrarSnackBar(context, tipo: 'info'),
            icon:  const Icon(Icons.sync_outlined),
            label: const Text('SnackBar Informativo (Sincronización)'),
          ),

          const Divider(height: 32),

          // ── AlertDialog ───────────────────────────────────────────
          Text('AlertDialog', style: text.labelLarge?.copyWith(color: cs.primary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: cs.errorContainer,
              foregroundColor: cs.onErrorContainer,
            ),
            onPressed: () => _mostrarConfirmacion(context),
            icon:  const Icon(Icons.delete_outline),
            label: const Text('Eliminar curso (confirmación)'),
          ),
          const SizedBox(height: 8),
          FilledButton.tonal(
            onPressed: () => _mostrarFormulario(context),
            child: const Text('Agregar nuevo idioma (formulario)'),
          ),
          const SizedBox(height: 8),
          
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: cs.primary,
              side: BorderSide(color: cs.primary),
            ),
            onPressed: () => _mostrarMeta(context),
            icon:  const Icon(Icons.flag_outlined),
            label: const Text('Configurar meta diaria (formulario)'),
          ),
        ],
      ),
    );
  }
}
