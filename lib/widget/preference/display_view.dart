import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/riverpod/display_provider.dart';
import 'package:gameshop_deals/widget/dialog_preference_provider.dart';
import 'package:gameshop_deals/model/view_enum.dart' as viewEnum;

class DisplayPreference extends ConsumerWidget {
  const DisplayPreference({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final view = ref.watch(displayProvider);
    return ListTile(
      dense: true,
      onTap: () async {
        final viewEnum.View? mode = await showDialog<viewEnum.View>(
          context: context,
          builder: (_) => PreferenceDialog<viewEnum.View>(
            title: translate.view,
            provider: displayProvider,
            values: viewEnum.View.values,
          ),
        );
        if (mode == null) return;
        ref.read(displayProvider.notifier).changeState(mode);
      },
      title: Text(translate.view),
      subtitle: Text(translate.choose_view(view)),
    );
  }
}
