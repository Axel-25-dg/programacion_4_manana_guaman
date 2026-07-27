// lib/providers/auth_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Estado de autenticación con sealed class
sealed class AuthState { const AuthState(); }
class SinSesion   extends AuthState { const SinSesion(); }
class Cargando    extends AuthState { const Cargando(); }
class Autenticado extends AuthState {
  final String usuario;
  const Autenticado(this.usuario);
}
class ErrorAuth   extends AuthState {
  final String mensaje;
  const ErrorAuth(this.mensaje);
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() => const SinSesion();

  Future<void> login(String usuario, String password) async {
    state = const Cargando();
    await Future.delayed(const Duration(seconds: 1));

    if (usuario == 'admin' && password == 'admin123') {
      state = Autenticado(usuario);
    } else {
      state = const ErrorAuth('Usuario o contraseña incorrectos');
      await Future.delayed(const Duration(seconds: 2));
      state = const SinSesion();
    }
  }

  void logout() => state = const SinSesion();
}

final authProvider =
    NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
