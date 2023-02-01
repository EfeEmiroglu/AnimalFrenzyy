// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chicken_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayerTypeAdapter extends TypeAdapter<PlayerTypes> {
  @override
  final int typeId = 1;

  @override
  PlayerTypes read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PlayerTypes.chicken;
      case 1:
        return PlayerTypes.bee;
      case 2:
        return PlayerTypes.blueBird;
      case 3:
        return PlayerTypes.bunny;
      case 4:
        return PlayerTypes.chameleon;
      case 5:
        return PlayerTypes.duck;
      case 6:
        return PlayerTypes.fatBird;
      case 7:
        return PlayerTypes.ghost;
      default:
        return PlayerTypes.chicken;
    }
  }

  @override
  void write(BinaryWriter writer, PlayerTypes obj) {
    switch (obj) {
      case PlayerTypes.chicken:
        writer.writeByte(0);
        break;
      case PlayerTypes.bee:
        writer.writeByte(1);
        break;
      case PlayerTypes.blueBird:
        writer.writeByte(2);
        break;
      case PlayerTypes.bunny:
        writer.writeByte(3);
        break;
      case PlayerTypes.chameleon:
        writer.writeByte(4);
        break;
      case PlayerTypes.duck:
        writer.writeByte(5);
        break;
      case PlayerTypes.fatBird:
        writer.writeByte(6);
        break;
      case PlayerTypes.ghost:
        writer.writeByte(7);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
