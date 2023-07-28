import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/provider/preference_provider.dart';

class WebViewPreference extends ConsumerWidget {
  const WebViewPreference({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final bool webView = ref.watch(
      preferenceProvider.select((p) => p.webView),
    );
    return SwitchListTile(
      value: webView,
      onChanged: (mode) async {
        final preference = ref.read(preferenceProvider);
        final newPreference = preference.copyWith(
          webView: mode,
        );
        await ref.read(preferenceProvider.notifier).changeState(newPreference);
      },
      secondary: const Icon(Icons.open_in_browser_rounded),
      title: Text(translate.internal_browser_checkbox),
    );
  }
}
