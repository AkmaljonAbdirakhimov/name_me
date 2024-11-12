import 'package:hive_flutter/hive_flutter.dart';

part 'gender.g.dart';

@HiveType(typeId: 0)
enum Genders {
  @HiveField(0)
  boy,
  @HiveField(1)
  girl,
  @HiveField(2)
  both
}
