import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/cache_manager_provider.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate.fixed([
                const _CardSettings(
                    child: ListTile(
                  leading: const Icon(Icons.settings_applications_outlined),
                  title: const Text('General'),
                )),
                const _CardSettings(
                    child: ListTile(
                  leading: const Icon(Icons.palette_outlined),
                  title: const Text('Themes'),
                )),
                const _CardSettings(
                    child: ListTile(
                  leading: const Icon(Icons.notifications_on_outlined),
                  title: const Text('Notifications'),
                )),
                const _CardSettings(child: const _ClearCacheWidget()),
                const _CardSettings(
                    child: ListTile(
                  leading: const Icon(Icons.contact_support_outlined),
                  title: const Text('About'),
                )),
              ]),
            ),
            const SliverFillRemaining(
              hasScrollBody: false,
              child: SizedBox(height: 0, child: FlutterLogo()),
            )
          ],
        ),
      ),
    );
  }
}

class _ClearCacheWidget extends StatelessWidget {
  const _ClearCacheWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final S translate = S.of(context);
    return ListTile(
      leading: const Icon(Icons.delete_outline_outlined),
      title: Text(translate.cache_title),
      onTap: () async {
        bool clear = await showDialog<bool>(
          context: context,
          child: AlertDialog(
            title: Text(translate.cache_dialog_title),
            content: Text(translate.cache_dialog_content),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                    MaterialLocalizations.of(context).cancelButtonLabel),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(MaterialLocalizations.of(context).okButtonLabel),
              ),
            ],
          ),
        );
        if (clear ?? false) {
          ScaffoldState scaffold = Scaffold.of(context, nullOk: true);
          await context
            .read(cacheManagerFamilyProvider(cacheKeyDeals))
            .emptyCache();
          await context
            .read(cacheManagerFamilyProvider(cacheKeyStores))
            .emptyCache();
          if (scaffold?.mounted ?? false) {
            scaffold?.hideCurrentSnackBar();
            scaffold
              ?.showSnackBar(SnackBar(content: Text(translate.cache_snackbar_cleared)));
          }
        }
      },
    );
  }
}

class _CardSettings extends StatelessWidget {
  final Widget child;

  const _CardSettings({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTileTheme(
        iconColor: Theme.of(context).iconTheme.color,
        textColor: Theme.of(context).textTheme.bodyText2.color,
        dense: true,
        child: Material(
          color: Colors.transparent,
          shape: Theme.of(context).cardTheme.shape,
          clipBehavior: Clip.hardEdge,
          child: child,
        ),
      ),
    );
  }
}
