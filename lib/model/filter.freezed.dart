// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Filter _$FilterFromJson(Map<String, dynamic> json) {
  return _Filter.fromJson(json);
}

/// @nodoc
class _$FilterTearOff {
  const _$FilterTearOff();

// ignore: unused_element
  _Filter call(
      {@JsonKey(defaultValue: const <int>{})
          Set<int> storeID = const <int>{},
      @JsonKey(defaultValue: 60)
          int pageSize = 60,
      SortBy sortBy = SortBy.Deal_Rating,
      @JsonKey(name: 'desc', defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool isAscendant = false,
      @JsonKey(defaultValue: 0)
          int lowerPrice = 0,
      @JsonKey(defaultValue: 0)
          int upperPrice = 50,
      @JsonKey(defaultValue: 0)
          int metacritic = 0,
      @JsonKey(defaultValue: 0)
          int steamRating = 0,
      @JsonKey(defaultValue: const <String>{})
          Set<String> steamAppId = const <String>{},
      String title,
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool exact = false,
      @JsonKey(name: 'AAA', defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool onlyRetail = false,
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool steamWorks = false,
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool onSale = false}) {
    return _Filter(
      storeID: storeID,
      pageSize: pageSize,
      sortBy: sortBy,
      isAscendant: isAscendant,
      lowerPrice: lowerPrice,
      upperPrice: upperPrice,
      metacritic: metacritic,
      steamRating: steamRating,
      steamAppId: steamAppId,
      title: title,
      exact: exact,
      onlyRetail: onlyRetail,
      steamWorks: steamWorks,
      onSale: onSale,
    );
  }

// ignore: unused_element
  Filter fromJson(Map<String, Object> json) {
    return Filter.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Filter = _$FilterTearOff();

/// @nodoc
mixin _$Filter {
  @JsonKey(defaultValue: const <int>{})
  Set<int> get storeID; // @Default(0) @JsonKey(defaultValue: 0) int pageNumber,
  @JsonKey(defaultValue: 60)
  int get pageSize;
  SortBy get sortBy;
  @JsonKey(
      name: 'desc',
      defaultValue: false,
      toJson: _boolToInt,
      fromJson: _intToBool)
  bool get isAscendant;
  @JsonKey(defaultValue: 0)
  int get lowerPrice;
  @JsonKey(defaultValue: 0)
  int get upperPrice;
  @JsonKey(defaultValue: 0)
  int get metacritic;
  @JsonKey(defaultValue: 0)
  int get steamRating;
  @JsonKey(defaultValue: const <String>{})
  Set<String> get steamAppId;
  String get title;
  @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
  bool get exact;
  @JsonKey(
      name: 'AAA',
      defaultValue: false,
      toJson: _boolToInt,
      fromJson: _intToBool)
  bool get onlyRetail;
  @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
  bool get steamWorks;
  @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
  bool get onSale;

  Map<String, dynamic> toJson();
  $FilterCopyWith<Filter> get copyWith;
}

/// @nodoc
abstract class $FilterCopyWith<$Res> {
  factory $FilterCopyWith(Filter value, $Res Function(Filter) then) =
      _$FilterCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(defaultValue: const <int>{})
          Set<int> storeID,
      @JsonKey(defaultValue: 60)
          int pageSize,
      SortBy sortBy,
      @JsonKey(name: 'desc', defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool isAscendant,
      @JsonKey(defaultValue: 0)
          int lowerPrice,
      @JsonKey(defaultValue: 0)
          int upperPrice,
      @JsonKey(defaultValue: 0)
          int metacritic,
      @JsonKey(defaultValue: 0)
          int steamRating,
      @JsonKey(defaultValue: const <String>{})
          Set<String> steamAppId,
      String title,
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool exact,
      @JsonKey(name: 'AAA', defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool onlyRetail,
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool steamWorks,
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool onSale});
}

/// @nodoc
class _$FilterCopyWithImpl<$Res> implements $FilterCopyWith<$Res> {
  _$FilterCopyWithImpl(this._value, this._then);

  final Filter _value;
  // ignore: unused_field
  final $Res Function(Filter) _then;

  @override
  $Res call({
    Object storeID = freezed,
    Object pageSize = freezed,
    Object sortBy = freezed,
    Object isAscendant = freezed,
    Object lowerPrice = freezed,
    Object upperPrice = freezed,
    Object metacritic = freezed,
    Object steamRating = freezed,
    Object steamAppId = freezed,
    Object title = freezed,
    Object exact = freezed,
    Object onlyRetail = freezed,
    Object steamWorks = freezed,
    Object onSale = freezed,
  }) {
    return _then(_value.copyWith(
      storeID: storeID == freezed ? _value.storeID : storeID as Set<int>,
      pageSize: pageSize == freezed ? _value.pageSize : pageSize as int,
      sortBy: sortBy == freezed ? _value.sortBy : sortBy as SortBy,
      isAscendant:
          isAscendant == freezed ? _value.isAscendant : isAscendant as bool,
      lowerPrice: lowerPrice == freezed ? _value.lowerPrice : lowerPrice as int,
      upperPrice: upperPrice == freezed ? _value.upperPrice : upperPrice as int,
      metacritic: metacritic == freezed ? _value.metacritic : metacritic as int,
      steamRating:
          steamRating == freezed ? _value.steamRating : steamRating as int,
      steamAppId:
          steamAppId == freezed ? _value.steamAppId : steamAppId as Set<String>,
      title: title == freezed ? _value.title : title as String,
      exact: exact == freezed ? _value.exact : exact as bool,
      onlyRetail:
          onlyRetail == freezed ? _value.onlyRetail : onlyRetail as bool,
      steamWorks:
          steamWorks == freezed ? _value.steamWorks : steamWorks as bool,
      onSale: onSale == freezed ? _value.onSale : onSale as bool,
    ));
  }
}

/// @nodoc
abstract class _$FilterCopyWith<$Res> implements $FilterCopyWith<$Res> {
  factory _$FilterCopyWith(_Filter value, $Res Function(_Filter) then) =
      __$FilterCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(defaultValue: const <int>{})
          Set<int> storeID,
      @JsonKey(defaultValue: 60)
          int pageSize,
      SortBy sortBy,
      @JsonKey(name: 'desc', defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool isAscendant,
      @JsonKey(defaultValue: 0)
          int lowerPrice,
      @JsonKey(defaultValue: 0)
          int upperPrice,
      @JsonKey(defaultValue: 0)
          int metacritic,
      @JsonKey(defaultValue: 0)
          int steamRating,
      @JsonKey(defaultValue: const <String>{})
          Set<String> steamAppId,
      String title,
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool exact,
      @JsonKey(name: 'AAA', defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool onlyRetail,
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool steamWorks,
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool onSale});
}

/// @nodoc
class __$FilterCopyWithImpl<$Res> extends _$FilterCopyWithImpl<$Res>
    implements _$FilterCopyWith<$Res> {
  __$FilterCopyWithImpl(_Filter _value, $Res Function(_Filter) _then)
      : super(_value, (v) => _then(v as _Filter));

  @override
  _Filter get _value => super._value as _Filter;

  @override
  $Res call({
    Object storeID = freezed,
    Object pageSize = freezed,
    Object sortBy = freezed,
    Object isAscendant = freezed,
    Object lowerPrice = freezed,
    Object upperPrice = freezed,
    Object metacritic = freezed,
    Object steamRating = freezed,
    Object steamAppId = freezed,
    Object title = freezed,
    Object exact = freezed,
    Object onlyRetail = freezed,
    Object steamWorks = freezed,
    Object onSale = freezed,
  }) {
    return _then(_Filter(
      storeID: storeID == freezed ? _value.storeID : storeID as Set<int>,
      pageSize: pageSize == freezed ? _value.pageSize : pageSize as int,
      sortBy: sortBy == freezed ? _value.sortBy : sortBy as SortBy,
      isAscendant:
          isAscendant == freezed ? _value.isAscendant : isAscendant as bool,
      lowerPrice: lowerPrice == freezed ? _value.lowerPrice : lowerPrice as int,
      upperPrice: upperPrice == freezed ? _value.upperPrice : upperPrice as int,
      metacritic: metacritic == freezed ? _value.metacritic : metacritic as int,
      steamRating:
          steamRating == freezed ? _value.steamRating : steamRating as int,
      steamAppId:
          steamAppId == freezed ? _value.steamAppId : steamAppId as Set<String>,
      title: title == freezed ? _value.title : title as String,
      exact: exact == freezed ? _value.exact : exact as bool,
      onlyRetail:
          onlyRetail == freezed ? _value.onlyRetail : onlyRetail as bool,
      steamWorks:
          steamWorks == freezed ? _value.steamWorks : steamWorks as bool,
      onSale: onSale == freezed ? _value.onSale : onSale as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Filter with DiagnosticableTreeMixin implements _Filter {
  _$_Filter(
      {@JsonKey(defaultValue: const <int>{})
          this.storeID = const <int>{},
      @JsonKey(defaultValue: 60)
          this.pageSize = 60,
      this.sortBy = SortBy.Deal_Rating,
      @JsonKey(name: 'desc', defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          this.isAscendant = false,
      @JsonKey(defaultValue: 0)
          this.lowerPrice = 0,
      @JsonKey(defaultValue: 0)
          this.upperPrice = 50,
      @JsonKey(defaultValue: 0)
          this.metacritic = 0,
      @JsonKey(defaultValue: 0)
          this.steamRating = 0,
      @JsonKey(defaultValue: const <String>{})
          this.steamAppId = const <String>{},
      this.title,
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          this.exact = false,
      @JsonKey(name: 'AAA', defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          this.onlyRetail = false,
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          this.steamWorks = false,
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          this.onSale = false})
      : assert(storeID != null),
        assert(pageSize != null),
        assert(sortBy != null),
        assert(isAscendant != null),
        assert(lowerPrice != null),
        assert(upperPrice != null),
        assert(metacritic != null),
        assert(steamRating != null),
        assert(steamAppId != null),
        assert(exact != null),
        assert(onlyRetail != null),
        assert(steamWorks != null),
        assert(onSale != null);

  factory _$_Filter.fromJson(Map<String, dynamic> json) =>
      _$_$_FilterFromJson(json);

  @override
  @JsonKey(defaultValue: const <int>{})
  final Set<int> storeID;
  @override // @Default(0) @JsonKey(defaultValue: 0) int pageNumber,
  @JsonKey(defaultValue: 60)
  final int pageSize;
  @JsonKey(defaultValue: SortBy.Deal_Rating)
  @override
  final SortBy sortBy;
  @override
  @JsonKey(
      name: 'desc',
      defaultValue: false,
      toJson: _boolToInt,
      fromJson: _intToBool)
  final bool isAscendant;
  @override
  @JsonKey(defaultValue: 0)
  final int lowerPrice;
  @override
  @JsonKey(defaultValue: 0)
  final int upperPrice;
  @override
  @JsonKey(defaultValue: 0)
  final int metacritic;
  @override
  @JsonKey(defaultValue: 0)
  final int steamRating;
  @override
  @JsonKey(defaultValue: const <String>{})
  final Set<String> steamAppId;
  @override
  final String title;
  @override
  @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
  final bool exact;
  @override
  @JsonKey(
      name: 'AAA',
      defaultValue: false,
      toJson: _boolToInt,
      fromJson: _intToBool)
  final bool onlyRetail;
  @override
  @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
  final bool steamWorks;
  @override
  @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
  final bool onSale;

  bool _didparameters = false;
  Map<String, dynamic> _parameters;

  @override
  Map<String, dynamic> get parameters {
    if (_didparameters == false) {
      _didparameters = true;
      _parameters = <String, dynamic>{
        if (storeID.isNotEmpty) 'storeID': storeID.join(','),
        if (sortBy != SortBy.Deal_Rating) 'sortBy': describeEnum(sortBy),
        if (pageSize != 60) 'pageSize': pageSize,
        if (isAscendant) 'desc': 1,
        if (lowerPrice != 0) 'lowerPrice': lowerPrice,
        if (upperPrice < 50) 'upperPrice': upperPrice,
        if (metacritic != 0) 'metacritic': metacritic,
        if (steamRating > 40) 'steamRating': steamRating,
        if (steamAppId.isNotEmpty) 'steamAppID ': steamAppId.join(','),
        if (title != null && title.isNotEmpty) ...<String, dynamic>{
          'title': title,
          if (exact) 'exact': 1,
        },
        if (onlyRetail) 'AAA': 1,
        if (steamWorks) 'steamworks': 1,
        if (onSale) 'onSale': 1
      };
    }
    return _parameters;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Filter(storeID: $storeID, pageSize: $pageSize, sortBy: $sortBy, isAscendant: $isAscendant, lowerPrice: $lowerPrice, upperPrice: $upperPrice, metacritic: $metacritic, steamRating: $steamRating, steamAppId: $steamAppId, title: $title, exact: $exact, onlyRetail: $onlyRetail, steamWorks: $steamWorks, onSale: $onSale, parameters: $parameters)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Filter'))
      ..add(DiagnosticsProperty('storeID', storeID))
      ..add(DiagnosticsProperty('pageSize', pageSize))
      ..add(DiagnosticsProperty('sortBy', sortBy))
      ..add(DiagnosticsProperty('isAscendant', isAscendant))
      ..add(DiagnosticsProperty('lowerPrice', lowerPrice))
      ..add(DiagnosticsProperty('upperPrice', upperPrice))
      ..add(DiagnosticsProperty('metacritic', metacritic))
      ..add(DiagnosticsProperty('steamRating', steamRating))
      ..add(DiagnosticsProperty('steamAppId', steamAppId))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('exact', exact))
      ..add(DiagnosticsProperty('onlyRetail', onlyRetail))
      ..add(DiagnosticsProperty('steamWorks', steamWorks))
      ..add(DiagnosticsProperty('onSale', onSale))
      ..add(DiagnosticsProperty('parameters', parameters));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Filter &&
            (identical(other.storeID, storeID) ||
                const DeepCollectionEquality()
                    .equals(other.storeID, storeID)) &&
            (identical(other.pageSize, pageSize) ||
                const DeepCollectionEquality()
                    .equals(other.pageSize, pageSize)) &&
            (identical(other.sortBy, sortBy) ||
                const DeepCollectionEquality().equals(other.sortBy, sortBy)) &&
            (identical(other.isAscendant, isAscendant) ||
                const DeepCollectionEquality()
                    .equals(other.isAscendant, isAscendant)) &&
            (identical(other.lowerPrice, lowerPrice) ||
                const DeepCollectionEquality()
                    .equals(other.lowerPrice, lowerPrice)) &&
            (identical(other.upperPrice, upperPrice) ||
                const DeepCollectionEquality()
                    .equals(other.upperPrice, upperPrice)) &&
            (identical(other.metacritic, metacritic) ||
                const DeepCollectionEquality()
                    .equals(other.metacritic, metacritic)) &&
            (identical(other.steamRating, steamRating) ||
                const DeepCollectionEquality()
                    .equals(other.steamRating, steamRating)) &&
            (identical(other.steamAppId, steamAppId) ||
                const DeepCollectionEquality()
                    .equals(other.steamAppId, steamAppId)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.exact, exact) ||
                const DeepCollectionEquality().equals(other.exact, exact)) &&
            (identical(other.onlyRetail, onlyRetail) ||
                const DeepCollectionEquality()
                    .equals(other.onlyRetail, onlyRetail)) &&
            (identical(other.steamWorks, steamWorks) ||
                const DeepCollectionEquality()
                    .equals(other.steamWorks, steamWorks)) &&
            (identical(other.onSale, onSale) ||
                const DeepCollectionEquality().equals(other.onSale, onSale)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(storeID) ^
      const DeepCollectionEquality().hash(pageSize) ^
      const DeepCollectionEquality().hash(sortBy) ^
      const DeepCollectionEquality().hash(isAscendant) ^
      const DeepCollectionEquality().hash(lowerPrice) ^
      const DeepCollectionEquality().hash(upperPrice) ^
      const DeepCollectionEquality().hash(metacritic) ^
      const DeepCollectionEquality().hash(steamRating) ^
      const DeepCollectionEquality().hash(steamAppId) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(exact) ^
      const DeepCollectionEquality().hash(onlyRetail) ^
      const DeepCollectionEquality().hash(steamWorks) ^
      const DeepCollectionEquality().hash(onSale);

  @override
  _$FilterCopyWith<_Filter> get copyWith =>
      __$FilterCopyWithImpl<_Filter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_FilterToJson(this);
  }
}

abstract class _Filter implements Filter {
  factory _Filter(
      {@JsonKey(defaultValue: const <int>{})
          Set<int> storeID,
      @JsonKey(defaultValue: 60)
          int pageSize,
      SortBy sortBy,
      @JsonKey(name: 'desc', defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool isAscendant,
      @JsonKey(defaultValue: 0)
          int lowerPrice,
      @JsonKey(defaultValue: 0)
          int upperPrice,
      @JsonKey(defaultValue: 0)
          int metacritic,
      @JsonKey(defaultValue: 0)
          int steamRating,
      @JsonKey(defaultValue: const <String>{})
          Set<String> steamAppId,
      String title,
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool exact,
      @JsonKey(name: 'AAA', defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool onlyRetail,
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool steamWorks,
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool onSale}) = _$_Filter;

  factory _Filter.fromJson(Map<String, dynamic> json) = _$_Filter.fromJson;

  @override
  @JsonKey(defaultValue: const <int>{})
  Set<int> get storeID;
  @override // @Default(0) @JsonKey(defaultValue: 0) int pageNumber,
  @JsonKey(defaultValue: 60)
  int get pageSize;
  @override
  SortBy get sortBy;
  @override
  @JsonKey(
      name: 'desc',
      defaultValue: false,
      toJson: _boolToInt,
      fromJson: _intToBool)
  bool get isAscendant;
  @override
  @JsonKey(defaultValue: 0)
  int get lowerPrice;
  @override
  @JsonKey(defaultValue: 0)
  int get upperPrice;
  @override
  @JsonKey(defaultValue: 0)
  int get metacritic;
  @override
  @JsonKey(defaultValue: 0)
  int get steamRating;
  @override
  @JsonKey(defaultValue: const <String>{})
  Set<String> get steamAppId;
  @override
  String get title;
  @override
  @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
  bool get exact;
  @override
  @JsonKey(
      name: 'AAA',
      defaultValue: false,
      toJson: _boolToInt,
      fromJson: _intToBool)
  bool get onlyRetail;
  @override
  @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
  bool get steamWorks;
  @override
  @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
  bool get onSale;
  @override
  _$FilterCopyWith<_Filter> get copyWith;
}
