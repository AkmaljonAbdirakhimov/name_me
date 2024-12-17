part of 'app_usage_bloc.dart';

enum AppUsageStatus {
  initial,
  loading,
  success,
  error,
}

class AppUsageState extends Equatable {
  final AppUsage? appUsage;
  final AppUsageStatus status;
  final String? errorMessage;

  const AppUsageState({
    this.appUsage,
    this.status = AppUsageStatus.initial,
    this.errorMessage,
  });

  AppUsageState copyWith({
    AppUsage? appUsage,
    AppUsageStatus? status,
    String? errorMessage,
  }) {
    return AppUsageState(
      appUsage: appUsage ?? this.appUsage,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [appUsage, status, errorMessage];
}
