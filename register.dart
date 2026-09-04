import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/providers/auth_provider.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() =>
      _RegisterPageState();
}

class _RegisterPageState
    extends ConsumerState<RegisterPage> {
  final TextEditingController nombreController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  final TextEditingController confirmarController =
      TextEditingController();

  void registrar() {
    final nombre =
        nombreController.text.trim();

    final email =
        emailController.text.trim();

    final password =
        passwordController.text;

    final confirmar =
        confirmarController.text;

    if (nombre.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmar.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Completá todos los campos",
          ),
        ),
      );
      return;
    }

    if (!email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Ingresá un email válido",
          ),
        ),
      );
      return;
    }

    if (password.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "La contraseña debe tener al menos 4 caracteres",
          ),
        ),
      );
      return;
    }

    if (password != confirmar) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Las contraseñas no coinciden",
          ),
        ),
      );
      return;
    }

    final registrado = ref
        .read(authProvider.notifier)
        .registrar(
          nombre: nombre,
          email: email,
          password: password,
        );

    if (!registrado) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Ese email ya está registrado",
          ),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Usuario registrado correctamente",
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    nombreController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrarse"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(
                labelText: "Nombre",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: emailController,
              keyboardType:
                  TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "email",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "contraseña",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: confirmarController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Confirmar contraseña",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: registrar,
                child: const Text(
                  "Registrarse",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
