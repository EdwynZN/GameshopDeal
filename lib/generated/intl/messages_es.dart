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

  static m2(change) => "hace ${change}min";

  static m3(change) => "hace ${change}m";

  static m4(change) => "hace ${change}a";

  static m5(price, date) => "\$${price} el ${date}";

  static m6(view) => "${Intl.select(view, {'List': 'Lista', 'Grid': 'Cuadrícula', 'Detail': 'Detalle', 'Compact': 'Compacta', 'Swipe': 'Página', 'other': 'Lista', })}";

  static m7(error, message) => "${Intl.select(error, {'CANCEL': 'La petición fue cancelada', 'CONNECT_TIMEOUT': 'Tiempo de conexión excedido: Conexión inestable o lenta', 'RECEIVE_TIMEOUT': 'El servidor esta tardando en responder', 'SEND_TIMEOUT': 'Conexión inestable o lenta', 'other': '${message}', })}";

  static m8(money) => "${Intl.plural(money, zero: 'gratis', one: '1 dólar', other: '${money} dolares')}";

  static m9(date) => "Próximamente: ${date}";

  static m10(date) => "Lanzado e1: ${date}";

  static m11(review) => "${Intl.select(review, {'Overwhelmingly_Negative': 'Extremadamente Negativo', 'Very_Negative': 'Muy Negativo', 'Negative': 'Negativo', 'Mostly_Negative': 'Mayormente Negativo', 'Mixed': 'Mixtas', 'Mostly_Positive': 'Mayormente Positivo', 'Positive': 'Positivo', 'Very_Positive': 'Muy Positivo', 'Overwhelmingly_Positive': 'Extremadamente Positivo', 'null': 'Desconocido', 'other': 'Desconocido', })}";

  static m12(sort) => "${Intl.select(sort, {'Deal_Rating': 'Valoración de oferta', 'Title': 'Título', 'Savings': 'Oferta', 'Price': 'Precio', 'Metacritic': 'Metacritic', 'Reviews': 'Reseñas', 'Release': 'Lanzamiento', 'Store': 'Tienda', 'Recent': 'Oferta reciente', 'other': 'Valoración', })}";

  static m13(sort) => "${Intl.select(sort, {'Deal_Rating': 'En una escala del 0 al 10, toma en cuenta precio, descuento, metacritic, historial de oferta, etc', 'Title': 'Título', 'Savings': 'Oferta', 'Price': 'Precio', 'Metacritic': 'Metacritic', 'Reviews': 'Reseñas', 'Release': 'Lanzamiento', 'Store': 'Tienda', 'Recent': 'Que tan reciente fue publicado la oferta', 'other': 'En una escala del 0 al 10, toma en cuenta precio, descuento, metacritic, historial de oferta, etc', })}";

  static m14(mode) => "${Intl.select(mode, {'system': 'Predeterminado', 'light': 'Claro', 'dark': 'Oscuro', 'other': 'Predeterminado', })}";

  static m15(query) => "Buscar \'${query}\'";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "all_choice" : MessageLookupByLibrary.simpleMessage("Todas"),
    "all_stores_tooltip" : MessageLookupByLibrary.simpleMessage("Todas las tiendas"),
    "any_metacritic" : MessageLookupByLibrary.simpleMessage("Cualquier valoración"),
    "any_rating" : MessageLookupByLibrary.simpleMessage("Cualquier valoración"),
    "apply_filter" : MessageLookupByLibrary.simpleMessage("Aplicar"),
    "ascending" : MessageLookupByLibrary.simpleMessage("Ascendente (A-Z)"),
    "cache_dialog_content" : MessageLookupByLibrary.simpleMessage("Esta acción no se puede deshacer"),
    "cache_dialog_title" : MessageLookupByLibrary.simpleMessage("Estas seguro?"),
    "cache_snackbar_cleared" : MessageLookupByLibrary.simpleMessage("Cache borrado"),
    "cache_subtitle" : MessageLookupByLibrary.simpleMessage("Borrar imágenes en cache, búsquedas recientes, etc."),
    "cache_title" : MessageLookupByLibrary.simpleMessage("Borrar cache"),
    "change_in_days" : m0,
    "change_in_hours" : m1,
    "change_in_minutes" : m2,
    "change_in_months" : m3,
    "change_in_years" : m4,
    "cheapest_ever" : MessageLookupByLibrary.simpleMessage("Mejor Oferta: "),
    "cheapest_price_and_date" : m5,
    "choose_deal_view" : m6,
    "choose_theme" : MessageLookupByLibrary.simpleMessage("Escoger tema"),
    "clear_tooltip" : MessageLookupByLibrary.simpleMessage("Borrar"),
    "connection_error" : MessageLookupByLibrary.simpleMessage("Sin Internet"),
    "dark" : MessageLookupByLibrary.simpleMessage("Oscuro"),
    "deal_view" : MessageLookupByLibrary.simpleMessage("Vista de ofertas"),
    "descending" : MessageLookupByLibrary.simpleMessage("Descendente (Z-A)"),
    "dio_error" : m7,
    "dollar_currency" : m8,
    "feedback" : MessageLookupByLibrary.simpleMessage("Retroalimentación"),
    "filter" : MessageLookupByLibrary.simpleMessage("Filtros"),
    "filter_tooltip" : MessageLookupByLibrary.simpleMessage("Abrir menu de filtros"),
    "first_tooltip" : MessageLookupByLibrary.simpleMessage("Primero"),
    "future_release" : m9,
    "go_to_deal" : MessageLookupByLibrary.simpleMessage("Ir a oferta"),
    "help" : MessageLookupByLibrary.simpleMessage("Ayuda"),
    "internal_browser_checkbox" : MessageLookupByLibrary.simpleMessage("Navegador Interno"),
    "last_tooltip" : MessageLookupByLibrary.simpleMessage("Último"),
    "light" : MessageLookupByLibrary.simpleMessage("Claro"),
    "no_date" : MessageLookupByLibrary.simpleMessage("N/A"),
    "no_score" : MessageLookupByLibrary.simpleMessage("N/A"),
    "notifications" : MessageLookupByLibrary.simpleMessage("Notificaciones"),
    "now" : MessageLookupByLibrary.simpleMessage("ahora"),
    "on_sale" : MessageLookupByLibrary.simpleMessage("En venta"),
    "on_sale_tooltip" : MessageLookupByLibrary.simpleMessage("En venta"),
    "price_range" : MessageLookupByLibrary.simpleMessage("Rango de precios"),
    "privacy_policy" : MessageLookupByLibrary.simpleMessage("Política de Privacidad"),
    "rate_me" : MessageLookupByLibrary.simpleMessage("Calificame"),
    "recent_searches" : MessageLookupByLibrary.simpleMessage("Busquedas recientes"),
    "refresh" : MessageLookupByLibrary.simpleMessage("Actualizar"),
    "release" : m10,
    "remove_deal" : MessageLookupByLibrary.simpleMessage("Remover oferta"),
    "report_bug" : MessageLookupByLibrary.simpleMessage("Reportar Error"),
    "restart_tooltip" : MessageLookupByLibrary.simpleMessage("Reiniciar"),
    "retail_discount" : MessageLookupByLibrary.simpleMessage("Descuento en tienda"),
    "retail_discount_tooltip" : MessageLookupByLibrary.simpleMessage("Juegos con precio menores a 29 dolares en tiendas"),
    "review" : m11,
    "review_tooltip" : MessageLookupByLibrary.simpleMessage("Reseña"),
    "save_deal" : MessageLookupByLibrary.simpleMessage("Guardar oferta"),
    "save_deal_title" : MessageLookupByLibrary.simpleMessage("Mis Ofertas"),
    "save_deal_tooltip" : MessageLookupByLibrary.simpleMessage("Abrir ofertas guardadas"),
    "settings" : MessageLookupByLibrary.simpleMessage("Opciones"),
    "soon" : MessageLookupByLibrary.simpleMessage("Próximamente"),
    "sort" : m12,
    "sortBy" : MessageLookupByLibrary.simpleMessage("Ordenar por"),
    "sort_tooltip" : m13,
    "steam_rating" : MessageLookupByLibrary.simpleMessage("Valoración de Steam"),
    "steamworks" : MessageLookupByLibrary.simpleMessage("SteamWorks"),
    "steamworks_tooltip" : MessageLookupByLibrary.simpleMessage("Juegos registrados en steam, independientemente de la tienda"),
    "stores" : MessageLookupByLibrary.simpleMessage("Tiendas"),
    "suggested_searches" : MessageLookupByLibrary.simpleMessage("Sugerencias"),
    "system" : MessageLookupByLibrary.simpleMessage("Predeterminado"),
    "themeMode" : m14,
    "theme_title" : MessageLookupByLibrary.simpleMessage("Temas"),
    "title_search" : m15,
    "up_tooltip" : MessageLookupByLibrary.simpleMessage("Arriba")
  };
}
