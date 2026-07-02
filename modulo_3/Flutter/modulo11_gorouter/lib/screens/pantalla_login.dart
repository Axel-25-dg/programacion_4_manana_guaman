// lib/screens/pantalla_login.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class PantallaLogin extends ConsumerStatefulWidget {
  const PantallaLogin({super.key});

  @override
  ConsumerState<PantallaLogin> createState() => _PantallaLoginState();
}

class _PantallaLoginState extends ConsumerState<PantallaLogin> {
  final _formKey  = GlobalKey<FormState>();
  final _ctrlUser = TextEditingController();
  final _ctrlPass = TextEditingController();

  @override
  void dispose() {
    _ctrlUser.dispose();
    _ctrlPass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final cs        = Theme.of(context).colorScheme;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.terminal, size: 64, color: cs.primary),
                const SizedBox(height: 16),
                const Text('Monitor SSH',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 32),

                TextFormField(
                  controller: _ctrlUser,
                  decoration: const InputDecoration(
                    labelText:  'Usuario',
                    prefixIcon: Icon(Icons.person_outline),
                    border:     OutlineInputBorder(),
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'Requerido' : null,
                ),
                const SizedBox(height: 12),

                TextFormField(
                  controller:  _ctrlPass,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText:  'Contrasena',
                    prefixIcon: Icon(Icons.lock_outline),
                    border:     OutlineInputBorder(),
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'Requerida' : null,
                ),
                const SizedBox(height: 8),

                if (authState is ErrorAuth)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(authState.mensaje,
                        style: TextStyle(color: cs.error)),
                  ),
                const SizedBox(height: 8),

                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: authState is Cargando
                        ? null
                        : () {
                            if (!_formKey.currentState!.validate()) return;
                            ref.read(authProvider.notifier).login(
                                _ctrlUser.text, _ctrlPass.text);
                          },
                    child: authState is Cargando
                        ? const SizedBox(
                            width: 20, height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Iniciar sesion'),
                  ),
                ),
                const SizedBox(height: 8),
                Text('Pista: admin / admin123',
                    style: TextStyle(fontSize: 11, color: cs.onSurfaceVariant)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
