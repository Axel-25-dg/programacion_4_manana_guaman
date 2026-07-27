import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    if (usuario == 'estudiante' && password == 'idiomas2024') {
      state = Autenticado(usuario);
    } else {
      state = const ErrorAuth('Correo o contraseña incorrectos');
      await Future.delayed(const Duration(seconds: 2));
      state = const SinSesion();
    }
  }

  void logout() => state = const SinSesion();
}

final authProvider =
    NotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);
