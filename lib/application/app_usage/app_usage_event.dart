part of 'app_usage_bloc.dart';

sealed class AppUsageEvent {}

class GetAppUsageEvent extends AppUsageEvent {}

class IncrementAppUsageEvent extends AppUsageEvent {}

class ResetAppUsageEvent extends AppUsageEvent {}
