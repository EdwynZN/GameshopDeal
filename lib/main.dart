import 'package:flutter/material.dart';
import 'package:gameshop_deals/provider/theme_provider.dart';
import 'package:gameshop_deals/provider/deal_provider.dart';
import 'package:provider/provider.dart';
import 'package:gameshop_deals/screen/home_page.dart';
import 'package:flutter/services.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (BuildContext context) => ThemeProvider(theme['Theme']),
        ),
        Provider<DealProvider>(
          create: (_) => DealProvider(),
          dispose: (context, deal) => deal.dispose(),
          lazy: false,
        ),
        Provider<StoreProvider>(
          create: (_) => StoreProvider(),
        ),
        Consumer<ThemeProvider>(
          builder: (BuildContext context, ThemeProvider themeData, child){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: Themes.light,
              darkTheme: Themes.dark,
              themeMode: themeData.preferredTheme,
              home: Builder(
                builder: (BuildContext context){
                  return AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle(
                      statusBarColor: Theme.of(context).primaryColor,
                      systemNavigationBarColor: Theme.of(context).primaryColor
                    ),
                    child: child,
                  );
                }
              )
            );
          },
        )
      ],
      child: MyHomePage(),
    );
  }
}
