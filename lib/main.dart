import 'package:flutter/material.dart';
import 'package:gameshop_deals/widget/route_transitions.dart';
import 'package:gameshop_deals/utils/routes_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/theme_provider.dart';
import 'package:gameshop_deals/riverpod/shared_preference_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(
      // observers: [Logger()],
      overrides: [
        sharedPreferencesProvider.overrideWithValue(preferences),
      ],
      child: const GameShop()
    )
  );
}

class GameShop extends ConsumerWidget {
  const GameShop();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final themeMode = watch(themeProvider.state);
    final themeData = watch(themeProvider);
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
  }
}