import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/models/app_usage.dart';
import '../../domain/repositories/app_usage_repository.dart';

part 'app_usage_event.dart';
part 'app_usage_state.dart';

class AppUsageBloc extends Bloc<AppUsageEvent, AppUsageState> {
  final AppUsageRepository _appUsageRepository;

  AppUsageBloc({
    required AppUsageRepository appUsageRepository,
  })  : _appUsageRepository = appUsageRepository,
        super(const AppUsageState()) {
    on<GetAppUsageEvent>(_onGetAppUsage);
    on<IncrementAppUsageEvent>(_onIncrementAppUsage);
    on<ResetAppUsageEvent>(_onResetAppUsage);
  }

  Future<void> _onGetAppUsage(
      GetAppUsageEvent event, Emitter<AppUsageState> emit) async {
    emit(state.copyWith(status: AppUsageStatus.loading));
    try {
      final appUsage = _appUsageRepository.getAppUsage();
      if (appUsage != null &&
          DateTime.now().difference(appUsage.date).inHours >= 24) {
        add(ResetAppUsageEvent());
      } else {
        emit(state.copyWith(
          appUsage: appUsage,
          status: AppUsageStatus.success,
        ));
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: AppUsageStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onIncrementAppUsage(
      IncrementAppUsageEvent event, Emitter<AppUsageState> emit) async {
    _appUsageRepository.incrementAppUsage();
    add(GetAppUsageEvent());
  }

  Future<void> _onResetAppUsage(
      ResetAppUsageEvent event, Emitter<AppUsageState> emit) async {
    _appUsageRepository.resetAppUsage();
    add(GetAppUsageEvent());
  }
}
