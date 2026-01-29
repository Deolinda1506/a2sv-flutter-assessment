import 'package:flutter/material.dart';
import '../utils/theme_mode_scope.dart';

/// App bar button that cycles theme mode: System → Light → Dark → System.
class ThemeModeButton extends StatelessWidget {
  const ThemeModeButton({super.key});

  static const _cycle = [ThemeMode.system, ThemeMode.light, ThemeMode.dark];

  @override
  Widget build(BuildContext context) {
    final notifier = ThemeModeScope.of(context);
    final current = notifier.value;

    IconData icon;
    String tooltip;
    switch (current) {
      case ThemeMode.light:
        icon = Icons.light_mode;
        tooltip = 'Light mode (tap for Dark)';
        break;
      case ThemeMode.dark:
        icon = Icons.dark_mode;
        tooltip = 'Dark mode (tap for System)';
        break;
      case ThemeMode.system:
        icon = Icons.brightness_auto;
        tooltip = 'System theme (tap for Light)';
    }

    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      onPressed: () {
        final idx = _cycle.indexOf(current);
        notifier.value = _cycle[(idx + 1) % _cycle.length];
      },
      color: Theme.of(context).colorScheme.onSurfaceVariant,
    );
  }
}
