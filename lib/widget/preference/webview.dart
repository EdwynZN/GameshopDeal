import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/riverpod/preference_provider.dart';

final _webViewProvider = ScopedProvider<bool>(
  (watch) => watch(preferenceProvider.state).webView,
name: 'WebView Provider');

class WebViewPreference extends ConsumerWidget {
  const WebViewPreference({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final S translate = S.of(context);
    final bool webView = watch(_webViewProvider);
    return CheckboxListTile(
      dense: true,
      value: webView,
      onChanged: (mode) async {
        final preference = context.read(preferenceProvider.state);
        final newPreference = preference.copyWith(
          webView: mode,
        );
        await context.read(preferenceProvider).changeState(newPreference);
      },
      title: Text(translate.internal_browser_checkbox),
    );
  }
}
