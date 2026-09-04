import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/screens/product.dart';
import 'package:flutter_application_1/providers/productos_provider.dart';

class ProductFormScreen extends ConsumerStatefulWidget {
  final Product? producto;

  const ProductFormScreen({
    super.key,
    this.producto,
  });

  @override
  ConsumerState<ProductFormScreen> createState() =>
      _ProductFormScreenState();
}

class _ProductFormScreenState
    extends ConsumerState<ProductFormScreen> {
  final TextEditingController nombreController =
      TextEditingController();

  final TextEditingController descripcionController =
      TextEditingController();

  final TextEditingController imagenController =
      TextEditingController();

  final TextEditingController precioController =
      TextEditingController();

  final TextEditingController categoriaController =
      TextEditingController();

  bool get editando =>
      widget.producto != null;

  @override
  void initState() {
    super.initState();

    if (widget.producto != null) {
      final producto = widget.producto!;

      nombreController.text =
          producto.nombre;

      descripcionController.text =
          producto.descripcion;

      imagenController.text =
          producto.imagen;

      precioController.text =
          producto.precio.toString();

      categoriaController.text =
          producto.categoria;
    }
  }

  void guardar() {
    final nombre =
        nombreController.text.trim();

    final descripcion =
        descripcionController.text.trim();

    final imagen =
        imagenController.text.trim();

    final precioTexto =
        precioController.text.trim();

    final categoria =
        categoriaController.text.trim();

    if (nombre.isEmpty ||
        descripcion.isEmpty ||
        imagen.isEmpty ||
        precioTexto.isEmpty ||
        categoria.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "completa todo",
          ),
        ),
      );
      return;
    }

    final precio =
        double.tryParse(precioTexto);

    if (precio == null || precio < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Ingresá un precio válido",
          ),
        ),
      );
      return;
    }

    final notifier =
        ref.read(productosProvider.notifier);

    if (editando) {
      final productoModificado =
          widget.producto!.copyWith(
        nombre: nombre,
        descripcion: descripcion,
        imagen: imagen,
        precio: precio,
        categoria: categoria,
      );

      notifier.modificar(
        productoModificado,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Producto modificado",
          ),
        ),
      );
    } else {
      final nuevoProducto = Product(
        id: notifier.siguienteId(),
        nombre: nombre,
        descripcion: descripcion,
        imagen: imagen,
        precio: precio,
        categoria: categoria,
      );

      notifier.agregar(
        nuevoProducto,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Producto agregado",
          ),
        ),
      );
    }

    Navigator.pop(context);
  }

  @override
  void dispose() {
    nombreController.dispose();
    descripcionController.dispose();
    imagenController.dispose();
    precioController.dispose();
    categoriaController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          editando
              ? "Modificar producto"
              : "Agregar producto",
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
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
              controller:
                  descripcionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Descripción",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: imagenController,
              decoration: const InputDecoration(
                labelText: "URL de imagen",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: precioController,
              keyboardType:
                  const TextInputType
                      .numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: "Precio",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
                  categoriaController,
              decoration: const InputDecoration(
                labelText: "Categoría",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: guardar,
                icon: const Icon(
                  Icons.save,
                ),
                label: Text(
                  editando
                      ? "Guardar cambios"
                      : "Agregar producto",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
