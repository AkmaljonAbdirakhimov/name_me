import '../models/app_usage.dart';

abstract class AppUsageRepository {
  AppUsage? getAppUsage();
  Future<void> incrementAppUsage();
  Future<void> resetAppUsage();
}
