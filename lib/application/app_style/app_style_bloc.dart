import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../utils/styles/app_colors.dart';

part 'app_style_event.dart';
part 'app_style_state.dart';

class AppStyleBloc extends Bloc<AppStyleEvent, AppStyleState> {
  AppStyleBloc()
      : super(const AppStyleState(appColor: AppColors.primaryColor)) {
    on<ApplyAppColorEvent>(_onApplyAppColor);
  }

  void _onApplyAppColor(ApplyAppColorEvent event, Emitter<AppStyleState> emit) {
    emit(state.copyWith(appColor: event.appColor));
  }
}
