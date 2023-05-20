import 'package:flutter/material.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/model/filter.dart';

final _steamScore = Provider.autoDispose<double>((ref) {
  final title = ref.watch(titleProvider);
  return ref
      .watch(filterProviderCopy(title)
      .select((f) => f.steamRating
        .clamp(40, 95)
        .toDouble()),
      );
}, name: 'Steam Score');

class SteamRating extends ConsumerWidget {
  const SteamRating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final title = ref.watch(titleProvider);
    final double score = ref.watch(_steamScore);
    return Slider.adaptive(
      value: score,
      onChanged: (newValue) {
        final StateController<Filter> filter =
            ref.read(filterProviderCopy(title).notifier);
        filter.state = filter.state
            .copyWith(steamRating: newValue <= 40 ? 0 : newValue.toInt());
      },
      min: 40,
      max: 95,
      divisions: 11,
      label: '${score <= 40 ? translate.any_rating : score.toInt()}',
    );
  }
}
