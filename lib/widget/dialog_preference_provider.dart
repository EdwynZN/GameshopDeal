import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/hive_preferences_provider.dart';
import 'package:gameshop_deals/generated/l10n.dart';

class PreferenceDialog<T extends Object> extends ConsumerStatefulWidget {
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

class _PreferenceDialogState<T extends Object> extends ConsumerState<PreferenceDialog<T>> {
  late T? value;
  late S translate;

  @override
  void didChangeDependencies() {
    value = ref.read(widget.provider);
    translate = S.of(context);
    super.didChangeDependencies();
  }

  String _translatedTitle(T title) {
    if (title is ThemeMode)
      return translate.themeMode(title);
    else
      return translate.choose_view(title);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      titlePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      actionsPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (T obj in widget.values)
                RadioListTile(
                  value: obj,
                  groupValue: value,
                  title: Text(_translatedTitle(obj)),
                  onChanged: (newValue) => setState(() => value = newValue),
                ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop<T>(value),
          child: Text(MaterialLocalizations.of(context).okButtonLabel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop<T>(),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
      ],
    );
  }
}
