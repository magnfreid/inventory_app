import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:inventory_app/theme/models/app_seed_color.dart';

enum AppThemeMode { system, light, dark }

class ThemeState {
  const ThemeState({
    this.mode = AppThemeMode.system,
    this.seedColor = AppSeedColor.blueGrey,
  });

  final AppThemeMode mode;
  final AppSeedColor seedColor;

  ThemeState copyWith({AppThemeMode? mode, AppSeedColor? seedColor}) {
    return ThemeState(
      mode: mode ?? this.mode,
      seedColor: seedColor ?? this.seedColor,
    );
  }
}

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(const ThemeState());

  void setMode(AppThemeMode mode) => emit(state.copyWith(mode: mode));
  void setSeedColor(AppSeedColor seedColor) =>
      emit(state.copyWith(seedColor: seedColor));

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    final modeIndex = json['mode'] as int? ?? 0;
    final seedColorIndex = json['seedColor'] as int? ?? 0;
    return ThemeState(
      mode: AppThemeMode.values[modeIndex],
      seedColor: AppSeedColor.values[seedColorIndex],
    );
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) => {
        'mode': state.mode.index,
        'seedColor': state.seedColor.index,
      };
}
