import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/model/game_lookup.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart';
import 'package:gameshop_deals/riverpod/saved_deals_provider.dart';

class SavedDealButton extends ConsumerWidget {
  const SavedDealButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final S translate = S.of(context);
    final deal = watch(singleDeal);
    assert(
        deal != null && deal.gameId != null, 'A deal ought to have a gameId');
    final savedDeal = watch(savedStreamProvider(deal.gameId));
    return savedDeal.maybeWhen(
      orElse: () =>
          OutlinedButton(onPressed: null, child: Text(translate.save_deal)),
      data: (isSaved) {
        if (!isSaved) {
          return OutlinedButton.icon(
            icon: const Icon(Icons.remove_red_eye),
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
                GameLookup(
                    info: Info(
                      steamAppId: deal.steamAppId,
                      thumb: deal.thumb,
                      title: deal.title,
                    ),
                    deals: [deal]),
              );
            },
          );
        }
        return OutlinedButton.icon(
          icon: const Icon(Icons.compass_calibration_rounded),
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
    assert(deal != null && deal.gameId != null, 'A deal ought to have a gameId');
    final savedDeal = watch(savedStreamProvider(deal.gameId));
    return savedDeal.maybeWhen(
      orElse: () =>
        TextButton.icon(
          onPressed: null,
          label: Text(translate.save_deal),
          icon: const SizedBox.shrink(),
        ),
      data: (isSaved) {
        if (!isSaved) {
          return TextButton.icon(
            icon: const Icon(Icons.remove_red_eye_outlined),
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
                GameLookup(
                  info: Info(
                    steamAppId: deal.steamAppId,
                    thumb: deal.thumb,
                    title: deal.title,
                  ),
                  deals: [deal],
                ),
              );
            },
          );
        }
        return TextButton.icon(
          icon: const Icon(Icons.remove_red_eye),
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
