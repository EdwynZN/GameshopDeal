// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Rate me`
  String get rate_me {
    return Intl.message(
      'Rate me',
      name: 'rate_me',
      desc: 'Rate Gameshop Deal in AppStore / Play Store',
      args: [],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message(
      'Refresh',
      name: 'refresh',
      desc: 'Refresh current deals',
      args: [],
    );
  }

  /// `Send feedback`
  String get feedback {
    return Intl.message(
      'Send feedback',
      name: 'feedback',
      desc: 'Send feedback',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: 'Help',
      args: [],
    );
  }

  /// `Deal view`
  String get deal_view {
    return Intl.message(
      'Deal view',
      name: 'deal_view',
      desc: 'Deal view',
      args: [],
    );
  }

  /// `{view, select, List {List} Grid {Grid} Detail {Detail} Compact {Compact} Swipe {Swipe} other {List}}`
  String choose_deal_view(Object view) {
    return Intl.select(
      view,
      {
        'List': 'List',
        'Grid': 'Grid',
        'Detail': 'Detail',
        'Compact': 'Compact',
        'Swipe': 'Swipe',
        'other': 'List',
      },
      name: 'choose_deal_view',
      desc: 'DealView enum',
      args: [view],
    );
  }

  /// `Sort By`
  String get sortBy {
    return Intl.message(
      'Sort By',
      name: 'sortBy',
      desc: 'Sort By',
      args: [],
    );
  }

  /// `{sort, select, Deal_Rating {On a scale from 0 to 10, it factors in price, percent off, metacritic, release date, price history, etc} Title {Title} Savings {Savings} Price {Price} Metacritic {Metacritic} Reviews {Reviews} Release {Release} Store {Store} Recent {How recently a deal was found} other {On a scale from 0 to 10, it factors in price, percent off, metacritic, release date, price history, etc}}`
  String sort_tooltip(Object sort) {
    return Intl.select(
      sort,
      {
        'Deal_Rating': 'On a scale from 0 to 10, it factors in price, percent off, metacritic, release date, price history, etc',
        'Title': 'Title',
        'Savings': 'Savings',
        'Price': 'Price',
        'Metacritic': 'Metacritic',
        'Reviews': 'Reviews',
        'Release': 'Release',
        'Store': 'Store',
        'Recent': 'How recently a deal was found',
        'other': 'On a scale from 0 to 10, it factors in price, percent off, metacritic, release date, price history, etc',
      },
      name: 'sort_tooltip',
      desc: 'SortBy tooltip, useful to explain how deal rating works',
      args: [sort],
    );
  }

  /// `{sort, select, Deal_Rating {Deal Rating} Title {Title} Savings {Savings} Price {Price} Metacritic {Metacritic} Reviews {Reviews} Release {Release} Store {Store} Recent {Recent} other {Deal Rating}}`
  String sort(Object sort) {
    return Intl.select(
      sort,
      {
        'Deal_Rating': 'Deal Rating',
        'Title': 'Title',
        'Savings': 'Savings',
        'Price': 'Price',
        'Metacritic': 'Metacritic',
        'Reviews': 'Reviews',
        'Release': 'Release',
        'Store': 'Store',
        'Recent': 'Recent',
        'other': 'Deal Rating',
      },
      name: 'sort',
      desc: 'SortBy enum',
      args: [sort],
    );
  }

  /// `Choose theme`
  String get choose_theme {
    return Intl.message(
      'Choose theme',
      name: 'choose_theme',
      desc: 'Choose theme',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: 'Light Theme',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: 'Dark Theme',
      args: [],
    );
  }

  /// `System`
  String get system {
    return Intl.message(
      'System',
      name: 'system',
      desc: 'System Default Theme',
      args: [],
    );
  }

  /// `{mode, select, system {System} light {Light} dark {Dark} other {System}}`
  String themeMode(Object mode) {
    return Intl.select(
      mode,
      {
        'system': 'System',
        'light': 'Light',
        'dark': 'Dark',
        'other': 'System',
      },
      name: 'themeMode',
      desc: 'ThemeMode enum',
      args: [mode],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: 'settings option',
      args: [],
    );
  }

  /// `Open filter menu`
  String get filter_tooltip {
    return Intl.message(
      'Open filter menu',
      name: 'filter_tooltip',
      desc: 'filter menu tooltip',
      args: [],
    );
  }

  /// `Filters`
  String get filter {
    return Intl.message(
      'Filters',
      name: 'filter',
      desc: 'Filter text',
      args: [],
    );
  }

  /// `Restart`
  String get restart_tooltip {
    return Intl.message(
      'Restart',
      name: 'restart_tooltip',
      desc: 'Tooltip indiciating the restart of the filter to the default values',
      args: [],
    );
  }

  /// `Up`
  String get up_tooltip {
    return Intl.message(
      'Up',
      name: 'up_tooltip',
      desc: 'button to go to the beginning of the list',
      args: [],
    );
  }

  /// `First`
  String get first_tooltip {
    return Intl.message(
      'First',
      name: 'first_tooltip',
      desc: 'button to go to the beginning of the list',
      args: [],
    );
  }

  /// `Last`
  String get last_tooltip {
    return Intl.message(
      'Last',
      name: 'last_tooltip',
      desc: 'button to go to the last deal of the list',
      args: [],
    );
  }

  /// `Price Range`
  String get price_range {
    return Intl.message(
      'Price Range',
      name: 'price_range',
      desc: 'Price Range Slider title',
      args: [],
    );
  }

  /// `{money, plural, zero{free} one{1 dollar} other{{money} dollars}}`
  String dollar_currency(num money) {
    return Intl.plural(
      money,
      zero: 'free',
      one: '1 dollar',
      other: '$money dollars',
      name: 'dollar_currency',
      desc: 'dollar currency',
      args: [money],
    );
  }

  /// `Steam Rating`
  String get steam_rating {
    return Intl.message(
      'Steam Rating',
      name: 'steam_rating',
      desc: 'Steam Rating title',
      args: [],
    );
  }

  /// `Stores`
  String get stores {
    return Intl.message(
      'Stores',
      name: 'stores',
      desc: 'Stores title',
      args: [],
    );
  }

  /// `All Stores`
  String get all_stores_tooltip {
    return Intl.message(
      'All Stores',
      name: 'all_stores_tooltip',
      desc: 'tooltip for all stores chip',
      args: [],
    );
  }

  /// `All`
  String get all_choice {
    return Intl.message(
      'All',
      name: 'all_choice',
      desc: 'text to apply for the chip that selects all',
      args: [],
    );
  }

  /// `Apply`
  String get apply_filter {
    return Intl.message(
      'Apply',
      name: 'apply_filter',
      desc: 'Apply button to save filter changes',
      args: [],
    );
  }

  /// `On sale`
  String get on_sale {
    return Intl.message(
      'On sale',
      name: 'on_sale',
      desc: 'On sale title',
      args: [],
    );
  }

  /// `On sale`
  String get on_sale_tooltip {
    return Intl.message(
      'On sale',
      name: 'on_sale_tooltip',
      desc: 'On sale tooltip',
      args: [],
    );
  }

  /// `Retail discount`
  String get retail_discount {
    return Intl.message(
      'Retail discount',
      name: 'retail_discount',
      desc: 'Retail discount title',
      args: [],
    );
  }

  /// `Games with a current retail price <$29`
  String get retail_discount_tooltip {
    return Intl.message(
      'Games with a current retail price <\$29',
      name: 'retail_discount_tooltip',
      desc: 'Games that are already discounted at local stores',
      args: [],
    );
  }

  /// `SteamWorks`
  String get steamworks {
    return Intl.message(
      'SteamWorks',
      name: 'steamworks',
      desc: 'Steamworks title, that means games that are in the steam store',
      args: [],
    );
  }

  /// `Games registered in Steam, regardless the store`
  String get steamworks_tooltip {
    return Intl.message(
      'Games registered in Steam, regardless the store',
      name: 'steamworks_tooltip',
      desc: 'Games that are in the Steam Store',
      args: [],
    );
  }

  /// `Any score`
  String get any_metacritic {
    return Intl.message(
      'Any score',
      name: 'any_metacritic',
      desc: 'Any score',
      args: [],
    );
  }

  /// `Any`
  String get any_rating {
    return Intl.message(
      'Any',
      name: 'any_rating',
      desc: 'Any rating',
      args: [],
    );
  }

  /// `Ascending (A-Z)`
  String get ascending {
    return Intl.message(
      'Ascending (A-Z)',
      name: 'ascending',
      desc: 'Ascending order',
      args: [],
    );
  }

  /// `Descending (Z-A)`
  String get descending {
    return Intl.message(
      'Descending (Z-A)',
      name: 'descending',
      desc: 'Descending order',
      args: [],
    );
  }

  /// `{review, select, Overwhelmingly_Negative {Overwhelmingly Negative} Very_Negative {Very Negative} Negative {Negative} Mostly_Negative {Mostly Negative} Mixed {Mixed} Mostly_Positive {Mostly Positive} Positive {Positive} Very_Positive {Very Positive} Overwhelmingly_Positive {Overwhelmingly Positive} other {Unknown}}`
  String review(Object review) {
    return Intl.select(
      review,
      {
        'Overwhelmingly_Negative': 'Overwhelmingly Negative',
        'Very_Negative': 'Very Negative',
        'Negative': 'Negative',
        'Mostly_Negative': 'Mostly Negative',
        'Mixed': 'Mixed',
        'Mostly_Positive': 'Mostly Positive',
        'Positive': 'Positive',
        'Very_Positive': 'Very Positive',
        'Overwhelmingly_Positive': 'Overwhelmingly Positive',
        'other': 'Unknown',
      },
      name: 'review',
      desc: 'String representing the reviews of the game',
      args: [review],
    );
  }

  /// `Review`
  String get review_tooltip {
    return Intl.message(
      'Review',
      name: 'review_tooltip',
      desc: 'Review title to display in a button',
      args: [],
    );
  }

  /// `N/A`
  String get no_score {
    return Intl.message(
      'N/A',
      name: 'no_score',
      desc: 'no score available, so \'N/A\' is displayed',
      args: [],
    );
  }

  /// `N/A`
  String get no_date {
    return Intl.message(
      'N/A',
      name: 'no_date',
      desc: 'no release date, so \'to be released\' is displayed',
      args: [],
    );
  }

  /// `Releases: {date}`
  String future_release(Object date) {
    return Intl.message(
      'Releases: $date',
      name: 'future_release',
      desc: 'displays the date when it will be released',
      args: [date],
    );
  }

  /// `Released on: {date}`
  String release(Object date) {
    return Intl.message(
      'Released on: $date',
      name: 'release',
      desc: 'displays the date when it is released',
      args: [date],
    );
  }

  /// `{change}y ago`
  String change_in_years(Object change) {
    return Intl.message(
      '${change}y ago',
      name: 'change_in_years',
      desc: 'last time a date changed in years',
      args: [change],
    );
  }

  /// `{change}mo ago`
  String change_in_months(Object change) {
    return Intl.message(
      '${change}mo ago',
      name: 'change_in_months',
      desc: 'last time a date changed in months',
      args: [change],
    );
  }

  /// `{change}d ago`
  String change_in_days(Object change) {
    return Intl.message(
      '${change}d ago',
      name: 'change_in_days',
      desc: 'last time a date changed in days',
      args: [change],
    );
  }

  /// `{change}h ago`
  String change_in_hours(Object change) {
    return Intl.message(
      '${change}h ago',
      name: 'change_in_hours',
      desc: 'last time a date changed in hours',
      args: [change],
    );
  }

  /// `{change}m ago`
  String change_in_minutes(Object change) {
    return Intl.message(
      '${change}m ago',
      name: 'change_in_minutes',
      desc: 'last time a date changed in minutes',
      args: [change],
    );
  }

  /// `now`
  String get now {
    return Intl.message(
      'now',
      name: 'now',
      desc: 'now or less than a minute since last change',
      args: [],
    );
  }

  /// `Clear cache`
  String get cache_title {
    return Intl.message(
      'Clear cache',
      name: 'cache_title',
      desc: 'clear cache',
      args: [],
    );
  }

  /// `Are you sure?`
  String get cache_dialog_title {
    return Intl.message(
      'Are you sure?',
      name: 'cache_dialog_title',
      desc: 'dialog asking if the user is sure to delete the cache',
      args: [],
    );
  }

  /// `This action can't be undone`
  String get cache_dialog_content {
    return Intl.message(
      'This action can\'t be undone',
      name: 'cache_dialog_content',
      desc: 'content dialog describing the action cannot be undone',
      args: [],
    );
  }

  /// `Cache cleared`
  String get cache_snackbar_cleared {
    return Intl.message(
      'Cache cleared',
      name: 'cache_snackbar_cleared',
      desc: 'cache has been deleted from the disk',
      args: [],
    );
  }

  /// `Clear`
  String get clear_tooltip {
    return Intl.message(
      'Clear',
      name: 'clear_tooltip',
      desc: 'Clear',
      args: [],
    );
  }

  /// `Recent searches`
  String get recent_searches {
    return Intl.message(
      'Recent searches',
      name: 'recent_searches',
      desc: 'Recent searches',
      args: [],
    );
  }

  /// `Suggested searches`
  String get suggested_searches {
    return Intl.message(
      'Suggested searches',
      name: 'suggested_searches',
      desc: 'Suggested searches',
      args: [],
    );
  }

  /// `Search for '{query}'`
  String title_search(Object query) {
    return Intl.message(
      'Search for \'$query\'',
      name: 'title_search',
      desc: 'Search by name',
      args: [query],
    );
  }

  /// `Save Deal`
  String get save_deal {
    return Intl.message(
      'Save Deal',
      name: 'save_deal',
      desc: 'Save Deal text button',
      args: [],
    );
  }

  /// `Go to Deal`
  String get go_to_deal {
    return Intl.message(
      'Go to Deal',
      name: 'go_to_deal',
      desc: 'Go to Deal text button',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}