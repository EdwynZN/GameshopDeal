import 'package:flutter/material.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/model/sort_by_enum.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/metacritic.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/price_widget.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/save_button.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/store_avatar.dart';
import 'package:gameshop_deals/presentation/widgets/view_deals/thumb_image.dart';
import 'package:gameshop_deals/provider/deal_provider.dart';
import 'package:gameshop_deals/provider/filter_provider.dart';
import 'package:gameshop_deals/provider/preference_provider.dart';
import 'package:gameshop_deals/utils/constraints.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';
import 'package:gameshop_deals/utils/routes_constants.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';

final indexDeal = Provider.autoDispose<int>((_) => throw UnimplementedError());

final _sortByProvider = Provider.autoDispose<SortBy>((ref) {
  final title = ref.watch(titleProvider);
  return ref.watch(filterProviderCopy(title).select((f) => f.sortBy));
}, name: 'Sort By');

class DetailedDeal extends ConsumerWidget {
  const DetailedDeal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deal = ref.watch(singleDeal);
    final int index = ref.watch(indexDeal);

    final Widget child = Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: Divider.createBorderSide(context),
        ),
      ),
      padding: const EdgeInsets.only(left: 4, right: 4, top: 8, bottom: 8),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding:
                  EdgeInsetsDirectional.only(start: 8.0, bottom: 4, end: 4),
              child: _TitleDeal(),
            ),
          ),
          const Flexible(child: Center(child: PriceWidget())),
        ],
      ),
    );
    return InkWell(
      onTap: () =>
          Navigator.of(context).pushNamed(detailRoute, arguments: index),
      onLongPress: () async {
        showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          builder: (context) => ProviderScope(
            overrides: [singleDeal.overrideWithValue(deal)],
            child: const _BottomSheetButtonsDeal(),
          ),
        );
      },
      child: child,
    );
  }
}

class CompactDeal extends ConsumerWidget {
  const CompactDeal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deal = ref.watch(singleDeal);
    final String title = deal.title;
    final int index = ref.watch(indexDeal);
    final view = ref.watch(_sortByProvider);
    final bool showMetacritic = view == SortBy.Metacritic;
    final bool showRating = view == SortBy.Reviews;
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(bottom: Divider.createBorderSide(context)),
      ),
      child: ListTile(
        leading: ProviderScope(
          overrides: [storeIdProvider.overrideWithValue(deal.storeId)],
          child: const StoreAvatarIcon(),
        ),
        dense: true,
        title: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: _Subtitle(
          showRating: showRating,
          showMetacritic: showMetacritic,
          showStore: false,
        ),
        trailing: const PriceWidget(),
        onTap: () =>
            Navigator.of(context).pushNamed(detailRoute, arguments: index),
        onLongPress: () async {
          showModalBottomSheet(
            context: context,
            useRootNavigator: true,
            builder: (context) => ProviderScope(
              overrides: [singleDeal.overrideWithValue(deal)],
              child: const _BottomSheetButtonsDeal(),
            ),
          );
        },
      ),
    );
  }
}

