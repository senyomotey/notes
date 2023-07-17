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
    ..email = reader.readString()
    ..token = reader.readString()
    ..appOpened = reader.readString()
    ..loggedIn = reader.readString();

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.token)
      ..writeByte(3)
      ..write(obj.appOpened)
      ..writeByte(4)
      ..write(obj.loggedIn);
  }

  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) || other is UserAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
