import 'package:flutter/material.dart';
//import 'package:gameshop_deals/provider/theme_provider.dart';
//import 'package:gameshop_deals/provider/deal_provider.dart';
//import 'package:provider/provider.dart';
import 'package:gameshop_deals/widget/route_transitions.dart';
import 'package:gameshop_deals/utils/routes_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/theme_provider.dart';

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase provider, Object newValue) {
    print('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''');
  }

  @override
  void mayHaveChanged(ProviderBase provider) {
    print('''
      {
        "provider changed": "${provider.name ?? provider.runtimeType}",
      }''');
    super.mayHaveChanged(provider);
  }

  @override
  void didAddProvider(ProviderBase provider, Object value) {
    print('''
    {
      "providerAdded": "${provider.name ?? provider.runtimeType}",
      "valueType": "${value.runtimeType}"
    }''');
    super.didAddProvider(provider, value);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<String,dynamic> savedTheme = await getTheme();
  //runApp(GameShop(savedTheme));
  runApp(
    ProviderScope(
      // observers: [Logger()],
      overrides: [
        themeModeState.overrideWithValue(
          ThemeNotifier(ThemeMode.values[savedTheme['Theme']])
        ),
      ],
      child: const GameShop()
    )
  );
}

class GameShop extends ConsumerWidget {
  const GameShop();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    //final ThemeProvider themeData = watch(themeProvider(theme['Theme'])).state;
    // final family = watch(themeFamilyModeState(ThemeMode.light));
    final themeMode = watch(themeModeState.state);
    final themeData = watch(themeModeState);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: themeData.darkTheme,
      theme: themeData.lightTheme,
      // theme: ThemeData.light(),
      // darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      onGenerateRoute: Routes.getRoute,
      initialRoute: homeRoute,
    );
    /*return MultiProvider(
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
    );*/
  }
}