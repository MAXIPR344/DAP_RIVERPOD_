import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/providers/auth_provider.dart';
import 'package:flutter_application_1/providers/productos_provider.dart';

class AppScreen extends ConsumerWidget {
  const AppScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final productos = ref.watch(productosProvider);

    final usuario = auth.usuarioAutenticado;

    if (usuario == null) {
      return const Scaffold(
        body: Center(child: Text("No hay usuario autenticado")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenido ${usuario.nombre}"),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authProvider.notifier).logout();

              context.go('/');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: productos.isEmpty
          ? const Center(
              child: Text("No hay productos", style: TextStyle(fontSize: 20)),
            )
          : ListView.builder(
              itemCount: productos.length,
              itemBuilder: (context, index) {
                final producto = productos[index];

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(
                      producto.imagen,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image_not_supported, size: 50);
                      },
                    ),

                    title: Text(
                      producto.nombre,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    subtitle: Text(
                      "\$${producto.precio.toStringAsFixed(0)}\n"
                      "${producto.categoria}",
                    ),

                    trailing: const Icon(Icons.arrow_forward_ios),

                    isThreeLine: true,

                    onTap: () {
                      context.push('/detalle', extra: producto);
                    },
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/agregar');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
