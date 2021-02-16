import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/model/view_enum.dart';
import 'package:gameshop_deals/riverpod/display_provider.dart';
import 'package:gameshop_deals/widget/dialog_preference_provider.dart';

class DisplayPreference extends ConsumerWidget {
  const DisplayPreference({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final S translate = S.of(context);
    final view = watch(displayProvider.state);
    return ListTile(
      dense: true,
      onTap: () async {
        final View mode = await showDialog<View>(
          context: context,
          builder: (_) => PreferenceDialog<View>(
            title: translate.deal_view,
            provider: displayProvider,
            values: View.values,
          ),
        );
        if (mode != null) context.read(displayProvider).changeState(mode);
      },
      title: Text(translate.deal_view),
      subtitle: Text(translate.choose_deal_view(view)),
    );
  }
}