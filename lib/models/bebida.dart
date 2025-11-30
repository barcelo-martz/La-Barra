import 'package:hive/hive.dart';

part 'bebida.g.dart'; // archivo generado automáticamente

@HiveType(typeId: 0)
class Bebida {
  @HiveField(0)
  final String nombre;

  @HiveField(1)
  final String categoria;

  @HiveField(2)
  final String descripcion;

  @HiveField(3)
  final List<String> ingredientes;

  @HiveField(4)
  final String pasos;

  @HiveField(5)
  final List<String> herramientas;

  Bebida({
    required this.nombre,
    required this.categoria,
    required this.descripcion,
    required this.ingredientes,
    required this.pasos,
    required this.herramientas,
  });
}