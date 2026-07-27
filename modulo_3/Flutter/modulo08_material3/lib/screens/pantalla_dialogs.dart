// lib/screens/pantalla_dialogs.dart
import 'package:flutter/material.dart';

class PantallaDialogs extends StatelessWidget {
  const PantallaDialogs({super.key});

  void _mostrarSnackBar(BuildContext context, {String tipo = 'exito'}) {
    final cs = Theme.of(context).colorScheme;
    
    String mensaje = 'Conexión SSH establecida correctamente';
    Color? fondo;
    String etiquetaAccion = 'Deshacer';
    VoidCallback alPresionar = () {};

    if (tipo == 'error') {
      mensaje = 'Error: no se pudo conectar al servidor';
      fondo = cs.error;
      etiquetaAccion = 'Deshacer';
    } else if (tipo == 'info') {
      mensaje = 'Buscando actualizaciones de métricas...';
      fondo = cs.secondary;
      etiquetaAccion = 'Reintentar';
      alPresionar = () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reconectando con los nodos...'), behavior: SnackBarBehavior.floating),
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
        title:   const Text('Eliminar servidor'),
        content: const Text(
          '¿Estás seguro de que deseas eliminar prod-web-01?\n'
          'Esta acción no se puede deshacer.',
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
          content: Text('Servidor eliminado correctamente'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _mostrarFormulario(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final ctrlNombre = TextEditingController();
    final ctrlIp     = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Agregar servidor'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller:  ctrlNombre,
                decoration:  const InputDecoration(
                  labelText: 'Nombre',
                  prefixIcon: Icon(Icons.dns_outlined),
                ),
                validator:   (v) => v == null || v.trim().isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: ctrlIp,
                decoration: const InputDecoration(
                  labelText: 'Dirección IP',
                  prefixIcon: Icon(Icons.lan_outlined),
                  hintText: '192.168.1.1',
                ),
                validator:  (v) {
                  if (v == null || v.trim().isEmpty) return 'Campo requerido';
                  final partes = v.split('.');
                  if (partes.length != 4 || partes.any((p) => int.tryParse(p) == null)) {
                    return 'Formato: 192.168.1.1';
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
          content: Text('Servidor "${ctrlNombre.text}" agregado'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _mostrarIp(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final ctrlNombre = TextEditingController();
    final ctrlServidor = TextEditingController();
    final ctrlIp     = TextEditingController();

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Agregar IP'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller:  ctrlNombre,
                  decoration:  const InputDecoration(
                    labelText: 'Nombre de la interfaz',
                    prefixIcon: Icon(Icons.label_outline),
                    hintText: 'eth0 o wan',
                  ),
                  validator:   (v) => v == null || v.trim().isEmpty ? 'Campo requerido' : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller:  ctrlServidor,
                  decoration:  const InputDecoration(
                    labelText: 'Servidor Asociado',
                    prefixIcon: Icon(Icons.dns_outlined),
                  ),
                  validator:   (v) => v == null || v.trim().isEmpty ? 'Campo requerido' : null,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: ctrlIp,
                  decoration: const InputDecoration(
                    labelText: 'Dirección IP',
                    prefixIcon: Icon(Icons.lan_outlined),
                    hintText: '192.168.1.1',
                  ),
                  validator:  (v) {
                    if (v == null || v.trim().isEmpty) return 'Campo requerido';
                    final partes = v.split('.');
                    if (partes.length != 4 || partes.any((p) => int.tryParse(p) == null)) {
                      return 'Formato: 192.168.1.1';
                    }
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
            child: const Text('Agregar'),
          ),
        ],
      ),
    );

    if (!context.mounted) return;
    
    if (ctrlIp.text.trim().isNotEmpty && ctrlNombre.text.trim().isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Interfaz "${ctrlNombre.text}" configurada con IP: ${ctrlIp.text}'),
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
            label: const Text('SnackBar de éxito'),
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: cs.error,
              foregroundColor: cs.onError,
            ),
            onPressed: () => _mostrarSnackBar(context, tipo: 'error'),
            icon:  const Icon(Icons.error_outline),
            label: const Text('SnackBar de error'),
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: cs.secondaryContainer,
              foregroundColor: cs.onSecondaryContainer,
            ),
            onPressed: () => _mostrarSnackBar(context, tipo: 'info'),
            icon:  const Icon(Icons.sync_outlined),
            label: const Text('SnackBar Informativo (Reintentar)'),
          ),

          const Divider(height: 32),

          // ── AlertDialog ───────────────────────────────────────────
          Text('AlertDialog', style: text.labelLarge?.copyWith(color: cs.primary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          
          // CAMBIO: Botón de eliminación estilizado con contenedor de error semántico (M3)
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: cs.errorContainer,
              foregroundColor: cs.onErrorContainer,
            ),
            onPressed: () => _mostrarConfirmacion(context),
            icon:  const Icon(Icons.delete_outline),
            label: const Text('Eliminar servidor (confirmación)'),
          ),
          const SizedBox(height: 8),
          FilledButton.tonal(
            onPressed: () => _mostrarFormulario(context),
            child: const Text('Agregar servidor (formulario)'),
          ),
          const SizedBox(height: 8),
          
          // CAMBIO: Botón outlined con tonalidades primarias para diferenciar acciones de formulario
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: cs.primary,
              side: BorderSide(color: cs.primary),
            ),
            onPressed: () => _mostrarIp(context),
            icon:  const Icon(Icons.lan_outlined),
            label: const Text('Agregar ip (formulario)'),
          ),
        ],
      ),
    );
  }
}