import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hive/hive.dart';
import '../models/trago_categoria.dart';



Future<void> cargarTragosDesdeJson() async {
  final box = Hive.box<TragoCategoria>('tragos');

  if (box.isEmpty) {
    final String data = await rootBundle.loadString('assets/data/tragos.json');
    final List<dynamic> jsonList = json.decode(data);

    final tragos = jsonList.map((json) => TragoCategoria(
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      categoria: json['categoria'],
      ingredientes: List<String>.from(json['ingredientes']),
      preparacion: json['preparacion'],
      herramientas: List<String>.from(json['herramientas']),
      imagen: json['imagen'],
    )).toList();

    await box.addAll(tragos);
  }
}
