import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/cache_manager_provider.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';
import 'package:hive/hive.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
          ),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate.fixed([
                  _CardSettings(
                    child: ExpansionTile(
                      leading: const Icon(Icons.settings_applications_outlined),
                      title: const Text('General'),
                      children: [
                        for (int i = 0; i < 15; i++)
                          CheckboxListTile(
                            dense: true,
                            value: true,
                            onChanged: print,
                            title: const Text('General'),
                          ),
                      ],
                    ),
                  ),
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
                  _CardSettings(
                    child: AboutListTile(
                      icon: const Icon(Icons.contact_support_outlined),
                      applicationIcon: CircleAvatar(
                        radius: IconTheme.of(context).size / 2,
                        backgroundColor: Colors.transparent,
                        backgroundImage: const AssetImage('assets/thumbnails/icon_app.png'),
                      ),
                      aboutBoxChildren: [
                        TextButton.icon(
                          onPressed: () => print('hey'),
                          icon: const Icon(Icons.privacy_tip_outlined),
                          label: Text('Privacy Policy'),
                        ),
                        TextButton.icon(
                          onPressed: () => print('hey'),
                          icon: const Icon(Icons.code_outlined),
                          label: Text('Github Code'),
                        ),
                      ],
                      applicationName: 'Gameshop',
                    ),
                  ),
                ]),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: SizedBox(
                  height: 0, 
                  child: Image.asset('assets/thumbnails/icon_app.png'),
                ),
              ),
            ],
          ),
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
          child: const _CacheDialog(),
        );
        if (clear ?? false) {
          ScaffoldState scaffold = Scaffold.of(context, nullOk: true);
          await context
              .read(cacheManagerFamilyProvider(cacheKeyDeals))
              .emptyCache();
          await context
              .read(cacheManagerFamilyProvider(cacheKeyStores))
              .emptyCache();
          final box = await Hive.openBox<String>(searchHistoryKey);
          if (box.isOpen && box.isNotEmpty) await box.clear();
          if (scaffold?.mounted ?? false) {
            scaffold?.hideCurrentSnackBar();
            scaffold?.showSnackBar(
                SnackBar(content: Text(translate.cache_snackbar_cleared)));
          }
        }
      },
    );
  }
}

class _CacheDialog extends StatelessWidget {
  const _CacheDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final S translate = S.of(context);
    return AlertDialog(
      title: Text(translate.cache_dialog_title),
      content: Text(translate.cache_dialog_content),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(MaterialLocalizations.of(context).okButtonLabel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
        ),
      ],
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