class GridDeal extends ConsumerWidget {
  const GridDeal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deal = ref.watch(singleDeal);
    final int index = ref.watch(indexDeal);
    final color = Colors.grey[850]!;
    final theme = Theme.of(context);
    final Color borderColor = theme.brightness == Brightness.light
        ? Colors.black38
        : theme.dividerColor;
    return InkWell(
      onTap: () =>
          Navigator.of(context).pushNamed(detailRoute, arguments: index),
      onLongPress: () async {
        showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          builder: (context) => ProviderScope(
            overrides: [singleDeal.overrideWithValue(deal)],
            child: const _BottomSheetButtonsDeal(),
          ),
        );
      },
      child: GridTile(
        header: GridTileBar(
          title: Text(
            deal.title,
            maxLines: 2,
          ),
          leading: ProviderScope(
            overrides: [storeIdProvider.overrideWithValue(deal.storeId)],
            child: StoreAvatarIcon(
              size: Theme.of(context).textTheme.bodyMedium?.fontSize,
            ),
          ),
        ),
        child: DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 0.0),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              tileMode: TileMode.mirror,
              colors: <Color>[
                color,
                color.withOpacity(0.75),
                color.withOpacity(0.0),
              ],
              stops: [0.0, 0.3, 0.5],
            ),
          ),
          child: ProviderScope(
            overrides: [
              thumbProvider.overrideWithValue(deal.thumb),
            ],
            child: const ThumbImage(
              alignment: Alignment.center,
              fit: BoxFit.scaleDown,
              addInk: true,
            ),
          ),
        ),
        footer: GridTileBar(
          title: const FittedBox(
            alignment: Alignment.center,
            fit: BoxFit.scaleDown,
            child: const PriceWidget(),
          ),
        ),
      ),
    );
  }
}

