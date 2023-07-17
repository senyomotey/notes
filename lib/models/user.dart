import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  late String uuid;

  @HiveField(1)
  late String email;

  @HiveField(2)
  late String token;

  @HiveField(3)
  late String appOpened;

  @HiveField(4)
  late String loggedIn;
}
