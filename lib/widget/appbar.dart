import 'package:flutter/material.dart';
import 'package:gameshop_deals/riverpod/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/utils/routes_constants.dart';

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

class HomeAppBar extends StatelessWidget{
  const HomeAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      // snap: true, floating: true,
      pinned: true, primary: true,
      automaticallyImplyLeading: false,
      title: const Text('Gameshop'),
      actions: <Widget>[
        const _Settings(),
        const _ThemeButton(),
        const _FilterButton(),
        const SizedBox(width: 10)
      ],
    );
  }
}

class _Settings extends StatelessWidget {
  const _Settings({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Settings',
      icon: const Icon(Icons.settings),
      onPressed: () => Navigator.pushNamed(context, settingsRoute)
    );
  }
}

class _ThemeButton extends StatelessWidget {
  const _ThemeButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Change Theme',
      icon: const Icon(Icons.brightness_low),
      onPressed: () async {
        await context.read(themeModeState).toggleMode();
      }
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.filter_list),
      onPressed: () => Scaffold.of(context).hasEndDrawer ?
      Scaffold.of(context).openEndDrawer() : Navigator.pushNamed(context, filterRoute),
      tooltip: 'Open filter menu',
    );
  }
}