class Product {
  final int id;
  final String nombre;
  final String descripcion;
  final String imagen;
  final double precio;
  final String categoria;

  Product({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.imagen,
    required this.precio,
    required this.categoria,
  });

  Product copyWith({
    int? id,
    String? nombre,
    String? descripcion,
    String? imagen,
    double? precio,
    String? categoria,
  }) {
    return Product(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      imagen: imagen ?? this.imagen,
      precio: precio ?? this.precio,
      categoria: categoria ?? this.categoria,
    );
  }
}
