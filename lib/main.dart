import 'package:flutter/material.dart';
import 'package:gameshop_deals/provider/filter_provider.dart';
import 'package:gameshop_deals/provider/theme_provider.dart';
import 'package:gameshop_deals/provider/deal_provider.dart';
import 'package:provider/provider.dart';
import 'package:gameshop_deals/widget/route_transitions.dart';
import 'package:gameshop_deals/utils/routes_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<String,dynamic> savedTheme = await getTheme();

  runApp(GameShop(savedTheme));
}

class GameShop extends StatelessWidget {
  final Map<String,dynamic> theme;
  GameShop(this.theme);

  @override
  Widget build(BuildContext context) {
    BottomNavigationBar(items: null);
    return MultiProvider(
      providers: [
        Provider<DealProvider>(
          create: (_) => DealProvider(),
          dispose: (context, deal) => deal.dispose(),
          lazy: true,
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(theme['Theme']),
        ),
      ],
      builder: (context, _){
        final ThemeProvider themeData = context.watch<ThemeProvider>();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: themeData.theme.dark,
          theme: themeData.theme.light,
          //theme: Themes.light,
          //darkTheme: Themes.dark,
          themeMode: themeData.preferredTheme,
          onGenerateRoute: Routes.getRoute,
          initialRoute: homeRoute,
        );
      },
    );
  }
}