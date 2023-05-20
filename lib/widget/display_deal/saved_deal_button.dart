import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/model/price_alert.dart';
import 'package:gameshop_deals/riverpod/cache_manager_provider.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart'
    show storesProvider, singleDeal;
import 'package:gameshop_deals/riverpod/saved_deals_provider.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final _titleDialog = Provider<String>((_) => throw UnimplementedError());

class SavedDealButton extends ConsumerWidget {
  const SavedDealButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final deal = ref.watch(singleDeal);
    final savedDeal = ref.watch(savedStreamProvider(deal.gameId));
    return savedDeal.maybeWhen(
      orElse: () => OutlinedButton(
        onPressed: null,
        child: Text(
          RefreshLocalizations.of(context)?.currentLocalization?.loadingText ??
              '',
        ),
      ),
      data: (isSaved) {
        if (!isSaved) {
          return OutlinedButton.icon(
            icon: const Icon(Icons.visibility_outlined),
            label: Flexible(
              child: Text(
                translate.save_game,
                overflow: TextOverflow.fade,
                softWrap: false,
              ),
            ),
            onPressed: () async {
              final box = await ref.read(savedBoxProvider.future);
              await box.put(deal.gameId, PriceAlert());
              /* final priceAlert = await showDialog<PriceAlert>(
                context: context,
                builder: (context) {
                  return ProviderScope(overrides: [
                    _titleDialog.overrideWithValue(
                        deal.title ?? deal.internalName ?? '')
                  ], child: const _PriceAlertDialog());
                },
              );
              if (priceAlert != null) await box.put(deal.gameId, priceAlert); */
            },
          );
        }
        return OutlinedButton.icon(
          icon: const Icon(Icons.visibility_off_outlined),
          label: Flexible(
            child: Text(
              translate.remove_game,
              overflow: TextOverflow.fade,
              softWrap: false,
            ),
          ),
          onPressed: () async {
            final box = await ref.read(savedBoxProvider.future);
            await box.delete(deal.gameId);
          },
        );
      },
    );
  }
}

class SavedTextDealButton extends ConsumerWidget {
  const SavedTextDealButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final deal = ref.watch(singleDeal);
    final savedDeal = ref.watch(savedStreamProvider(deal.gameId));
    return savedDeal.maybeWhen(
      orElse: () => TextButton.icon(
        onPressed: null,
        icon: const SizedBox(),
        label: Text(
          RefreshLocalizations.of(context)?.currentLocalization?.loadingText ??
              '',
        ),
      ),
      data: (isSaved) {
        if (!isSaved) {
          return TextButton.icon(
            icon: const Icon(Icons.visibility_outlined),
            label: Flexible(
              child: Text(
                translate.save_game,
                overflow: TextOverflow.fade,
                softWrap: false,
              ),
            ),
            onPressed: () async {
              final box = await ref.read(savedBoxProvider.future);
              await box.put(deal.gameId, PriceAlert());
              /* final priceAlert = await showDialog<PriceAlert>(
                context: context,
                builder: (context) {
                  return ProviderScope(overrides: [
                    _titleDialog.overrideWithValue(
                        deal.title ?? deal.internalName ?? '')
                  ], child: const _PriceAlertDialog());
                },
              );
              if (priceAlert != null) await box.put(deal.gameId, priceAlert); */
            },
          );
        }
        return TextButton.icon(
          icon: const Icon(Icons.visibility_off_outlined),
          label: Flexible(
            child: Text(
              translate.remove_game,
              overflow: TextOverflow.fade,
              softWrap: false,
            ),
          ),
          onPressed: () async {
            final box = await ref.read(savedBoxProvider.future);
            await box.delete(deal.gameId);
          },
        );
      },
    );
  }
}

class _PriceAlertDialog extends StatefulWidget {
  const _PriceAlertDialog({Key? key}) : super(key: key);

  @override
  __PriceAlertDialogState createState() => __PriceAlertDialogState();
}

class __PriceAlertDialogState extends State<_PriceAlertDialog> {
  PriceAlert alertPrice = PriceAlert();
  late S translate;
  late MaterialLocalizations localizations;

  @override
  void didChangeDependencies() {
    translate = S.of(context);
    localizations = MaterialLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Consumer(
        builder: (context, ref, _) => Text(
          ref.watch(_titleDialog),
          textAlign: TextAlign.center,
        ),
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 424),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              translate.alert_price(alertPrice.price.toInt()),
              textAlign: TextAlign.center,
            ),
            Slider.adaptive(
              value: alertPrice.price,
              onChanged: (newValue) {
                setState(
                    () => alertPrice = alertPrice.copyWith(price: newValue));
              },
              min: 0,
              max: 100,
              divisions: 100,
              label: '\$${alertPrice.price.toInt()}',
            ),
            Text(
              '${translate.stores}',
              textAlign: TextAlign.left,
            ),
            Consumer(
              builder: (context, ref, _) {
                final stores = ref.watch(storesProvider);
                return stores.when(
                  loading: () => const Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: const LinearProgressIndicator(minHeight: 4),
                  ),
                  error: (err, stack) => OutlinedButton(
                    child: Text('Error fetching the stores'),
                    onPressed: () => ref.refresh(storesProvider),
                  ),
                  data: (stores) {
                    return Wrap(
                      spacing: 8,
                      children: <Widget>[
                        ChoiceChip(
                          selected: alertPrice.storeId.isEmpty,
                          onSelected: (val) {
                            setState(() => alertPrice =
                                alertPrice.copyWith(storeId: const <String>{}));
                          },
                          label: Text(translate.all_choice),
                          avatar: const Icon(
                            Icons.all_inclusive,
                            size: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(4),
                              bottomRight: Radius.circular(4),
                              topRight: Radius.circular(4),
                              topLeft: Radius.circular(4),
                            ),
                          ),
                          tooltip: translate.all_stores_tooltip,
                        ),
                        for (var store in stores)
                          ChoiceChip(
                            selected:
                                alertPrice.storeId.contains(store.storeId),
                            onSelected: (val) {
                              Set<String> set =
                                  Set<String>.from(alertPrice.storeId);
                              if (val)
                                set.add(store.storeId);
                              else
                                set.remove(store.storeId);
                              setState(() => alertPrice =
                                  alertPrice.copyWith(storeId: set));
                            },
                            label: Text(store.storeName),
                            avatar: CachedNetworkImage(
                              cacheManager: ref.watch(
                                  cacheManagerFamilyProvider(cacheKeyStores)),
                              imageUrl: cheapsharkUrl + store.images.icon,
                              fit: BoxFit.contain,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(4),
                                bottomRight: Radius.circular(4),
                                topRight: Radius.circular(4),
                                topLeft: Radius.circular(4),
                              ),
                            ),
                            tooltip: store.storeName,
                          ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, alertPrice),
          child: Text(localizations.saveButtonLabel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(localizations.cancelButtonLabel),
        ),
      ],
    );
  }
}
