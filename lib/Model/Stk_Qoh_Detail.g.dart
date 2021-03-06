// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Stk_Qoh_Detail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StkQohDetailAdapter extends TypeAdapter<Stk_Qoh_Detail> {
  @override
  final int typeId = 13;

  @override
  Stk_Qoh_Detail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Stk_Qoh_Detail(
      ID: fields[0] as int,
      ID_stk_qoh: fields[1] as int,
      rfid_code: fields[2] as String,
      qoh_qty: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Stk_Qoh_Detail obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.ID)
      ..writeByte(1)
      ..write(obj.ID_stk_qoh)
      ..writeByte(2)
      ..write(obj.rfid_code)
      ..writeByte(3)
      ..write(obj.qoh_qty);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StkQohDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stk_Qoh_Detail _$Stk_Qoh_DetailFromJson(Map<String, dynamic> json) {
  return Stk_Qoh_Detail(
    ID: json['ID'] as int,
    ID_stk_qoh: json['ID_stk_qoh'] as int,
    rfid_code: json['rfid_code'] as String,
    qoh_qty: json['qoh_qty'] as int,
  );
}

Map<String, dynamic> _$Stk_Qoh_DetailToJson(Stk_Qoh_Detail instance) =>
    <String, dynamic>{
      'ID': instance.ID,
      'ID_stk_qoh': instance.ID_stk_qoh,
      'rfid_code': instance.rfid_code,
      'qoh_qty': instance.qoh_qty,
    };
