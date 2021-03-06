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

  static m0(tag) => "${Intl.plural(tag, zero: 'Alert when price is Free', other: 'Alert when price drops to \$${tag} or below')}";

  static m1(change) => "${change}d ago";

  static m2(change) => "${change}h ago";

  static m3(change) => "${change}m ago";

  static m4(change) => "${change}mo ago";

  static m5(change) => "${change}y ago";

  static m6(price, date) => "\$${price} on ${date}";

  static m7(view) => "${Intl.select(view, {'List': 'List', 'Grid': 'Grid', 'Detail': 'Detail', 'Compact': 'Compact', 'Swipe': 'Swipe', 'other': 'List', })}";

  static m8(error, message) => "${Intl.select(error, {'CANCEL': 'Request has been canceled', 'CONNECT_TIMEOUT': 'Connection Timeout: very slow connection', 'RECEIVE_TIMEOUT': 'Server took too long to respond', 'SEND_TIMEOUT': 'Send Timeout, might want to try with a better connection', 'other': '${message}', })}";

  static m9(money) => "${Intl.plural(money, zero: 'free', one: '1 dollar', other: '${money} dollars')}";

  static m10(date) => "Releases: ${date}";

  static m11(date) => "Released on: ${date}";

  static m12(review) => "${Intl.select(review, {'Overwhelmingly_Negative': 'Overwhelmingly Negative', 'Very_Negative': 'Very Negative', 'Negative': 'Negative', 'Mostly_Negative': 'Mostly Negative', 'Mixed': 'Mixed', 'Mostly_Positive': 'Mostly Positive', 'Positive': 'Positive', 'Very_Positive': 'Very Positive', 'Overwhelmingly_Positive': 'Overwhelmingly Positive', 'null': 'Unknown', 'other': '${review}', })}";

  static m13(sort) => "${Intl.select(sort, {'Deal_Rating': 'Deal Rating', 'Title': 'Title', 'Savings': 'Savings', 'Price': 'Price', 'Metacritic': 'Metacritic', 'Reviews': 'Reviews', 'Release': 'Release', 'Store': 'Store', 'Recent': 'Recent', 'other': 'Deal Rating', })}";

  static m14(sort) => "${Intl.select(sort, {'Deal_Rating': 'On a scale from 0 to 10, it factors in price, percent off, metacritic, release date, price history, etc', 'Title': 'Title', 'Savings': 'Savings', 'Price': 'Price', 'Metacritic': 'Metacritic', 'Reviews': 'Reviews', 'Release': 'Release', 'Store': 'Store', 'Recent': 'How recently a deal was found', 'other': 'On a scale from 0 to 10, it factors in price, percent off, metacritic, release date, price history, etc', })}";

  static m15(mode) => "${Intl.select(mode, {'system': 'System', 'light': 'Light', 'dark': 'Dark', 'other': 'System', })}";

  static m16(query) => "Search for \'${query}\'";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "alert_price" : m0,
    "all_choice" : MessageLookupByLibrary.simpleMessage("All"),
    "all_stores_tooltip" : MessageLookupByLibrary.simpleMessage("All Stores"),
    "any_metacritic" : MessageLookupByLibrary.simpleMessage("Any score"),
    "any_rating" : MessageLookupByLibrary.simpleMessage("Any"),
    "apply_filter" : MessageLookupByLibrary.simpleMessage("Apply"),
    "ascending" : MessageLookupByLibrary.simpleMessage("Ascending (A-Z)"),
    "cache_dialog_content" : MessageLookupByLibrary.simpleMessage("This action can\'t be undone"),
    "cache_dialog_title" : MessageLookupByLibrary.simpleMessage("Are you sure?"),
    "cache_snackbar_cleared" : MessageLookupByLibrary.simpleMessage("Cache cleared"),
    "cache_subtitle" : MessageLookupByLibrary.simpleMessage("Clear images cache, recent searches, etc."),
    "cache_title" : MessageLookupByLibrary.simpleMessage("Clear cache"),
    "change_in_days" : m1,
    "change_in_hours" : m2,
    "change_in_minutes" : m3,
    "change_in_months" : m4,
    "change_in_years" : m5,
    "cheapest_ever" : MessageLookupByLibrary.simpleMessage("Cheapest Ever: "),
    "cheapest_price_and_date" : m6,
    "choose_theme" : MessageLookupByLibrary.simpleMessage("Choose theme"),
    "choose_view" : m7,
    "clear_tooltip" : MessageLookupByLibrary.simpleMessage("Clear"),
    "connection_error" : MessageLookupByLibrary.simpleMessage("No Internet connection"),
    "dark" : MessageLookupByLibrary.simpleMessage("Dark"),
    "descending" : MessageLookupByLibrary.simpleMessage("Descending (Z-A)"),
    "dio_error" : m8,
    "dollar_currency" : m9,
    "feedback" : MessageLookupByLibrary.simpleMessage("Send feedback"),
    "filter" : MessageLookupByLibrary.simpleMessage("Filters"),
    "filter_tooltip" : MessageLookupByLibrary.simpleMessage("Open filter menu"),
    "first_tooltip" : MessageLookupByLibrary.simpleMessage("First"),
    "future_release" : m10,
    "go_to_deal" : MessageLookupByLibrary.simpleMessage("Go to Deal"),
    "help" : MessageLookupByLibrary.simpleMessage("Help"),
    "internal_browser_checkbox" : MessageLookupByLibrary.simpleMessage("Internal Browser"),
    "last_tooltip" : MessageLookupByLibrary.simpleMessage("Last"),
    "light" : MessageLookupByLibrary.simpleMessage("Light"),
    "no_date" : MessageLookupByLibrary.simpleMessage("N/A"),
    "no_game_saved" : MessageLookupByLibrary.simpleMessage("There are no games saved"),
    "no_score" : MessageLookupByLibrary.simpleMessage("N/A"),
    "notifications" : MessageLookupByLibrary.simpleMessage("Notifications"),
    "now" : MessageLookupByLibrary.simpleMessage("now"),
    "on_sale" : MessageLookupByLibrary.simpleMessage("On sale"),
    "on_sale_tooltip" : MessageLookupByLibrary.simpleMessage("On sale"),
    "price_range" : MessageLookupByLibrary.simpleMessage("Price Range"),
    "privacy_policy" : MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "rate_me" : MessageLookupByLibrary.simpleMessage("Rate me"),
    "recent_searches" : MessageLookupByLibrary.simpleMessage("Recent searches"),
    "refresh" : MessageLookupByLibrary.simpleMessage("Refresh"),
    "release" : m11,
    "remove_game" : MessageLookupByLibrary.simpleMessage("Remove Game"),
    "report_bug" : MessageLookupByLibrary.simpleMessage("Report Bug"),
    "restart_tooltip" : MessageLookupByLibrary.simpleMessage("Restart"),
    "retail_discount" : MessageLookupByLibrary.simpleMessage("Retail discount"),
    "retail_discount_tooltip" : MessageLookupByLibrary.simpleMessage("Games with a current retail price <\$29"),
    "review" : m12,
    "review_tooltip" : MessageLookupByLibrary.simpleMessage("Review"),
    "save_game" : MessageLookupByLibrary.simpleMessage("Save Game"),
    "save_game_title" : MessageLookupByLibrary.simpleMessage("Watchlist"),
    "save_game_tooltip" : MessageLookupByLibrary.simpleMessage("Open Watchlist"),
    "settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "soon" : MessageLookupByLibrary.simpleMessage("Soon"),
    "sort" : m13,
    "sortBy" : MessageLookupByLibrary.simpleMessage("Sort By"),
    "sort_tooltip" : m14,
    "steam_rating" : MessageLookupByLibrary.simpleMessage("Steam Rating"),
    "steamworks" : MessageLookupByLibrary.simpleMessage("SteamWorks"),
    "steamworks_tooltip" : MessageLookupByLibrary.simpleMessage("Games registered in Steam, regardless the store"),
    "stores" : MessageLookupByLibrary.simpleMessage("Stores"),
    "suggested_searches" : MessageLookupByLibrary.simpleMessage("Suggested searches"),
    "system" : MessageLookupByLibrary.simpleMessage("System"),
    "themeMode" : m15,
    "theme_title" : MessageLookupByLibrary.simpleMessage("Themes"),
    "title_search" : m16,
    "up_tooltip" : MessageLookupByLibrary.simpleMessage("Up"),
    "view" : MessageLookupByLibrary.simpleMessage("View")
  };
}
