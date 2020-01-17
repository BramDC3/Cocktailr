// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cocktail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CocktailAdapter extends TypeAdapter<Cocktail> {
  @override
  final typeId = 0;

  @override
  Cocktail read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cocktail(
      id: fields[0] as dynamic,
      name: fields[1] as dynamic,
      category: fields[2] as dynamic,
      instructions: fields[3] as dynamic,
      image: fields[4] as dynamic,
      isAlcoholic: fields[5] as bool,
      ingredients: (fields[6] as List)?.cast<dynamic>(),
      measurements: (fields[7] as List)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, Cocktail obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.instructions)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.isAlcoholic)
      ..writeByte(6)
      ..write(obj.ingredients)
      ..writeByte(7)
      ..write(obj.measurements);
  }
}
