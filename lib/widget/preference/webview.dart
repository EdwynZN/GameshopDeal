import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/riverpod/preference_provider.dart';

final _webViewProvider = Provider.autoDispose<bool>(
    (ref) => ref.watch(preferenceProvider.select((p) => p.webView)),
    name: 'WebView Provider');

class WebViewPreference extends ConsumerWidget {
  const WebViewPreference({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final bool webView = ref.watch(_webViewProvider);
    return CheckboxListTile(
      dense: true,
      value: webView,
      onChanged: (mode) async {
        final preference = ref.read(preferenceProvider);
        final newPreference = preference.copyWith(
          webView: mode ?? false,
        );
        await ref.read(preferenceProvider.notifier).changeState(newPreference);
      },
      title: Text(translate.internal_browser_checkbox),
    );
  }
}
