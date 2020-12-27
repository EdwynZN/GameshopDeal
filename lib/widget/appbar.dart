import 'package:flutter/material.dart';
import 'package:gameshop_deals/riverpod/filter_provider.dart';
import 'package:gameshop_deals/riverpod/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/utils/routes_constants.dart';
import 'package:gameshop_deals/widget/radio_popup_menu_item.dart';
import 'package:flutter/foundation.dart';
import 'package:gameshop_deals/model/filter.dart';

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

extension on SortBy {
  String get name {
    switch (this) {
      case SortBy.Deal_Rating:
        return 'Top Deals';
      case SortBy.Price:
        return 'Lowest Price';
      case SortBy.Savings:
        return 'Top Savings';
      case SortBy.Release:
        return 'Release Date';
      default:
        return describeEnum(this).replaceFirst('_', ' ');
    }
  }
}

final _sortByProvider = ScopedProvider<SortBy>(
    (watch) => watch(filterProvider).state.sortBy,
    name: 'Sort By');

final _themeModeProvider = StateProvider.autoDispose<ThemeMode>(
    (ref) => ref.watch(themeProvider.state),
    name: 'ThemeModeProvider');

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      primary: true,
      automaticallyImplyLeading: false,
      title: Consumer(
          builder: (context, watch, _) => Text(watch(_sortByProvider).name)),
      actions: <Widget>[const _FilterButton(), const _MoreSettings()],
    );
  }
}

class _MoreSettings extends StatefulWidget {
  const _MoreSettings({Key key}) : super(key: key);

  @override
  __MoreSettingsState createState() => __MoreSettingsState();
}

class __MoreSettingsState extends State<_MoreSettings> {
  Future<int> _selectedOption() {
    final double size = Theme.of(context).appBarTheme.iconTheme.size ?? 24;
    Offset offset =
        context.size.centerRight(Size.square(size).center(Offset.zero));
    return showMenu<int>(
        context: context,
        position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
        items: [
          PopupMenuItem<int>(child: const Text('Deal view'), value: 0),
          PopupMenuItem<int>(child: const Text('Choose theme'), value: 1),
          PopupMenuItem<int>(child: const Text('Settings'), value: 2),
          PopupMenuItem<int>(child: const Text('Send feedback'), value: 3),
          PopupMenuItem<int>(child: const Text('Help'), value: 4),
        ]);
  }

  Future<void> _postView() {
    final double size = Theme.of(context).appBarTheme.iconTheme.size ?? 24;
    Offset offset =
        context.size.centerRight(Size.square(size).center(Offset.zero));
    // Offset offset = context.size.center(Offset.zero);
    return showMenu<int>(
        context: context,
        position: RelativeRect.fromLTRB(offset.dx, offset.dy, 0, 0),
        items: [
          PopupMenuItem(
            child: const Text('Deal view'),
            enabled: false,
            textStyle: Theme.of(context).textTheme.subtitle2,
          ),
          RadioPopupMenuItem<int>(
            child: const Text('Cards'),
            value: 0,
          ),
          RadioPopupMenuItem<int>(child: const Text('Compat'), value: 1),
          RadioPopupMenuItem<int>(child: const Text('Swipe'), value: 2),
          RadioPopupMenuItem<int>(child: const Text('List'), value: 3),
        ]);
  }

  Future<void> _themeDialog() async {
    final ThemeMode mode = await showDialog<ThemeMode>(
        context: context, builder: (_) => const _ThemeDialog());
    if (mode != null) context.read(themeProvider).themePreference(mode);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        tooltip: 'Settings',
        icon: const Icon(Icons.more_vert_outlined),
        onPressed: () async {
          int selectedOption = await _selectedOption();
          if (!mounted) return;
          switch (selectedOption) {
            case 0:
              _postView();
              break;
            case 1:
              _themeDialog();
              break;
            case 2:
              Navigator.pushNamed(context, settingsRoute);
              break;
          }
        });
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.filter_list),
      onPressed: () => Scaffold.of(context).hasEndDrawer
          ? Scaffold.of(context).openEndDrawer()
          : Navigator.pushNamed(context, filterRoute),
      tooltip: 'Open filter menu',
    );
  }
}

class _ThemeDialog extends StatelessWidget {
  const _ThemeDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose Theme'),
      titlePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      actionsPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        child: Consumer(
          builder: (ctx, watch, _) {
            final ThemeMode mode = watch(_themeModeProvider).state;
            return Column(
              children: [
                RadioListTile(
                    value: ThemeMode.light,
                    groupValue: mode,
                    title: const Text('Light'),
                    onChanged: (value) =>
                        context.read(_themeModeProvider).state = value),
                RadioListTile(
                    value: ThemeMode.dark,
                    groupValue: mode,
                    title: const Text('Dark'),
                    onChanged: (value) =>
                        context.read(_themeModeProvider).state = value),
                RadioListTile(
                    value: ThemeMode.system,
                    groupValue: mode,
                    title: const Text('System default'),
                    onChanged: (value) =>
                        context.read(_themeModeProvider).state = value)
              ],
            );
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () => Navigator.of(context).pop<ThemeMode>(),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel)),
        TextButton(
            onPressed: () => Navigator.of(context)
                .pop<ThemeMode>(context.read(_themeModeProvider).state),
            child: Text(MaterialLocalizations.of(context).okButtonLabel)),
      ],
    );
  }
}
