import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  late String uuid;

  @HiveField(1)
  late String username;

  @HiveField(2)
  late String firstname;

  @HiveField(3)
  late String lastname;

  @HiveField(4)
  late String pin;
}
