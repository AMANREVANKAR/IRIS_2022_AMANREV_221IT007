// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offlineusermodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class offlineusermodelAdapter extends TypeAdapter<offlineusermodel> {
  @override
  final int typeId = 0;

  @override
  offlineusermodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return offlineusermodel(
      name: fields[0] as String?,
      emailid: fields[1] as String?,
      Rollno: fields[2] as String?,
      currmess: fields[3] as String?,
      currbal: fields[4] as String?,
      messbalanceperday: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, offlineusermodel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.emailid)
      ..writeByte(2)
      ..write(obj.Rollno)
      ..writeByte(3)
      ..write(obj.currmess)
      ..writeByte(4)
      ..write(obj.currbal)
      ..writeByte(5)
      ..write(obj.messbalanceperday);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is offlineusermodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
