import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/model/sort_by_enum.dart';
import 'package:gameshop_deals/model/view_format_enum.dart';
import 'package:gameshop_deals/presentation/widgets/preference_dialog.dart';
import 'package:gameshop_deals/presentation/widgets/radio_popup_menu_item.dart';
import 'package:gameshop_deals/presentation/widgets/search_delegate.dart';
import 'package:gameshop_deals/provider/deal_provider.dart';
import 'package:gameshop_deals/provider/display_provider.dart';
import 'package:gameshop_deals/provider/filter_provider.dart';
import 'package:gameshop_deals/provider/saved_deals_provider.dart';
import 'package:gameshop_deals/provider/theme_provider.dart';
import 'package:gameshop_deals/utils/routes_constants.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_review/in_app_review.dart';

final InAppReview _inAppReview = InAppReview.instance;

final _sortByProvider = Provider.autoDispose<SortBy>(
  (ref) => ref
      .watch(filterProvider(ref.watch(titleProvider)).select((f) => f.sortBy)),
  name: 'Sort By',
  dependencies: [titleProvider, filterProvider],
);

class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const HomeAppBar({Key? key})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(titleProvider);
    final bool isSearching = title.isNotEmpty;
    final String titletext;
    if (isSearching) {
      titletext = title;
    } else {
      titletext = 'Gameshop Deals';
    }
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text(titletext, overflow: TextOverflow.fade),
      actions: <Widget>[
        _SearchButton(),
        if (!isSearching) _SavedGamesButton(),
        _FilterButton(),
        _MoreSettings(),
      ],
    );
  }
}

class SavedAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const SavedAppBar({Key? key})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final S translate = S.of(context);
    return AppBar(
      primary: true,
      leading: BackButton(
        onPressed: () => Navigator.of(context, rootNavigator: true).maybePop(),
      ),
      title: Text(translate.save_game_title),
      actions: const <Widget>[
        //const _SearchButton(),
        const _MoreSettings(
          savedGamesRefresh: true,
        ),
      ],
    );
  }
}

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      primary: true,
      forceElevated: true,
      title: Consumer(
        builder: (context, ref, _) {
          final S translate = S.of(context);
          return Text(translate.sort(ref.watch(_sortByProvider)));
        },
      ),
      actions: const <Widget>[
        const _SearchButton(),
        const _FilterButton(),
        const _MoreSettings(),
      ],
    );
  }
}

class SearchSliverAppBar extends StatelessWidget {
  const SearchSliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      primary: true,
      forceElevated: true,
      leading: BackButton(
        onPressed: () => Navigator.of(context, rootNavigator: true).maybePop(),
      ),
      title: Consumer(
        builder: (context, ref, _) {
          final title = ref.watch(titleProvider);
          return Text(title);
        },
      ),
      actions: const <Widget>[
        const _SearchButton(),
        const _FilterButton(),
      ],
    );
  }
}

class _SearchButton extends ConsumerWidget {
  const _SearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = ref.watch(titleProvider);
    return IconButton(
      icon: const Icon(Icons.search_rounded),
      onPressed: () async {
        final result = await showSearch<String>(
          context: context,
          delegate: AppSearchDelegate(),
        );
        if (result != null && result != title) {
          final String nameRoute = 'search_response';
          final queryParameters = <String, dynamic>{'title': result};
          context.pushNamed(nameRoute, queryParameters: queryParameters);
        }
      },
      tooltip: MaterialLocalizations.of(context).searchFieldLabel,
    );
  }
}

class _MoreSettings extends ConsumerStatefulWidget {
  final bool savedGamesRefresh;
  const _MoreSettings({Key? key, this.savedGamesRefresh = false})
      : super(key: key);

  @override
  __MoreSettingsState createState() => __MoreSettingsState();
}

