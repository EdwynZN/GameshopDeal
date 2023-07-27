import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/provider/router_provider.dart';
import 'package:gameshop_deals/provider/theme_provider.dart';
import 'package:gameshop_deals/service/hive_init.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Logger extends ProviderObserver {
  @override
  void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
    print('disposed: ${provider.name}');
  }

  @override
  void didUpdateProvider(ProviderBase provider, Object? newValue, Object? old,
      ProviderContainer container) {
    print('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''');
  }

  @override
  void didAddProvider(
      ProviderBase provider, Object? value, ProviderContainer container) {
    print('''
    {
      "providerAdded": "${provider.name ?? provider.runtimeType}",
      "valueType": "${value.runtimeType}"
    }''');
    super.didAddProvider(provider, value, container);
  }
}

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  runApp(
    ProviderScope(
      //observers: [Logger()],
      child: const GameShop(),
    ),
  );
}

class GameShop extends ConsumerWidget {
  const GameShop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final themeNotifier = ref.watch(themeNotifierProvider);
    final router = ref.watch(routerProvider);
    return RefreshConfiguration(
      enableLoadingWhenFailed: false,
      headerBuilder: () => const WaterDropMaterialHeader(),
      //enableScrollWhenRefreshCompleted: true,
      child: MaterialApp.router(
        routerConfig: router,
        localizationsDelegates: [
          S.delegate,
          RefreshLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        darkTheme: themeNotifier.dark,
        theme: themeNotifier.light,
        themeMode: themeMode,
      ),
    );
  }
}
