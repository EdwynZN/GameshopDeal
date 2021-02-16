import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/riverpod/cache_manager_provider.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/riverpod/theme_provider.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';
import 'package:gameshop_deals/widget/dialog_preference_provider.dart';
import 'package:gameshop_deals/widget/preference/display_view.dart';
import 'package:gameshop_deals/widget/preference/webview.dart';
import 'package:hive/hive.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

final InAppReview _inAppReview = InAppReview.instance;

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final S translate = S.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(translate.settings),
        ),
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
                        const WebViewPreference(),
                        const DisplayPreference(),
                      ],
                    ),
                  ),
                  _CardSettings(
                    child: ListTile(
                      leading: const Icon(Icons.palette_outlined),
                      title: Text(translate.theme_title),
                      onTap: () async {
                        final S translate = S.of(context);
                        final ThemeMode mode = await showDialog<ThemeMode>(
                          context: context,
                          builder: (_) => PreferenceDialog<ThemeMode>(
                            title: translate.choose_theme,
                            provider: themeProvider,
                            values: ThemeMode.values,
                          ),
                        );
                        if (mode != null)
                          context.read(themeProvider).changeState(mode);
                      },
                    ),
                  ),
                  _CardSettings(
                    child: ListTile(
                      enabled: false,
                      leading: const Icon(Icons.notifications_on_outlined),
                      title: Text(translate.notifications),
                      subtitle: Text(translate.soon),
                    ),
                  ),
                  const _CardSettings(child: const _ClearCacheWidget()),
                  _CardSettings(
                    child: AboutListTile(
                      icon: const Icon(Icons.contact_support_outlined),
                      applicationIcon: CircleAvatar(
                        radius: IconTheme.of(context).size / 2,
                        backgroundColor: Colors.transparent,
                        backgroundImage:
                            const AssetImage('assets/thumbnails/icon_app.png'),
                      ),
                      aboutBoxChildren: [
                        TextButton.icon(
                          onPressed: () async {
                            final url =
                              Uri.https(githubUrl, projectPath + privacyPolicyPath);
                            await launch(url.toString());
                          },
                          icon: const Icon(Icons.privacy_tip_outlined),
                          label: Text(translate.privacy_policy),
                        ),
                        TextButton.icon(
                          onPressed: () async {
                            final url =
                              Uri.https(githubUrl, projectPath);
                            await launch(url.toString());
                          },
                          icon: const Icon(Icons.code_outlined),
                          label: Text('Github'),
                        ),
                        TextButton.icon(
                          onPressed: () async {
                            final url =
                              Uri.https(githubUrl, projectPath + issuesPath);
                            await launch(url.toString());
                          },
                          icon: const Icon(Icons.bug_report_outlined),
                          label: Text(translate.report_bug),
                        ),
                        TextButton.icon(
                          onPressed: () async {
                            if (await _inAppReview.isAvailable()) _inAppReview.requestReview();
                            else _inAppReview.openStoreListing();
                          },
                          icon: const Icon(Icons.star),
                          label: Text(translate.rate_me),
                        ),
                      ],
                      applicationName: 'Gameshop',
                    ),
                  ),
                ]),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  height: 0,
                  padding: EdgeInsets.all(12.0),
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
      subtitle: Text(translate.cache_subtitle),
      onTap: () async {
        final bool clear = await showDialog<bool>(
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
          final box = await Hive.openBox<String>(searchHistoryHiveBox);
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
