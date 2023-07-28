import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/model/view_format_enum.dart';
import 'package:gameshop_deals/presentation/widgets/preferences/dialog_preference_provider.dart';
import 'package:gameshop_deals/provider/display_provider.dart';

class DisplayPreference extends ConsumerWidget {
  const DisplayPreference({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final view = ref.watch(displayProvider);
    return ListTile(
      onTap: () async {
        final ViewFormat? mode = await showDialog<ViewFormat>(
          context: context,
          builder: (_) => PreferenceDialog<ViewFormat>(
            title: translate.view,
            provider: displayProvider,
            values: ViewFormat.values,
          ),
        );
        if (mode != null) ref.read(displayProvider.notifier).changeState(mode);
      },
      leading: const Icon(Icons.view_array_outlined),
      title: Text(translate.view),
      subtitle: Text(translate.choose_view(view)),
    );
  }
}