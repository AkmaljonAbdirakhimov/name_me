part of 'app_style_bloc.dart';

sealed class AppStyleEvent {}

class ApplyAppColorEvent extends AppStyleEvent {
  final MaterialColor appColor;

  ApplyAppColorEvent({required this.appColor});
}