class __MoreSettingsState extends ConsumerState<_MoreSettings> {
  late S translate;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    translate = S.of(context);
  }

  Future<int?> _selectedOption() {
    final double size = Theme.of(context).appBarTheme.iconTheme?.size ?? 24;
    Offset offset =
        context.size!.centerRight(Size.square(size).center(Offset.zero));
    return showMenu<int>(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
      items: [
        PopupMenuItem<int>(child: Text(translate.view), value: 0),
        PopupMenuItem<int>(child: Text(translate.choose_theme), value: 1),
        PopupMenuItem<int>(child: Text(translate.rate_me), value: 2),
        //PopupMenuItem<int>(child: Text(translate.help), value: 4),
        PopupMenuItem<int>(child: Text(translate.refresh), value: 3),
        PopupMenuItem<int>(child: Text(translate.settings), value: 4),
      ],
    );
  }

  Future<void> _postViewMenu() {
    final double size = Theme.of(context).appBarTheme.iconTheme?.size ?? 24;
    Offset offset =
        context.size!.centerRight(Size.square(size).center(Offset.zero));
    return showMenu<ViewFormat>(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
      items: [
        PopupMenuItem(
          child: Text(translate.view),
          enabled: false,
          textStyle: Theme.of(context).textTheme.titleSmall,
        ),
        for (ViewFormat view in ViewFormat.values)
          RadioPopupMenuItem<ViewFormat>(
            child: Text(translate.choose_view(view)),
            value: view,
            provider: displayProvider,
            onTap: () => ref.read(displayProvider.notifier).changeState(view),
          ),
      ],
    );
  }

  // ignore: unused_element
  Future<void> _themeMenu() {
    final double size = Theme.of(context).appBarTheme.iconTheme?.size ?? 24;
    Offset offset =
        context.size!.centerRight(Size.square(size).center(Offset.zero));
    return showMenu<ThemeMode>(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
      items: [
        PopupMenuItem(
          child: Text(translate.choose_theme),
          enabled: false,
          textStyle: Theme.of(context).textTheme.titleSmall,
        ),
        for (ThemeMode mode in ThemeMode.values)
          RadioPopupMenuItem<ThemeMode>(
              child: Text(
                translate.themeMode(mode),
                maxLines: 1,
              ),
              value: mode,
              provider: themeModeProvider,
              onTap: () =>
                  ref.read(themeModeProvider.notifier).changeState(mode)),
      ],
    );
  }

  // ignore: unused_element
  Future<void> _postViewDialog() async {
    final ViewFormat? mode = await showDialog<ViewFormat>(
      context: context,
      builder: (_) => PreferenceDialog<ViewFormat>(
        title: translate.view,
        provider: displayProvider,
        values: ViewFormat.values,
      ),
    );
    if (mode == null) return;
    ref.read(displayProvider.notifier).changeState(mode);
  }

  // ignore: unused_element
  Future<void> _themeDialog() async {
    final ThemeMode? mode = await showDialog<ThemeMode>(
      context: context,
      builder: (_) => PreferenceDialog<ThemeMode>(
        title: translate.choose_theme,
        provider: themeModeProvider,
        values: ThemeMode.values,
      ),
    );
    if (mode == null) return;
    ref.read(themeModeProvider.notifier).changeState(mode);
  }

  @override
  Widget build(BuildContext context) {
    final title = ref.watch(titleProvider);
    return IconButton(
      tooltip: MaterialLocalizations.of(context).moreButtonTooltip,
      icon: const Icon(Icons.more_vert_outlined),
      onPressed: () async {
        int? selectedOption = await _selectedOption();
        if (!mounted || selectedOption == null) return;
        switch (selectedOption) {
          case 0:
            _postViewMenu();
            break;
          case 1:
            _themeMenu();
            break;
          case 2:
            if (await _inAppReview.isAvailable())
              _inAppReview.requestReview();
            else
              _inAppReview.openStoreListing();
            break;
          case 3:
            if (widget.savedGamesRefresh)
              ref.invalidate(savedGamesPageProvider);
            else
              ref.invalidate(dealPageProvider(title));
            break;
          case 4:
            context.pushNamed(settingsRoute);
            break;
        }
      },
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final S translate = S.of(context);
    return IconButton(
      icon: const Icon(Icons.filter_list),
      onPressed: () => Scaffold.of(context).openEndDrawer(),
      tooltip: translate.filter_tooltip,
    );
  }
}

class _SavedGamesButton extends StatelessWidget {
  const _SavedGamesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final S translate = S.of(context);
    return IconButton(
      icon: const Icon(Icons.bookmarks_rounded),
      onPressed: () => context.pushNamed(savedGamesRoute),
      tooltip: translate.save_game_tooltip,
    );
  }
}
