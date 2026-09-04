import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_1/screens/product.dart';
import 'package:flutter_application_1/providers/productos_provider.dart';

class ResultsScreen extends ConsumerWidget {
  final Product producto;

  const ResultsScreen({
    super.key,
    required this.producto,
  });

  void eliminarProducto(
    BuildContext context,
    WidgetRef ref,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            "Eliminar producto",
          ),
          content: Text(
            "¿Querés eliminar ${producto.nombre}?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(
                      productosProvider.notifier,
                    )
                    .eliminar(producto.id);

                Navigator.pop(dialogContext);

                context.pop();
              },
              child: const Text("Eliminar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(producto.nombre),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              producto.imagen,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) {
                return const SizedBox(
                  height: 250,
                  child: Center(
                    child: Icon(
                      Icons
                          .image_not_supported,
                      size: 80,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children: [
                  Text(
                    producto.nombre,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                    ),
                    textAlign:
                        TextAlign.center,
                  ),

                  const SizedBox(height: 20),

                  Text(
                    "ID: ${producto.id}",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Categoría: ${producto.categoria}",
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "precio: \$${producto.precio.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    producto.descripcion,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    textAlign:
                        TextAlign.center,
                  ),

                  const SizedBox(height: 30),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.push(
                              '/editar',
                              extra: producto,
                            );
                          },
                          icon: const Icon(
                            Icons.edit,
                          ),
                          label: const Text(
                            "editar",
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child:
                            ElevatedButton.icon(
                          onPressed: () {
                            eliminarProducto(
                              context,
                              ref,
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                          ),
                          label: const Text(
                            "borrar",
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
