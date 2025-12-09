// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trago_categoria.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TragoCategoriaAdapter extends TypeAdapter<TragoCategoria> {
  @override
  final int typeId = 1;

  @override
  TragoCategoria read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TragoCategoria(
      nombre: fields[0] as String,
      descripcion: fields[1] as String,
      categoria: fields[2] as String,
      ingredientes: (fields[3] as List).cast<String>(),
      preparacion: fields[4] as String,
      herramientas: (fields[5] as List).cast<String>(),
      imagen: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TragoCategoria obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.nombre)
      ..writeByte(1)
      ..write(obj.descripcion)
      ..writeByte(2)
      ..write(obj.categoria)
      ..writeByte(3)
      ..write(obj.ingredientes)
      ..writeByte(4)
      ..write(obj.preparacion)
      ..writeByte(5)
      ..write(obj.herramientas)
      ..writeByte(6)
      ..write(obj.imagen);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TragoCategoriaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
