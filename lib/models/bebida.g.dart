// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bebida.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BebidaAdapter extends TypeAdapter<Bebida> {
  @override
  final int typeId = 0;

  @override
  Bebida read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bebida(
      nombre: fields[0] as String,
      categoria: fields[1] as String,
      descripcion: fields[2] as String,
      ingredientes: (fields[3] as List).cast<String>(),
      pasos: fields[4] as String,
      herramientas: (fields[5] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Bebida obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.nombre)
      ..writeByte(1)
      ..write(obj.categoria)
      ..writeByte(2)
      ..write(obj.descripcion)
      ..writeByte(3)
      ..write(obj.ingredientes)
      ..writeByte(4)
      ..write(obj.pasos)
      ..writeByte(5)
      ..write(obj.herramientas);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BebidaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
