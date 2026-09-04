import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/screens/product.dart';

class ProductosNotifier extends Notifier<List<Product>> {
  @override
  List<Product> build() {
    return [
      Product(
        id: 1,
        nombre: "Notebook",
        descripcion: "Notebook con 16 GB de RAM",
        imagen:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSU3ey-sbJf8P-osxXAwZncmfbHXTXwoxEQvB_o6kstcQ&s=10",
        precio:670000,
        categoria: "Informática",
      ),
      Product(
        id: 2,
        nombre: "Celular",
        descripcion: "Celular Samsung.",
        imagen:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCPlrnrONonwhuFiNOc2ZzuKwaoViP03d_gC8mvwBbF8ukflmP7ZZcT_KO&s=10",
        precio: 670000,
        categoria: "Telefonía",
      ),
      Product(
        id: 3,
        nombre: "Auriculares",
        descripcion: "Auriculares con cancelación de ruido.",
        imagen:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTF0RfNUQhhexFp5N3nTTguT8ycyujLwdwSmEMpoi_N0g&s=10",
        precio: 6777777,
        categoria: "Audio",
      ),
      Product(
        id: 4,
        nombre: "Computadora Gamer",
        descripcion: "PC Gamer de alto rendimiento.",
        imagen:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRncLYnIkNbLIqeI2oyFHibcpnPvQ4s53yLpQ64KoMHzg&s=10",
        precio: 67676767,
        categoria: "gaming",
      ),
    ];
  }

  void agregar(Product producto) {
    state = [
      ...state,
      producto,
    ];
  }

  void modificar(Product producto) {
    state = state.map((p) {
      if (p.id == producto.id) {
        return producto;
      }

      return p;
    }).toList();
  }

  void eliminar(int id) {
    state = state
        .where((p) => p.id != id)
        .toList();
  }

  int siguienteId() {
    if (state.isEmpty) {
      return 1;
    }

    return state
            .map((p) => p.id)
            .reduce((a, b) => a > b ? a : b) +
        1;
  }
}

final productosProvider =
    NotifierProvider<ProductosNotifier, List<Product>>(
  ProductosNotifier.new,
);
