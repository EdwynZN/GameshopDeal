import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gameshop_deals/presentation/widgets/preference_dialog.dart';
import 'package:gameshop_deals/presentation/widgets/preferences/display_view.dart';
import 'package:gameshop_deals/presentation/widgets/preferences/webview.dart';
import 'package:gameshop_deals/provider/cache_manager_provider.dart';
import 'package:gameshop_deals/provider/info_provider.dart';
import 'package:gameshop_deals/provider/theme_provider.dart';
import 'package:gameshop_deals/generated/l10n.dart';
import 'package:gameshop_deals/utils/constraints.dart';
import 'package:gameshop_deals/utils/preferences_constants.dart';
import 'package:hive/hive.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

final InAppReview _inAppReview = InAppReview.instance;

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final S translate = S.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(translate.settings)),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: _SettingsCard(
                title: 'General',
                tiles: [
                  WebViewPreference(),
                  DisplayPreference(),
                  _ThemeListTile(),
                  _ClearCacheWidget(),
                ],
              ),
            ),
          ),
          const SliverFillRemaining(
            fillOverscroll: false,
            hasScrollBody: false,
            child: SafeArea(
              bottom: true,
              minimum: EdgeInsets.only(bottom: 24.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: _VersionCard(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemeListTile extends ConsumerWidget {
  // ignore: unused_element
  const _ThemeListTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translate = S.of(context);
    return ListTile(
      leading: const Icon(Icons.palette_outlined),
      title: Text(translate.theme_title),
      subtitle: Text(translate.themeMode(ref.watch(themeModeProvider))),
      onTap: () async {
        final ThemeMode? mode = await showDialog<ThemeMode>(
          context: context,
          builder: (context) {
            final S translate = S.of(context);
            return PreferenceDialog<ThemeMode>(
              title: translate.choose_theme,
              provider: themeModeProvider,
              values: ThemeMode.values,
            );
          },
        );
        if (mode != null) {
          ref.read(themeModeProvider.notifier).changeState(mode);
        }
      },
    );
  }
}

class _VersionCard extends StatelessWidget {
  // ignore: unused_element
  const _VersionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final translate = S.of(context);
    return _SettingsCard(
      title: translate.about,
      tiles: [
        AboutListTile(
          icon: const Icon(Icons.contact_support_outlined),
          applicationIcon: CircleAvatar(
            radius: (IconTheme.of(context).size ?? 24.0) / 2,
            backgroundColor: Colors.transparent,
            backgroundImage: const AssetImage('assets/thumbnails/icon_app.png'),
          ),
          aboutBoxChildren: [
            TextButton.icon(
              onPressed: () async {
                final url =
                    Uri.https(githubUrl, projectPath + privacyPolicyPath);
                await launchUrl(url);
              },
              icon: const Icon(Icons.privacy_tip_outlined),
              label: Text(translate.privacy_policy),
            ),
            TextButton.icon(
              onPressed: () async {
                final url = Uri.https(githubUrl, projectPath);
                await launchUrl(url);
              },
              icon: const Icon(Icons.code_outlined),
              label: Text('Github'),
            ),
            TextButton.icon(
              onPressed: () async {
                final url = Uri.https(githubUrl, projectPath + issuesPath);
                await launchUrl(url);
              },
              icon: const Icon(Icons.bug_report_outlined),
              label: Text(translate.report_bug),
            ),
            TextButton.icon(
              onPressed: () async {
                if (await _inAppReview.isAvailable())
                  _inAppReview.requestReview();
                else
                  _inAppReview.openStoreListing();
              },
              icon: const Icon(Icons.star),
              label: Text(translate.rate_me),
            ),
            TextButton.icon(
              onPressed: () async {
                final url = Uri.https('www.cheapshark.com', '');
                await launchUrl(url);
              },
              icon: const Icon(Icons.gamepad_rounded),
              label: Text('CheapShark'),
            ),
          ],
          applicationName: 'Gameshop',
        ),
        gap8,
        Center(
          child: Consumer(
            builder: (context, ref, child) {
              final version = ref.watch(infoProvider
                .select((info) => info.version),
              );
              final versionStyle = TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16.0,
                height: 1.3,
                color: colorScheme.outline,
              );
              return Text('Version $version', style: versionStyle);
            },
          ),
        ),
      ],
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final String title;
  final List<Widget> tiles;

  // ignore: unused_element
  const _SettingsCard({super.key, required this.title, this.tiles = const []});

  @override
  Widget build(BuildContext context) {
    final boldTitle = Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 16.0, 8.0),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
          letterSpacing: -0.5,
          height: 1.3,
        ),
      ),
    );
    return Card(
      elevation: 4.0,
      shadowColor: Colors.black12,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 400.0, maxWidth: 460.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              boldTitle,
              ...tiles,
            ],
          ),
        ),
      ),
    );
  }
}

class _ClearCacheWidget extends ConsumerWidget {
  const _ClearCacheWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final S translate = S.of(context);
    return ListTile(
      leading: const Icon(Icons.delete_outline_outlined),
      title: Text(translate.cache_title),
      subtitle: Text(
        translate.cache_subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () async {
        final bool? clear = await showDialog<bool>(
          context: context,
          builder: (_) => const _CacheDialog(),
        );
        if (clear ?? false) {
          ScaffoldMessengerState? scaffold = ScaffoldMessenger.maybeOf(context);
          await ref
              .read(cacheManagerProvider(cacheKey: cacheKeyDeals))
              .emptyCache();
          await ref
              .read(cacheManagerProvider(cacheKey: cacheKeyStores))
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
  const _CacheDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    final S translate = S.of(context);
    return AlertDialog(
      title: Text(translate.cache_dialog_title),
      content: Text(translate.cache_dialog_content),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(localizations.cancelButtonLabel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(localizations.okButtonLabel),
        ),
      ],
    );
  }
}
