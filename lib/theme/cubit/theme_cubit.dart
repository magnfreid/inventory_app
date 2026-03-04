import 'package:bloc/bloc.dart';

enum AppThemeMode { system, light, dark }

class ThemeCubit extends Cubit<AppThemeMode> {
  ThemeCubit() : super(.system);
  void themeButtonPressed(AppThemeMode mode) => emit(mode);
}
