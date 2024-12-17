import '../models/app_usage.dart';
import '../services/app_usage_service.dart';
import 'app_usage_repository.dart';

class AppUsageRepositoryImpl implements AppUsageRepository {
  final AppUsageService _appUsageService;

  AppUsageRepositoryImpl({
    required AppUsageService appUsageService,
  }) : _appUsageService = appUsageService;

  @override
  AppUsage? getAppUsage() {
    return _appUsageService.getAppUsage();
  }

  @override
  Future<void> incrementAppUsage() async {
    await _appUsageService.incrementAppUsage();
  }

  @override
  Future<void> resetAppUsage() async {
    await _appUsageService.resetAppUsage();
  }
}
