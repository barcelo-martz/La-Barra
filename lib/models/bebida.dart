import 'package:hive/hive.dart';

part 'bebida.g.dart'; 

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

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'categoria': categoria,
      'descripcion': descripcion,
      'ingredientes': ingredientes,
      'pasos': pasos,
      'herramientas': herramientas,
    };
  }

  static Bebida fromMap(Map<dynamic, dynamic> map) {
    return Bebida(
      nombre: map['nombre'] ?? '',
      categoria: map['categoria'] ?? '',
      descripcion: map['descripcion'] ?? '',
      ingredientes: List<String>.from(map['ingredientes'] ?? []),
      pasos: map['pasos'] ?? '',
      herramientas: List<String>.from(map['herramientas'] ?? []),
    );
  }
}