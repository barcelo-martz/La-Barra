class TragoCategoria {
  final String nombre;
  final String descripcion;
  final String categoria;
  final List<String> ingredientes;
  final String preparacion;
  final List<String> herramientas;
  final String imagen;

  TragoCategoria({
    required this.nombre,
    required this.descripcion,
    required this.categoria,
    required this.ingredientes,
    required this.preparacion,
    required this.herramientas,
    required this.imagen,
  });
}