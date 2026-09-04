import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/usuario.dart';

class AuthState {
  final List<Usuario> usuarios;
  final Usuario? usuarioAutenticado;

  AuthState({
    required this.usuarios,
    required this.usuarioAutenticado,
  });

  AuthState copyWith({
    List<Usuario>? usuarios,
    Usuario? usuarioAutenticado,
    bool borrarUsuario = false,
  }) {
    return AuthState(
      usuarios: usuarios ?? this.usuarios,
      usuarioAutenticado: borrarUsuario
          ? null
          : usuarioAutenticado ?? this.usuarioAutenticado,
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    return AuthState(
      usuarios: [
        Usuario(
          nombre: 'Bob Esponja',
          email: 'bob@gmail.com',
          password: '1234',
        ),
        Usuario(
          nombre: 'Alan Barrutia',
          email: 'alan@gmail.com',
          password: '0942',
        ),
        Usuario(
          nombre: 'Maximo Perez',
          email: 'maximo@gmail.com',
          password: 'HOLA123',
        ),
        Usuario(
          nombre: 'Juan Piccicaco',
          email: 'juan@gmail.com',
          password: '8877',
        ),
        Usuario(
          nombre: 'Alejandro Perman',
          email: 'alejandro@gmail.com',
          password: 'FAU234',
        ),
      ],
      usuarioAutenticado: null,
    );
  }

  bool login(String email, String password) {
    try {
      final usuario = state.usuarios.firstWhere(
        (u) =>
            u.email.toLowerCase() == email.toLowerCase() &&
            u.password == password,
      );

      state = state.copyWith(
        usuarioAutenticado: usuario,
      );

      return true;
    } catch (_) {
      return false;
    }
  }

  bool registrar({
    required String nombre,
    required String email,
    required String password,
  }) {
    final emailExiste = state.usuarios.any(
      (u) => u.email.toLowerCase() == email.toLowerCase(),
    );

    if (emailExiste) {
      return false;
    }

    final nuevoUsuario = Usuario(
      nombre: nombre,
      email: email,
      password: password,
    );

    state = state.copyWith(
      usuarios: [
        ...state.usuarios,
        nuevoUsuario,
      ],
    );

    return true;
  }

  void logout() {
    state = state.copyWith(
      borrarUsuario: true,
    );
  }
}

final authProvider =
    NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
