import 'package:hydrated_bloc/hydrated_bloc.dart';

enum AppThemeMode { system, light, dark }

class ThemeCubit extends HydratedCubit<AppThemeMode> {
  ThemeCubit() : super(.system);
  void themeButtonPressed(AppThemeMode mode) => emit(mode);

  @override
  AppThemeMode? fromJson(Map<String, dynamic> json) =>
      AppThemeMode.values[json['mode'] as int];

  @override
  Map<String, dynamic>? toJson(AppThemeMode state) => {
    'mode': state.index,
  };
}
