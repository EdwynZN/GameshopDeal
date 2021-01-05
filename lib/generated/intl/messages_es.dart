// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
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
  String get localeName => 'es';

  static m0(change) => "hace ${change}d";

  static m1(change) => "hace ${change}h";

  static m2(change) => "hace ${change}m";

  static m3(change) => "hace ${change}me";

  static m4(change) => "hace ${change}a";

  static m5(view) => "${Intl.select(view, {'List': 'Lista', 'Detail': 'Detalle', 'Compact': 'Compacta', 'Swipe': 'Página', 'other': 'Lista', })}";

  static m6(money) => "${Intl.plural(money, zero: 'gratis', one: '1 dólar', many: '${money} dolares')}";

  static m7(date) => "Lanzado en: ${date}";

  static m8(sort) => "${Intl.select(sort, {'Deal_Rating': 'Valoración de oferta', 'Title': 'Título', 'Savings': 'Oferta', 'Price': 'Precio', 'Metacritic': 'Metacritic', 'Reviews': 'Reseñas', 'Release': 'Lanzamiento', 'Store': 'Tienda', 'Recent': 'Oferta reciente', 'other': 'Valoración', })}";

  static m9(sort) => "${Intl.select(sort, {'Deal_Rating': 'En una escala del 0 al 10, toma en cuenta precio, descuento, metacritic, historial de oferta, etc', 'Title': 'Título', 'Savings': 'Oferta', 'Price': 'Precio', 'Metacritic': 'Metacritic', 'Reviews': 'Reseñas', 'Release': 'Lanzamiento', 'Store': 'Tienda', 'Recent': 'Que tan reciente fue publicado la oferta', 'other': 'En una escala del 0 al 10, toma en cuenta precio, descuento, metacritic, historial de oferta, etc', })}";

  static m10(mode) => "${Intl.select(mode, {'system': 'Predeterminado', 'light': 'Claro', 'dark': 'Oscuro', 'other': 'Predeterminado', })}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "all_choice" : MessageLookupByLibrary.simpleMessage("Todas"),
    "all_stores_tooltip" : MessageLookupByLibrary.simpleMessage("Todas las tiendas"),
    "any_metacritic" : MessageLookupByLibrary.simpleMessage("Cualquier valoración"),
    "any_rating" : MessageLookupByLibrary.simpleMessage("Cualquier valoración"),
    "apply_filter" : MessageLookupByLibrary.simpleMessage("Guardar"),
    "ascending" : MessageLookupByLibrary.simpleMessage("Ascendente (A-Z)"),
    "cache_dialog_content" : MessageLookupByLibrary.simpleMessage("Esta acción no se puede deshacer"),
    "cache_dialog_title" : MessageLookupByLibrary.simpleMessage("Estas seguro?"),
    "cache_snackbar_cleared" : MessageLookupByLibrary.simpleMessage("Cache borrado"),
    "cache_title" : MessageLookupByLibrary.simpleMessage("Borrar cache"),
    "change_in_days" : m0,
    "change_in_hours" : m1,
    "change_in_minutes" : m2,
    "change_in_months" : m3,
    "change_in_years" : m4,
    "choose_deal_view" : m5,
    "choose_theme" : MessageLookupByLibrary.simpleMessage("Escoger tema"),
    "dark" : MessageLookupByLibrary.simpleMessage("Oscuro"),
    "deal_view" : MessageLookupByLibrary.simpleMessage("Vista de ofertas"),
    "descending" : MessageLookupByLibrary.simpleMessage("Descendente (Z-A)"),
    "dollar_currency" : m6,
    "feedback" : MessageLookupByLibrary.simpleMessage("Retroalimentación"),
    "filter" : MessageLookupByLibrary.simpleMessage("Filtros"),
    "filter_tooltip" : MessageLookupByLibrary.simpleMessage("Abrir menu de filtros"),
    "help" : MessageLookupByLibrary.simpleMessage("Ayuda"),
    "light" : MessageLookupByLibrary.simpleMessage("Claro"),
    "no_date" : MessageLookupByLibrary.simpleMessage("Proximamente"),
    "now" : MessageLookupByLibrary.simpleMessage("ahora"),
    "on_sale" : MessageLookupByLibrary.simpleMessage("En venta"),
    "on_sale_tooltip" : MessageLookupByLibrary.simpleMessage("En venta"),
    "price_range" : MessageLookupByLibrary.simpleMessage("Rango de precios"),
    "release" : m7,
    "restart_tooltip" : MessageLookupByLibrary.simpleMessage("Reiniciar"),
    "retail_discount" : MessageLookupByLibrary.simpleMessage("Descuento en tienda"),
    "retail_discount_tooltip" : MessageLookupByLibrary.simpleMessage("Juegos con precio menores a 29 dolares en tiendas"),
    "search_tooltip" : MessageLookupByLibrary.simpleMessage("Buscar"),
    "settings" : MessageLookupByLibrary.simpleMessage("Opciones"),
    "sort" : m8,
    "sortBy" : MessageLookupByLibrary.simpleMessage("Ordenar por"),
    "sort_tooltip" : m9,
    "steam_rating" : MessageLookupByLibrary.simpleMessage("Valoración de Steam"),
    "steamworks" : MessageLookupByLibrary.simpleMessage("SteamWorks"),
    "steamworks_tooltip" : MessageLookupByLibrary.simpleMessage("Juegos registrados en steam, independientemente de la tienda"),
    "stores" : MessageLookupByLibrary.simpleMessage("Tiendas"),
    "system" : MessageLookupByLibrary.simpleMessage("Predeterminado"),
    "themeMode" : m10,
    "up_tooltip" : MessageLookupByLibrary.simpleMessage("Arriba")
  };
}
