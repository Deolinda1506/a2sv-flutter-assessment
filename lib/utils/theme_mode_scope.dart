import 'package:flutter/material.dart';

/// Provides app-wide theme mode (Light / Dark / System) so any screen can read and change it.
class ThemeModeScope extends InheritedWidget {
  const ThemeModeScope({
    required this.themeModeNotifier,
    required super.child,
    super.key,
  });

  final ValueNotifier<ThemeMode> themeModeNotifier;

  static ValueNotifier<ThemeMode> of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ThemeModeScope>();
    assert(scope != null, 'ThemeModeScope not found. Wrap your app with ThemeModeScope.');
    return scope!.themeModeNotifier;
  }

  @override
  bool updateShouldNotify(ThemeModeScope oldWidget) =>
      oldWidget.themeModeNotifier != themeModeNotifier;
}
