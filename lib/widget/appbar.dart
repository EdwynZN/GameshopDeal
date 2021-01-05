import 'package:flutter/material.dart';
import 'package:gameshop_deals/riverpod/display_provider.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/riverpod/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/utils/routes_constants.dart';
import 'package:gameshop_deals/widget/dialog_preference_provider.dart';
import 'package:gameshop_deals/widget/radio_popup_menu_item.dart';
import 'package:flutter/foundation.dart';
import 'package:gameshop_deals/model/filter.dart';
import 'package:gameshop_deals/model/deal_view_enum.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/widget/search_delegate.dart';

/*
class HomeAppBar extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      shape: CustomAppBarShape(),
      pinned: true, primary: true,
      title: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis blandit'),
      actions: <Widget>[
        const Icon(Icons.search),
        const SizedBox(width: 20,),
        const Icon(Icons.remove_red_eye),
        const SizedBox(width: 20,)
      ],
    );
  }
}

class CustomAppBarShape extends ContinuousRectangleBorder{

  @override
  Path getOuterPath(Rect rect, { TextDirection textDirection }) {
    return Path()..lineTo(0, rect.height)
      ..quadraticBezierTo(rect.width / 2, rect.height + 20, rect.width, rect.height)
      ..lineTo(rect.width, 0);
  }
}*/
/* 
class CustomAppBarShape extends ContinuousRectangleBorder {
  Path _getPath(RRect rect) {
    return Path()
      ..lineTo(0, rect.height)
      ..quadraticBezierTo(
          rect.width / 2, rect.height + 20, rect.width, rect.height)
      ..lineTo(rect.width, 0);
  }

  Path _getinnerPath(RRect rect) {
    return Path()
      ..lineTo(0, rect.height)
      ..quadraticBezierTo(
          rect.width / 2, rect.height + 30, rect.width, rect.height)
      ..lineTo(rect.width, 0);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return _getPath(borderRadius.resolve(textDirection).toRRect(rect));
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return _getinnerPath(borderRadius.resolve(textDirection).toRRect(rect));
  }
}
 */
final _sortByProvider = ScopedProvider<SortBy>(
  (watch) => watch(filterProvider).state.sortBy,
  name: 'Sort By',
);

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      primary: true,
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

class _SearchButton extends StatelessWidget {
  const _SearchButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search_rounded),
      onPressed: () async {
        final result = await showSearch<String>(
            context: context, delegate: AppSearchDelegate<String>());
        if (result != null) {
          final filter = context.read(filterProvider).state.copyWith(title: result);
          Navigator.of(context).pushNamed(searchRoute, arguments: filter);
          print(result);
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
        PopupMenuItem<int>(child: Text(translate.deal_view), value: 0),
        PopupMenuItem<int>(child: Text(translate.choose_theme), value: 1),
        PopupMenuItem<int>(child: Text(translate.settings), value: 2),
        PopupMenuItem<int>(child: Text(translate.feedback), value: 3),
        PopupMenuItem<int>(child: Text(translate.help), value: 4),
      ],
    );
  }

  Future<void> _postView() {
    final double size = Theme.of(context).appBarTheme.iconTheme.size ?? 24;
    Offset offset =
        context.size.centerRight(Size.square(size).center(Offset.zero));
    return showMenu<DealView>(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
      items: [
        PopupMenuItem(
          child: Text(translate.deal_view),
          enabled: false,
          textStyle: Theme.of(context).textTheme.subtitle2,
        ),
        for (DealView view in DealView.values)
          RadioPopupMenuItem<DealView>(
            child: Text(translate.choose_deal_view(view)),
            value: view,
            provider: displayProvider,
          ),
      ],
    );
  }

  Future<void> _theme() {
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
            child: Text(translate.themeMode(mode)),
            value: mode,
            provider: themeProvider,
          ),
      ],
    );
  }

  Future<void> _postViewDialog() async {
    final DealView mode = await showDialog<DealView>(
      context: context,
      builder: (_) => PreferenceDialog<DealView>(
          title: translate.deal_view,
          provider: displayProvider,
          values: DealView.values),
    );
    if (mode != null) context.read(displayProvider).changeState(mode);
  }

  Future<void> _themeDialog() async {
    final ThemeMode mode = await showDialog<ThemeMode>(
      context: context,
      builder: (_) => PreferenceDialog<ThemeMode>(
          title: translate.choose_theme,
          provider: themeProvider,
          values: ThemeMode.values),
    );
    if (mode != null) context.read(themeProvider).changeState(mode);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: MaterialLocalizations.of(context).moreButtonTooltip,
      icon: const Icon(Icons.more_vert_outlined),
      onPressed: () async {
        int selectedOption = await _selectedOption();
        if (!mounted) return;
        switch (selectedOption) {
          case 0:
            _postViewDialog();
            break;
          case 1:
            _themeDialog();
            break;
          case 2:
            Navigator.pushNamed(context, settingsRoute);
            break;
        }
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
