import 'package:hive/hive.dart';
import '../models/user.dart';

class UserAdapter extends TypeAdapter<User> {
  @override
  int get typeId => 1;

  // @override
  // int get hashCode => typeId.hashCode;

  @override
  User read(BinaryReader reader) => User()
    ..uuid = reader.readString()
    ..username = reader.readString()
    ..firstname = reader.readString()
    ..lastname = reader.readString()
    ..pin = reader.readString();

  // @override
  // User read(BinaryReader reader) {
  //   final numOfFields = reader.readByte();
  //   final fields = <int, dynamic>{
  //     for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
  //   };

  //   return User()
  //     ..uuid = fields[0] as String
  //     ..token = fields[1] as String
  //     ..phone = fields[2] as String
  //     ..email = fields[3] as String
  //     ..username = fields[4] as String
  //     ..firstname = fields[5] as String
  //     ..lastname = fields[6] as String
  //     ..countryID = fields[7] as String
  //     ..currencyID = fields[8] as String
  //     ..createdAt = fields[9] as String;
  // }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.firstname)
      ..writeByte(3)
      ..write(obj.lastname)
      ..writeByte(4)
      ..write(obj.pin);
  }

  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) || other is UserAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
