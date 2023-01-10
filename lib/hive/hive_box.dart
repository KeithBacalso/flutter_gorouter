import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_router/hive/user/user_hive.dart';

class HiveBox {
  static Box<UserHive> getUser() => Hive.box<UserHive>('user');
}
