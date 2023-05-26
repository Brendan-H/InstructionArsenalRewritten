import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeState = ref.watch(themesProvider);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Change Theme $themeModeState",
            style: const TextStyle(fontSize: 18),
          ),
          Consumer(
            builder: (context, ref, child) {
              return Switch(
                  value: themeModeState == ThemeMode.dark, //false or true
                  onChanged: (value) {
                    ref.read(themesProvider.notifier).changeTheme(value);
                  });
            },
          ),
        ],
      ),
    )
  }
}
