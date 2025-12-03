import 'package:hive/hive.dart';

part 'trago_categoria.g.dart'; 

@HiveType(typeId: 0) 
class TragoCategoria {
  @HiveField(0)
  final String nombre;

  @HiveField(1)
  final String descripcion;

  @HiveField(2)
  final String categoria;

  @HiveField(3)
  final List<String> ingredientes;

  @HiveField(4)
  final String preparacion;

  @HiveField(5)
  final List<String> herramientas;

  @HiveField(6)
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
