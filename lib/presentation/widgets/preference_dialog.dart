import 'package:flutter/material.dart';
import 'package:gameshop_deals/provider/hive_preferences_provider.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PreferenceDialog<T extends Object> extends StatefulHookConsumerWidget {
  const PreferenceDialog({
    Key? key,
    required this.title,
    required this.provider,
    required this.values,
    Widget? child,
  }) : super(key: key);

  final String title;

  final List<T> values;

  final StateNotifierProvider<HiveNotifier<T>, T> provider;

  @override
  _PreferenceDialogState<T> createState() => _PreferenceDialogState<T>();
}

class _PreferenceDialogState<T extends Object>
    extends ConsumerState<PreferenceDialog<T>> {
  late S translate;

  @override
  void didChangeDependencies() {
    translate = S.of(context);
    super.didChangeDependencies();
  }

  String _translatedTitle(T title) => title is ThemeMode
    ? translate.themeMode(title)
    : translate.choose_view(title);

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(widget.provider);
    final localizations = MaterialLocalizations.of(context);
    final ValueNotifier<T> valueState = useState(value);
    return AlertDialog(
      title: Text(widget.title),
      titlePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      content: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (T obj in widget.values)
                RadioListTile(
                  value: obj,
                  groupValue: valueState.value,
                  title: Text(_translatedTitle(obj)),
                  onChanged: (newValue) {
                    if (newValue != null) valueState.value = newValue;
                  },
                ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop<T>(),
          child: Text(localizations.cancelButtonLabel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop<T>(valueState.value),
          child: Text(localizations.okButtonLabel),
        ),
      ],
    );
  }
}
