part of 'app_style_bloc.dart';

class AppStyleState extends Equatable {
  final MaterialColor appColor;

  const AppStyleState({
    required this.appColor,
  });

  AppStyleState copyWith({
    MaterialColor? appColor,
  }) {
    return AppStyleState(
      appColor: appColor ?? this.appColor,
    );
  }

  @override
  List<Object> get props => [appColor];
}