class ListDeal extends StatelessWidget {
  const ListDeal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget child = Container(
      constraints: const BoxConstraints(maxWidth: 800.0),
      padding: allPadding12,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 120.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 70.0),
                    child: ProviderScope(
                      overrides: [
                        thumbProvider.overrideWith(
                          (ProviderRef ref) => ref.watch(singleDeal).thumb,
                        ),
                      ],
                      child: const ThumbImage(),
                    ),
                  ),
                ),
                gap8,
                const RowPriceWidget(),
              ],
            ),
          ),
          gap4,
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 8.0, end: 4.0),
              child: _ListTitle(),
            ),
          ),
        ],
      ),
    );
    return HookConsumer(
      child: child,
      builder: (context, ref, child) {
        final options = useState(false);
        final deal = ref.watch(singleDeal);
        final int index = ref.watch(indexDeal);
        return Align(
          alignment: AlignmentDirectional.centerStart,
          child: Card(
            margin: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
            elevation: 1.0,
            shadowColor: const Color(0x10666666),
            child: InkWell(
              onTap: () => context.pushNamed(
                detailRoute,
                extra: index,
              ),
              onLongPress: () {
                options.value = !options.value;
              },
              child: Column(
                children: [
                  child!,
                  AnimatedSize(
                    alignment: Alignment.bottomCenter,
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOutCubicEmphasized,
                    child: options.value
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(
                              12.0,
                              0.0,
                              12.0,
                              12.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const SavedTextDealButton(),
                                gap4,
                                IconButton.filledTonal(
                                  onPressed: () async {
                                    showModalBottomSheet(
                                      context: context,
                                      useRootNavigator: true,
                                      builder: (context) => ProviderScope(
                                        overrides: [
                                          singleDeal.overrideWithValue(deal)
                                        ],
                                        child: const _BottomSheetButtonsDeal(),
                                      ),
                                    );
                                  },
                                  tooltip: 'More',
                                  icon: const Icon(Icons.more_vert_outlined),
                                ),
                              ],
                            ),
                          )
                        : emptyWidget,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ListTitle extends ConsumerWidget {
  const _ListTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deal = ref.watch(singleDeal);

    const subtitle = Padding(
      padding: EdgeInsetsDirectional.only(end: 4),
      child: _Subtitle(showStore: false, showMetacritic: false),
    );

    if (deal.title.isEmpty) {
      return subtitle;
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 4.0),
          child: Text(
            deal.title,
            maxLines: 2,
            style: const TextStyle(
              height: 1.15,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const Divider(height: 12.0),
        subtitle,
      ],
    );
  }
}

class _TitleDeal extends ConsumerWidget {
  const _TitleDeal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deal = ref.watch(singleDeal);

    const subtitle = Padding(
      padding: EdgeInsetsDirectional.only(end: 4),
      child: _Subtitle(),
    );

    if (deal.title.isEmpty) {
      return subtitle;
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 4.0, end: 4.0),
          child: Text(
            deal.title,
            maxLines: 2,
            style: const TextStyle(
              height: 1.25,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle,
      ],
    );
  }
}

class _Subtitle extends ConsumerWidget {
  final bool showStore;
  final bool showMetacritic;
  final bool showReleaseDate;
  final bool showRating;
  final bool showLastChange;

  const _Subtitle({
    Key? key,
    bool? showStore,
    bool? showMetacritic,
    bool? showReleaseDate,
    bool? showRating,
    bool? showLastChange,
  })  : this.showStore = showStore ?? true,
        this.showMetacritic = showMetacritic ?? true,
        this.showReleaseDate = showReleaseDate ?? true,
        this.showRating = showRating ?? true,
        this.showLastChange = showLastChange ?? true,
        super(key: key);

  String _difference(S translate, int mEpoch) {
    final DateTime change = DateTime.fromMillisecondsSinceEpoch(mEpoch * 1000);
    final difference = DateTime.now().difference(change);
    if (difference.inDays >= 365)
      return translate.change_in_years(difference.inDays ~/ 365);
    else if (difference.inDays >= 30)
      return translate.change_in_months(difference.inDays ~/ 30);
    else if (difference.inHours >= 24)
      return translate.change_in_days(difference.inHours ~/ 24);
    else if (difference.inMinutes >= 60)
      return translate.change_in_hours(difference.inMinutes ~/ 60);
    else if (difference.inMinutes >= 1)
      return translate.change_in_minutes(difference.inMinutes);
    else
      return translate.now;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final theme = Theme.of(context);
    final deal = ref.watch(singleDeal);
    List<InlineSpan> span = <InlineSpan>[
      if (showStore)
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: ProviderScope(
            overrides: [storeIdProvider.overrideWithValue(deal.storeId)],
            child: StoreAvatarIcon(
              size: theme.textTheme.bodyMedium?.fontSize,
            ),
          ),
        ),
    ];
    if (showMetacritic && deal.metacriticScore != '0') {
      span.add(
        const WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Metacritic(),
        ),
      );
    }
    if (showRating && deal.steamRatingText != null) {
      Color color, textColor = Colors.white;
      final int rating = int.parse(deal.steamRatingPercent);
      final String ratingText = deal.steamRatingText!.replaceAll(' ', '_');
      if (rating >= 95) {
        color = Colors.green.shade300;
        textColor = Colors.black;
      } else if (rating >= 65) {
        color = Colors.lightGreen.shade300;
        textColor = Colors.black;
      } else if (rating >= 40) {
        color = Colors.orange;
        textColor = Colors.black;
      } else {
        color = Colors.red.shade600;
      }
      span.add(
        TextSpan(
          text: ' ${translate.review(ratingText)} ',
          style: theme.textTheme.labelSmall?.copyWith(
            backgroundColor: color,
            color: textColor,
          ),
        ),
      );
    }
    if (deal.publisher != null) {
      span.add(
        TextSpan(
          text: deal.publisher,
          style: theme.primaryTextTheme.labelSmall?.copyWith(
            height: 1.5,
            backgroundColor: theme.colorScheme.secondary,
          ),
        ),
      );
    }
    if (showLastChange) {
      String time = _difference(translate, deal.lastChange);
      span.add(
        TextSpan(text: time),
      );
    }

    for (int i = 1; i < span.length; i = i + 2) {
      span.insert(i, const TextSpan(text: ' · '));
    }

    final int releaseDate = deal.releaseDate;
    if (showReleaseDate && releaseDate != 0) {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(releaseDate * 1000);
      final formatShortDate =
          MaterialLocalizations.of(context).formatShortDate(dateTime);
      final bool alreadyRealeased = DateTime.now().isAfter(dateTime);
      final String time = alreadyRealeased
          ? translate.release(formatShortDate)
          : ' ${translate.future_release(formatShortDate)} ';
      span.insert(
        0,
        TextSpan(
          text: '$time\n',
          style: alreadyRealeased
              ? theme.textTheme.labelSmall?.copyWith(height: 1.75)
              : theme.textTheme.labelSmall?.copyWith(
                  color: Colors.black,
                  height: 1.75,
                  backgroundColor: Colors.orangeAccent,
                ),
        ),
      );
    }

    return RichText(
      textAlign: TextAlign.left,
      overflow: TextOverflow.fade,
      text: TextSpan(
        style: theme.textTheme.labelSmall,
        children: span,
      ),
    );
  }
}

class _BottomSheetButtonsDeal extends ConsumerWidget {
  const _BottomSheetButtonsDeal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    final deal = ref.watch(singleDeal);
    final title = deal.title;
    final metacriticLink = deal.metacriticLink;
    final steamAppId = deal.steamAppId;
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(top: 16.0),
      constraints: BoxConstraints(minWidth: 320.0, maxWidth: 380.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(bottom: Divider.createBorderSide(context)),
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge,
              ),
            ),
          TextButton.icon(
            style: ButtonStyle(
              iconSize: const MaterialStatePropertyAll(36.0),
              textStyle: MaterialStatePropertyAll(theme.textTheme.headlineSmall)
            ),
            icon: ProviderScope(
              overrides: [storeIdProvider.overrideWithValue(deal.storeId)],
              child: StoreAvatarLogo(),
            ),
            label: Text(translate.go_to_deal),
            onPressed: () async {
              final _dealLink =
                  Uri.parse('${cheapsharkUrl}/redirect?dealID=${deal.dealId}');
              if (await canLaunchUrl(_dealLink)) {
                final bool webView = ref.read(preferenceProvider).webView;
                await launchUrl(
                  _dealLink,
                  mode: webView
                      ? LaunchMode.externalApplication
                      : LaunchMode.inAppWebView,
                );
              }
            },
          ),
          if (steamAppId != null) ...[
            TextButton.icon(
              icon: const Icon(Icons.rate_review),
              label: Text(translate.review_tooltip),
              onPressed: () async {
                final Uri _steamLink = Uri.https(
                  steamUrl,
                  '/app/${deal.steamAppId}',
                );
                if (await canLaunchUrl(_steamLink)) {
                  final bool webView = ref.read(preferenceProvider).webView;
                  await launchUrl(
                    _steamLink,
                    mode: webView
                        ? LaunchMode.externalApplication
                        : LaunchMode.inAppWebView,
                  );
                }
              },
            ),
            TextButton.icon(
              icon: const Icon(Icons.computer),
              label: const Text('PC Wiki'),
              onPressed: () async {
                final Uri _pcGamingWikiUri = Uri.https(
                    pcWikiUrl, '/api/appid.php', {'appid': steamAppId});
                if (await canLaunchUrl(_pcGamingWikiUri)) {
                  final bool webView = ref.read(preferenceProvider).webView;
                  await launchUrl(
                    _pcGamingWikiUri,
                    mode: webView
                        ? LaunchMode.externalApplication
                        : LaunchMode.inAppWebView,
                  );
                }
              },
            ),
          ],
          if (metacriticLink != null)
            TextButton.icon(
              icon: CircleAvatar(
                radius: (IconTheme.of(context).size ?? 24.0) / 2.4,
                backgroundImage:
                    const AssetImage('assets/thumbnails/metacritic.png'),
              ),
              label: const Text('Metacritic'),
              onPressed: () async {
                final Uri _metacriticLink = Uri.https(
                  metacriticUrl,
                  metacriticLink,
                );
                if (await canLaunchUrl(_metacriticLink)) {
                  final bool webView = ref.read(preferenceProvider).webView;
                  await launchUrl(
                    _metacriticLink,
                    mode: webView
                        ? LaunchMode.externalApplication
                        : LaunchMode.inAppWebView,
                  );
                }
              },
            ),
        ],
      ),
    );
  }
}
