// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductDetailsAdapter extends TypeAdapter<ProductDetails> {
  @override
  final int typeId = 0;

  @override
  ProductDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductDetails()
      ..poNo = fields[0] as int?
      ..poDate = fields[1] as DateTime?
      ..poDescription = fields[2] as String?
      ..items = (fields[3] as List?)
          ?.map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList();
  }

  @override
  void write(BinaryWriter writer, ProductDetails obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.poNo)
      ..writeByte(1)
      ..write(obj.poDate)
      ..writeByte(2)
      ..write(obj.poDescription)
      ..writeByte(3)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
