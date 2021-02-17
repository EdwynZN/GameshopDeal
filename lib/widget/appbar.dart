import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/model/view_enum.dart';
import 'package:gameshop_deals/model/sort_by_enum.dart';
import 'package:gameshop_deals/riverpod/deal_provider.dart'
    show dealPageProvider;
import 'package:gameshop_deals/riverpod/display_provider.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/riverpod/theme_provider.dart';
import 'package:gameshop_deals/utils/routes_constants.dart';
import 'package:gameshop_deals/widget/dialog_preference_provider.dart';
import 'package:gameshop_deals/widget/radio_popup_menu_item.dart';
import 'package:gameshop_deals/widget/search_delegate.dart';
import 'package:in_app_review/in_app_review.dart';

final InAppReview _inAppReview = InAppReview.instance;

final _sortByProvider = ScopedProvider<SortBy>(
  (watch) => watch(filterProvider(watch(titleProvider))).state.sortBy,
  name: 'Sort By',
);

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  const HomeAppBar({Key key})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Consumer(
        builder: (context, watch, _) {
          final S translate = S.of(context);
          return Text(translate.sort(watch(_sortByProvider)));
        },
      ),
      actions: const <Widget>[
        const _SavedGamesButton(),
        const _SearchButton(),
        const _FilterButton(),
        const _MoreSettings(),
      ],
    );
  }
}

class SearchAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  const SearchAppBar({Key key})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      primary: true,
      leading: BackButton(
        onPressed: () => Navigator.of(context, rootNavigator: true).maybePop(),
      ),
      title: Consumer(
        builder: (context, watch, _) {
          final title = watch(titleProvider);
          return Text(
            title,
            overflow: TextOverflow.fade,
          );
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

class SavedAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  const SavedAppBar({Key key})
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
        const _MoreSettings(),
      ],
    );
  }
}

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      primary: true,
      forceElevated: true,
      title: Consumer(
        builder: (context, watch, _) {
          final S translate = S.of(context);
          return Text(translate.sort(watch(_sortByProvider)));
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
  const SearchSliverAppBar({Key key}) : super(key: key);

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
        builder: (context, watch, _) {
          final title = watch(titleProvider);
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
  const _SearchButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final title = watch(titleProvider);
    return IconButton(
      icon: const Icon(Icons.search_rounded),
      onPressed: () async {
        final result = await showSearch<String>(
          context: context,
          delegate: AppSearchDelegate(),
        );
        if (result != null && result != title) {
          Navigator.of(context, rootNavigator: true)
              .pushNamed(searchRoute, arguments: result);
        }
      },
      tooltip: MaterialLocalizations.of(context).searchFieldLabel,
    );
  }
}

class _MoreSettings extends StatefulWidget {
  const _MoreSettings({Key key}) : super(key: key);

  @override
  __MoreSettingsState createState() => __MoreSettingsState();
}

class __MoreSettingsState extends State<_MoreSettings> {
  S translate;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    translate = S.of(context);
  }

  Future<int> _selectedOption() {
    final double size = Theme.of(context).appBarTheme.iconTheme.size ?? 24;
    Offset offset =
        context.size.centerRight(Size.square(size).center(Offset.zero));
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

  // ignore: unused_element
  Future<void> _postViewMenu() {
    final double size = Theme.of(context).appBarTheme.iconTheme.size ?? 24;
    Offset offset =
        context.size.centerRight(Size.square(size).center(Offset.zero));
    return showMenu<View>(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
      items: [
        PopupMenuItem(
          child: Text(translate.view),
          enabled: false,
          textStyle: Theme.of(context).textTheme.subtitle2,
        ),
        for (View view in View.values)
          RadioPopupMenuItem<View>(
            child: Text(translate.choose_view(view)),
            value: view,
            provider: displayProvider,
          ),
      ],
    );
  }

  // ignore: unused_element
  Future<void> _themeMenu() {
    final double size = Theme.of(context).appBarTheme.iconTheme.size ?? 24;
    Offset offset =
        context.size.centerRight(Size.square(size).center(Offset.zero));
    return showMenu<ThemeMode>(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
      items: [
        PopupMenuItem(
          child: Text(translate.choose_theme),
          enabled: false,
          textStyle: Theme.of(context).textTheme.subtitle2,
        ),
        for (ThemeMode mode in ThemeMode.values)
          RadioPopupMenuItem<ThemeMode>(
            child: Text(
              translate.themeMode(mode),
              maxLines: 1,
            ),
            value: mode,
            provider: themeProvider,
          ),
      ],
    );
  }

  // ignore: unused_element
  Future<void> _postViewDialog() async {
    final View mode = await showDialog<View>(
      context: context,
      builder: (_) => PreferenceDialog<View>(
          title: translate.view,
          provider: displayProvider,
          values: View.values),
    );
    if (mode != null) context.read(displayProvider).changeState(mode);
  }

  // ignore: unused_element
  Future<void> _themeDialog() async {
    final ThemeMode mode = await showDialog<ThemeMode>(
      context: context,
      builder: (_) => PreferenceDialog<ThemeMode>(
        title: translate.choose_theme,
        provider: themeProvider,
        values: ThemeMode.values,
      ),
    );
    if (mode != null) context.read(themeProvider).changeState(mode);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      child: const Icon(Icons.more_vert_outlined),
      builder: (context, watch, child) {
        final title = watch(titleProvider);
        return IconButton(
          tooltip: MaterialLocalizations.of(context).moreButtonTooltip,
          icon: child,
          onPressed: () async {
            int selectedOption = await _selectedOption();
            if (!mounted) return;
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
                context.refresh(dealPageProvider(title));
                break;
              case 4:
                Navigator.of(context, rootNavigator: true)
                    .pushNamed(settingsRoute);
                break;
            }
          },
        );
      },
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final S translate = S.of(context);
    return IconButton(
      icon: const Icon(Icons.filter_list),
      onPressed: () => Scaffold.of(context).hasEndDrawer
          ? Scaffold.of(context).openEndDrawer()
          : Navigator.pushNamed(context, filterRoute),
      tooltip: translate.filter_tooltip,
    );
  }
}

class _SavedGamesButton extends StatelessWidget {
  const _SavedGamesButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final S translate = S.of(context);
    return IconButton(
      icon: const Icon(Icons.visibility_outlined),
      onPressed: () async =>
          Navigator.of(context, rootNavigator: true).pushNamed(savedGamesRoute),
      tooltip: translate.save_game_tooltip,
    );
  }
}
