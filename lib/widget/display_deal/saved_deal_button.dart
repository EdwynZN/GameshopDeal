import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/model/price_alert.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart';
import 'package:gameshop_deals/riverpod/saved_deals_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SavedDealButton extends ConsumerWidget {
  const SavedDealButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final S translate = S.of(context);
    final deal = watch(singleDeal);
    assert(deal != null && deal.gameId != null, 'A deal ought to have a gameId');
    final savedDeal = watch(savedStreamProvider(deal.gameId));
    return savedDeal.maybeWhen(
      orElse: () =>
        OutlinedButton(onPressed: null, 
        child: Text(
            RefreshLocalizations.of(context).currentLocalization.loadingText,
          ),
        ),
      data: (isSaved) {
        if (!isSaved) {
          return OutlinedButton.icon(
            icon: const Icon(Icons.visibility_outlined),
            label: Flexible(
              child: Text(
                translate.save_deal,
                overflow: TextOverflow.fade,
                softWrap: false,
              ),
            ),
            onPressed: () async {
              final box = await context.read(savedBoxProvider.future);
              await box.put(
                deal.gameId,
                PriceAlert(),
              );
            },
          );
        }
        return OutlinedButton.icon(
          icon: const Icon(Icons.visibility_off_outlined),
          label: Flexible(
            child: Text(
              translate.remove_deal,
              overflow: TextOverflow.fade,
              softWrap: false,
            ),
          ),
          onPressed: () async {
            final box = await context.read(savedBoxProvider.future);
            await box.delete(deal.gameId);
          },
        );
      },
    );
  }
}

class SavedTextDealButton extends ConsumerWidget {
  const SavedTextDealButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final S translate = S.of(context);
    final deal = watch(singleDeal);
    assert(
        deal != null && deal.gameId != null, 'A deal ought to have a gameId');
    final savedDeal = watch(savedStreamProvider(deal.gameId));
    return savedDeal.maybeWhen(
      orElse: () => TextButton.icon(
        onPressed: null,
        icon: const SizedBox(),
        label: Text(
          RefreshLocalizations.of(context).currentLocalization.loadingText,
        ),
      ),
      data: (isSaved) {
        if (!isSaved) {
          return TextButton.icon(
            icon: const Icon(Icons.visibility_outlined),
            label: Flexible(
              child: Text(
                translate.save_deal,
                overflow: TextOverflow.fade,
                softWrap: false,
              ),
            ),
            onPressed: () async {
              final box = await context.read(savedBoxProvider.future);
              await box.put(
                deal.gameId,
                PriceAlert(),
              );
            },
          );
        }
        return TextButton.icon(
          icon: const Icon(Icons.visibility_off_outlined),
          label: Flexible(
            child: Text(
              translate.remove_deal,
              overflow: TextOverflow.fade,
              softWrap: false,
            ),
          ),
          onPressed: () async {
            final box = await context.read(savedBoxProvider.future);
            print(await box.get(deal.gameId));
            await box.delete(deal.gameId);
          },
        );
      },
    );
  }
}
