import 'package:hive_flutter/hive_flutter.dart';

part 'user_hive.g.dart';

//* If ever you want to implement freezed + hive refer below link.
//* Ref: https://stackoverflow.com/questions/60383178/combine-freezed-hive
@HiveType(typeId: 0)
class UserHive extends HiveObject {
  @HiveField(0)
  late bool isLoggedIn = false;
  @HiveField(1)
  late bool isOnboarded = false;
}
