// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(change) => "${change}d ago";

  static m1(change) => "${change}h ago";

  static m2(change) => "${change}m ago";

  static m3(change) => "${change}mo ago";

  static m4(change) => "${change}y ago";

  static m5(view) => "${Intl.select(view, {'List': 'List', 'Detail': 'Detail', 'Compact': 'Compact', 'Swipe': 'Swipe', 'other': 'List', })}";

  static m6(money) => "${Intl.plural(money, zero: 'free', one: '1 dollar', many: '${money} dollars')}";

  static m7(date) => "Released on: ${date}";

  static m8(sort) => "${Intl.select(sort, {'Deal_Rating': 'Deal Rating', 'Title': 'Title', 'Savings': 'Savings', 'Price': 'Price', 'Metacritic': 'Metacritic', 'Reviews': 'Reviews', 'Release': 'Release', 'Store': 'Store', 'Recent': 'Recent', 'other': 'Deal Rating', })}";

  static m9(sort) => "${Intl.select(sort, {'Deal_Rating': 'On a scale from 0 to 10, it factors in price, percent off, metacritic, release date, price history, etc', 'Title': 'Title', 'Savings': 'Savings', 'Price': 'Price', 'Metacritic': 'Metacritic', 'Reviews': 'Reviews', 'Release': 'Release', 'Store': 'Store', 'Recent': 'How recently a deal was found', 'other': 'On a scale from 0 to 10, it factors in price, percent off, metacritic, release date, price history, etc', })}";

  static m10(mode) => "${Intl.select(mode, {'system': 'System', 'light': 'Light', 'dark': 'Dark', 'other': 'System', })}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "all_choice" : MessageLookupByLibrary.simpleMessage("All"),
    "all_stores_tooltip" : MessageLookupByLibrary.simpleMessage("All Stores"),
    "any_metacritic" : MessageLookupByLibrary.simpleMessage("Any score"),
    "any_rating" : MessageLookupByLibrary.simpleMessage("Any"),
    "apply_filter" : MessageLookupByLibrary.simpleMessage("Apply"),
    "ascending" : MessageLookupByLibrary.simpleMessage("Ascending (A-Z)"),
    "cache_dialog_content" : MessageLookupByLibrary.simpleMessage("This action can\'t be undone"),
    "cache_dialog_title" : MessageLookupByLibrary.simpleMessage("Are you sure?"),
    "cache_snackbar_cleared" : MessageLookupByLibrary.simpleMessage("Cache cleared"),
    "cache_title" : MessageLookupByLibrary.simpleMessage("Clear cache"),
    "change_in_days" : m0,
    "change_in_hours" : m1,
    "change_in_minutes" : m2,
    "change_in_months" : m3,
    "change_in_years" : m4,
    "choose_deal_view" : m5,
    "choose_theme" : MessageLookupByLibrary.simpleMessage("Choose theme"),
    "dark" : MessageLookupByLibrary.simpleMessage("Dark"),
    "deal_view" : MessageLookupByLibrary.simpleMessage("Deal view"),
    "descending" : MessageLookupByLibrary.simpleMessage("Descending (Z-A)"),
    "dollar_currency" : m6,
    "feedback" : MessageLookupByLibrary.simpleMessage("Send feedback"),
    "filter" : MessageLookupByLibrary.simpleMessage("Filters"),
    "filter_tooltip" : MessageLookupByLibrary.simpleMessage("Open filter menu"),
    "help" : MessageLookupByLibrary.simpleMessage("Help"),
    "light" : MessageLookupByLibrary.simpleMessage("Light"),
    "no_date" : MessageLookupByLibrary.simpleMessage("To be released"),
    "now" : MessageLookupByLibrary.simpleMessage("now"),
    "on_sale" : MessageLookupByLibrary.simpleMessage("On sale"),
    "on_sale_tooltip" : MessageLookupByLibrary.simpleMessage("On sale"),
    "price_range" : MessageLookupByLibrary.simpleMessage("Price Range"),
    "release" : m7,
    "restart_tooltip" : MessageLookupByLibrary.simpleMessage("Restart"),
    "retail_discount" : MessageLookupByLibrary.simpleMessage("Retail discount"),
    "retail_discount_tooltip" : MessageLookupByLibrary.simpleMessage("Games with a current retail price <\$29"),
    "search_tooltip" : MessageLookupByLibrary.simpleMessage("Search"),
    "settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "sort" : m8,
    "sortBy" : MessageLookupByLibrary.simpleMessage("Sort By"),
    "sort_tooltip" : m9,
    "steam_rating" : MessageLookupByLibrary.simpleMessage("Steam Rating"),
    "steamworks" : MessageLookupByLibrary.simpleMessage("SteamWorks"),
    "steamworks_tooltip" : MessageLookupByLibrary.simpleMessage("Games registered in Steam, regardless the store"),
    "stores" : MessageLookupByLibrary.simpleMessage("Stores"),
    "system" : MessageLookupByLibrary.simpleMessage("System"),
    "themeMode" : m10,
    "up_tooltip" : MessageLookupByLibrary.simpleMessage("Up")
  };
}
