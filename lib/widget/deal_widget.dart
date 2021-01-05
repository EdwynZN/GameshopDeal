import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart' show singleDeal;
import 'package:gameshop_deals/widget/display_deal/metacritic.dart';
import 'package:gameshop_deals/widget/display_deal/price_widget.dart';
import 'package:gameshop_deals/widget/display_deal/release_date.dart';
import 'package:gameshop_deals/widget/display_deal/store_avatar.dart';
import 'package:gameshop_deals/widget/display_deal/thumb_image.dart';
import 'package:gameshop_deals/widget/display_deal/deal_date.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gameshop_deals/utils/routes_constants.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart' show cheapsharkUrl;

final indexDeal = ScopedProvider<int>(null);

class GridDeal extends ConsumerWidget {
  final bool showDeal;
  const GridDeal({Key key, this.showDeal = true})
      : assert(showDeal != null, 'showDeal cannot be \'null\''),
        super(key: key);

  @override
  Widget build(BuildContext context, watch) {
    final deal = watch(singleDeal);
    assert(deal != null);
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style.copyWith(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) return null;
          return Theme.of(context).cardColor;
        }),
      ),
      onPressed: () async {
        String _dealLink = '$cheapsharkUrl/redirect?dealID=${deal.dealId}';
        if (await canLaunch(_dealLink)) {
          await launch(_dealLink);
        } else {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text('Error Launching url')),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: 56.0, maxHeight: 48),
                  child: StoreAvatarBanner()),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 8.0),
              child: PriceWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class TileDeal extends StatelessWidget {
  final bool showDeal;
  const TileDeal({Key key, this.showDeal = true})
      : assert(showDeal != null, 'showDeal cannot be \'null\''),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      //margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: null,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 70, maxWidth: 120),
                child: const ThumbImage(),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 8.0),
              child: showDeal
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(child: const _TitleDeal()),
                        Flexible(flex: null, child: const PriceWidget())
                      ],
                    )
                  : const _TitleDeal(showStore: false),
            ),
          ),
        ],
      ),
    );
  }
}

class ListDeal extends StatelessWidget {
  final bool showDeal;
  const ListDeal({Key key, this.showDeal = true})
      : assert(showDeal != null, 'showDeal cannot be \'null\''),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget child = Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: Divider.createBorderSide(context),
        ),
      ),
      padding: const EdgeInsets.only(left: 4, right: 4, top: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: null,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 70, maxWidth: 120),
                child: const ThumbImage(),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 8.0),
              child: showDeal
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(child: const _TitleDeal()),
                        Flexible(flex: null, child: const PriceWidget())
                      ],
                    )
                  : const _TitleDeal(showStore: false),
            ),
          ),
        ],
      ),
    );

    if (!showDeal) return child;
    return Consumer(
      child: child,
      builder: (context, watch, child) {
        final int index = watch(indexDeal);
        return GestureDetector(
          onTap: () =>
              Navigator.of(context).pushNamed(detailRoute, arguments: index),
          child: child,
        );
      },
    );
  }
}

class _TitleDeal extends ConsumerWidget {
  final bool showStore;
  const _TitleDeal({
    this.showStore = true,
    Key key,
  })  : assert(showStore != null, 'showDeal cannot be \'null\''),
        super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final deal = watch(singleDeal);
    assert(deal != null);
    final bool score = deal.metacriticScore != '0';
    final bool changed = deal.lastChange != 0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (deal.title.isNotEmpty)
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 4, end: 4),
            child: Text(
              deal.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        DefaultTextStyle(
          style: Theme.of(context).textTheme.overline,
          child: Wrap(
            runSpacing: 2.0,
            children: [
              const Released(),
              if (score) ...[const Text(' · '), const Metacritic()],
              if (changed != 0 && showStore) const DealDate(),
              if (showStore) ...[
                const Text(' · '),
                const StoreAvatarIcon(),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
