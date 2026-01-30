import 'package:flutter/material.dart';
import '../utils/theme_mode_scope.dart';

/// App bar button that opens a menu to choose theme: System, Light, or Dark.
class ThemeModeButton extends StatelessWidget {
  const ThemeModeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = ThemeModeScope.of(context);
    final current = notifier.value;

    IconData icon;
    switch (current) {
      case ThemeMode.light:
        icon = Icons.light_mode;
        break;
      case ThemeMode.dark:
        icon = Icons.dark_mode;
        break;
      case ThemeMode.system:
        icon = Icons.brightness_auto;
    }

    return PopupMenuButton<ThemeMode>(
      tooltip: 'Theme',
      icon: Icon(icon, color: Theme.of(context).colorScheme.onSurfaceVariant),
      onSelected: (mode) => notifier.value = mode,
      itemBuilder: (context) => [
        PopupMenuItem<ThemeMode>(
          value: ThemeMode.system,
          child: Row(
            children: [
              if (current == ThemeMode.system)
                Icon(Icons.check, size: 20, color: Theme.of(context).colorScheme.primary),
              if (current == ThemeMode.system) const SizedBox(width: 8),
              const Icon(Icons.brightness_auto, size: 20),
              const SizedBox(width: 12),
              const Text('System'),
            ],
          ),
        ),
        PopupMenuItem<ThemeMode>(
          value: ThemeMode.light,
          child: Row(
            children: [
              if (current == ThemeMode.light)
                Icon(Icons.check, size: 20, color: Theme.of(context).colorScheme.primary),
              if (current == ThemeMode.light) const SizedBox(width: 8),
              const Icon(Icons.light_mode, size: 20),
              const SizedBox(width: 12),
              const Text('Light'),
            ],
          ),
        ),
        PopupMenuItem<ThemeMode>(
          value: ThemeMode.dark,
          child: Row(
            children: [
              if (current == ThemeMode.dark)
                Icon(Icons.check, size: 20, color: Theme.of(context).colorScheme.primary),
              if (current == ThemeMode.dark) const SizedBox(width: 8),
              const Icon(Icons.dark_mode, size: 20),
              const SizedBox(width: 12),
              const Text('Dark'),
            ],
          ),
        ),
      ],
    );
  }
}
