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

  static m5(view) => "${Intl.select(view, {'List': 'List', 'Grid': 'Grid', 'Detail': 'Detail', 'Compact': 'Compact', 'Swipe': 'Swipe', 'other': 'List', })}";

  static m6(money) => "${Intl.plural(money, zero: 'free', one: '1 dollar', other: '${money} dollars')}";

  static m7(date) => "Releases: ${date}";

  static m8(date) => "Released on: ${date}";

  static m9(review) => "${Intl.select(review, {'Overwhelmingly_Negative': 'Overwhelmingly Negative', 'Very_Negative': 'Very Negative', 'Negative': 'Negative', 'Mostly_Negative': 'Mostly Negative', 'Mixed': 'Mixed', 'Mostly_Positive': 'Mostly Positive', 'Positive': 'Positive', 'Very_Positive': 'Very Positive', 'Overwhelmingly_Positive': 'Overwhelmingly Positive', 'other': 'Unknown', })}";

  static m10(sort) => "${Intl.select(sort, {'Deal_Rating': 'Deal Rating', 'Title': 'Title', 'Savings': 'Savings', 'Price': 'Price', 'Metacritic': 'Metacritic', 'Reviews': 'Reviews', 'Release': 'Release', 'Store': 'Store', 'Recent': 'Recent', 'other': 'Deal Rating', })}";

  static m11(sort) => "${Intl.select(sort, {'Deal_Rating': 'On a scale from 0 to 10, it factors in price, percent off, metacritic, release date, price history, etc', 'Title': 'Title', 'Savings': 'Savings', 'Price': 'Price', 'Metacritic': 'Metacritic', 'Reviews': 'Reviews', 'Release': 'Release', 'Store': 'Store', 'Recent': 'How recently a deal was found', 'other': 'On a scale from 0 to 10, it factors in price, percent off, metacritic, release date, price history, etc', })}";

  static m12(mode) => "${Intl.select(mode, {'system': 'System', 'light': 'Light', 'dark': 'Dark', 'other': 'System', })}";

  static m13(query) => "Search for \'${query}\'";

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
    "clear_tooltip" : MessageLookupByLibrary.simpleMessage("Clear"),
    "dark" : MessageLookupByLibrary.simpleMessage("Dark"),
    "deal_view" : MessageLookupByLibrary.simpleMessage("Deal view"),
    "descending" : MessageLookupByLibrary.simpleMessage("Descending (Z-A)"),
    "dollar_currency" : m6,
    "feedback" : MessageLookupByLibrary.simpleMessage("Send feedback"),
    "filter" : MessageLookupByLibrary.simpleMessage("Filters"),
    "filter_tooltip" : MessageLookupByLibrary.simpleMessage("Open filter menu"),
    "future_release" : m7,
    "go_to_deal" : MessageLookupByLibrary.simpleMessage("Go to Deal"),
    "help" : MessageLookupByLibrary.simpleMessage("Help"),
    "light" : MessageLookupByLibrary.simpleMessage("Light"),
    "no_date" : MessageLookupByLibrary.simpleMessage("N/A"),
    "now" : MessageLookupByLibrary.simpleMessage("now"),
    "on_sale" : MessageLookupByLibrary.simpleMessage("On sale"),
    "on_sale_tooltip" : MessageLookupByLibrary.simpleMessage("On sale"),
    "price_range" : MessageLookupByLibrary.simpleMessage("Price Range"),
    "recent_searches" : MessageLookupByLibrary.simpleMessage("Recent searches"),
    "refresh" : MessageLookupByLibrary.simpleMessage("Refresh"),
    "release" : m8,
    "restart_tooltip" : MessageLookupByLibrary.simpleMessage("Restart"),
    "retail_discount" : MessageLookupByLibrary.simpleMessage("Retail discount"),
    "retail_discount_tooltip" : MessageLookupByLibrary.simpleMessage("Games with a current retail price <\$29"),
    "review" : m9,
    "save_deal" : MessageLookupByLibrary.simpleMessage("Save Deal"),
    "settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "sort" : m10,
    "sortBy" : MessageLookupByLibrary.simpleMessage("Sort By"),
    "sort_tooltip" : m11,
    "steam_rating" : MessageLookupByLibrary.simpleMessage("Steam Rating"),
    "steamworks" : MessageLookupByLibrary.simpleMessage("SteamWorks"),
    "steamworks_tooltip" : MessageLookupByLibrary.simpleMessage("Games registered in Steam, regardless the store"),
    "stores" : MessageLookupByLibrary.simpleMessage("Stores"),
    "suggested_searches" : MessageLookupByLibrary.simpleMessage("Suggested searches"),
    "system" : MessageLookupByLibrary.simpleMessage("System"),
    "themeMode" : m12,
    "title_search" : m13,
    "up_tooltip" : MessageLookupByLibrary.simpleMessage("Up")
  };
}
