import 'package:hive/hive.dart';

import '../models/app_usage.dart';

class AppUsageService {
  static const String _boxName = 'app_usage';
  late Box<AppUsage> _box;

  Future<void> init() async {
    Hive.registerAdapter(AppUsageAdapter());
    _box = await Hive.openBox<AppUsage>(_boxName);
  }

  Future<void> incrementAppUsage() async {
    final appUsage = _box.get(_boxName);
    if (appUsage == null) {
      await _box.put(_boxName, AppUsage(count: 1, date: DateTime.now()));
    } else {
      await _box.put(
          _boxName, AppUsage(count: appUsage.count + 1, date: DateTime.now()));
    }
  }

  Future<void> resetAppUsage() async {
    await _box.clear();
  }

  AppUsage? getAppUsage() {
    return _box.get(_boxName);
  }
}
