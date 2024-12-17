import 'package:hive_flutter/hive_flutter.dart';

part 'app_usage.g.dart';

@HiveType(typeId: 2)
class AppUsage extends HiveObject {
  @HiveField(0)
  final int count;
  @HiveField(1)
  final DateTime date;

  AppUsage({
    required this.count,
    required this.date,
  });
}
