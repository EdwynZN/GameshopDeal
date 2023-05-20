// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Filter _$FilterFromJson(Map<String, dynamic> json) {
  return _Filter.fromJson(json);
}

/// @nodoc
mixin _$Filter {
  @HiveField(0)
  @JsonKey(defaultValue: const <String>{})
  Set<String> get storeId => throw _privateConstructorUsedError;
  @HiveField(1)
  @JsonKey(defaultValue: 60)
  int get pageSize => throw _privateConstructorUsedError;
  @HiveField(2)
  SortBy get sortBy => throw _privateConstructorUsedError;
  @HiveField(3)
  @JsonKey(
      name: 'desc',
      defaultValue: false,
      toJson: _boolToInt,
      fromJson: _intToBool)
  bool get isAscendant => throw _privateConstructorUsedError;
  @HiveField(4)
  @JsonKey(defaultValue: 0)
  int get lowerPrice => throw _privateConstructorUsedError;
  @HiveField(5)
  @JsonKey(defaultValue: 0)
  int get upperPrice => throw _privateConstructorUsedError;
  @HiveField(6)
  @JsonKey(defaultValue: 0)
  int get metacritic => throw _privateConstructorUsedError;
  @HiveField(7)
  @JsonKey(defaultValue: 0)
  int get steamRating => throw _privateConstructorUsedError;
  @HiveField(8)
  @JsonKey(defaultValue: const <String>{})
  Set<String> get steamAppId => throw _privateConstructorUsedError;
  @HiveField(9)
  @JsonKey(
      name: 'AAA',
      defaultValue: false,
      toJson: _boolToInt,
      fromJson: _intToBool)
  bool get onlyRetail => throw _privateConstructorUsedError;
  @HiveField(10)
  @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
  bool get steamWorks => throw _privateConstructorUsedError;
  @HiveField(11)
  @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
  bool get onSale => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
  bool get exact => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FilterCopyWith<Filter> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FilterCopyWith<$Res> {
  factory $FilterCopyWith(Filter value, $Res Function(Filter) then) =
      _$FilterCopyWithImpl<$Res, Filter>;
  @useResult
  $Res call(
      {@HiveField(0)
      @JsonKey(defaultValue: const <String>{})
          Set<String> storeId,
      @HiveField(1)
      @JsonKey(defaultValue: 60)
          int pageSize,
      @HiveField(2)
          SortBy sortBy,
      @HiveField(3)
      @JsonKey(name: 'desc', defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool isAscendant,
      @HiveField(4)
      @JsonKey(defaultValue: 0)
          int lowerPrice,
      @HiveField(5)
      @JsonKey(defaultValue: 0)
          int upperPrice,
      @HiveField(6)
      @JsonKey(defaultValue: 0)
          int metacritic,
      @HiveField(7)
      @JsonKey(defaultValue: 0)
          int steamRating,
      @HiveField(8)
      @JsonKey(defaultValue: const <String>{})
          Set<String> steamAppId,
      @HiveField(9)
      @JsonKey(name: 'AAA', defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool onlyRetail,
      @HiveField(10)
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool steamWorks,
      @HiveField(11)
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool onSale,
      String title,
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool exact});
}

/// @nodoc
class _$FilterCopyWithImpl<$Res, $Val extends Filter>
    implements $FilterCopyWith<$Res> {
  _$FilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = null,
    Object? pageSize = null,
    Object? sortBy = null,
    Object? isAscendant = null,
    Object? lowerPrice = null,
    Object? upperPrice = null,
    Object? metacritic = null,
    Object? steamRating = null,
    Object? steamAppId = null,
    Object? onlyRetail = null,
    Object? steamWorks = null,
    Object? onSale = null,
    Object? title = null,
    Object? exact = null,
  }) {
    return _then(_value.copyWith(
      storeId: null == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      sortBy: null == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as SortBy,
      isAscendant: null == isAscendant
          ? _value.isAscendant
          : isAscendant // ignore: cast_nullable_to_non_nullable
              as bool,
      lowerPrice: null == lowerPrice
          ? _value.lowerPrice
          : lowerPrice // ignore: cast_nullable_to_non_nullable
              as int,
      upperPrice: null == upperPrice
          ? _value.upperPrice
          : upperPrice // ignore: cast_nullable_to_non_nullable
              as int,
      metacritic: null == metacritic
          ? _value.metacritic
          : metacritic // ignore: cast_nullable_to_non_nullable
              as int,
      steamRating: null == steamRating
          ? _value.steamRating
          : steamRating // ignore: cast_nullable_to_non_nullable
              as int,
      steamAppId: null == steamAppId
          ? _value.steamAppId
          : steamAppId // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      onlyRetail: null == onlyRetail
          ? _value.onlyRetail
          : onlyRetail // ignore: cast_nullable_to_non_nullable
              as bool,
      steamWorks: null == steamWorks
          ? _value.steamWorks
          : steamWorks // ignore: cast_nullable_to_non_nullable
              as bool,
      onSale: null == onSale
          ? _value.onSale
          : onSale // ignore: cast_nullable_to_non_nullable
              as bool,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      exact: null == exact
          ? _value.exact
          : exact // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FilterCopyWith<$Res> implements $FilterCopyWith<$Res> {
  factory _$$_FilterCopyWith(_$_Filter value, $Res Function(_$_Filter) then) =
      __$$_FilterCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0)
      @JsonKey(defaultValue: const <String>{})
          Set<String> storeId,
      @HiveField(1)
      @JsonKey(defaultValue: 60)
          int pageSize,
      @HiveField(2)
          SortBy sortBy,
      @HiveField(3)
      @JsonKey(name: 'desc', defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool isAscendant,
      @HiveField(4)
      @JsonKey(defaultValue: 0)
          int lowerPrice,
      @HiveField(5)
      @JsonKey(defaultValue: 0)
          int upperPrice,
      @HiveField(6)
      @JsonKey(defaultValue: 0)
          int metacritic,
      @HiveField(7)
      @JsonKey(defaultValue: 0)
          int steamRating,
      @HiveField(8)
      @JsonKey(defaultValue: const <String>{})
          Set<String> steamAppId,
      @HiveField(9)
      @JsonKey(name: 'AAA', defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool onlyRetail,
      @HiveField(10)
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool steamWorks,
      @HiveField(11)
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool onSale,
      String title,
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          bool exact});
}

/// @nodoc
class __$$_FilterCopyWithImpl<$Res>
    extends _$FilterCopyWithImpl<$Res, _$_Filter>
    implements _$$_FilterCopyWith<$Res> {
  __$$_FilterCopyWithImpl(_$_Filter _value, $Res Function(_$_Filter) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = null,
    Object? pageSize = null,
    Object? sortBy = null,
    Object? isAscendant = null,
    Object? lowerPrice = null,
    Object? upperPrice = null,
    Object? metacritic = null,
    Object? steamRating = null,
    Object? steamAppId = null,
    Object? onlyRetail = null,
    Object? steamWorks = null,
    Object? onSale = null,
    Object? title = null,
    Object? exact = null,
  }) {
    return _then(_$_Filter(
      storeId: null == storeId
          ? _value._storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      sortBy: null == sortBy
          ? _value.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as SortBy,
      isAscendant: null == isAscendant
          ? _value.isAscendant
          : isAscendant // ignore: cast_nullable_to_non_nullable
              as bool,
      lowerPrice: null == lowerPrice
          ? _value.lowerPrice
          : lowerPrice // ignore: cast_nullable_to_non_nullable
              as int,
      upperPrice: null == upperPrice
          ? _value.upperPrice
          : upperPrice // ignore: cast_nullable_to_non_nullable
              as int,
      metacritic: null == metacritic
          ? _value.metacritic
          : metacritic // ignore: cast_nullable_to_non_nullable
              as int,
      steamRating: null == steamRating
          ? _value.steamRating
          : steamRating // ignore: cast_nullable_to_non_nullable
              as int,
      steamAppId: null == steamAppId
          ? _value._steamAppId
          : steamAppId // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      onlyRetail: null == onlyRetail
          ? _value.onlyRetail
          : onlyRetail // ignore: cast_nullable_to_non_nullable
              as bool,
      steamWorks: null == steamWorks
          ? _value.steamWorks
          : steamWorks // ignore: cast_nullable_to_non_nullable
              as bool,
      onSale: null == onSale
          ? _value.onSale
          : onSale // ignore: cast_nullable_to_non_nullable
              as bool,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      exact: null == exact
          ? _value.exact
          : exact // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 9, adapterName: 'FilterAdapter')
class _$_Filter extends _Filter with DiagnosticableTreeMixin {
  _$_Filter(
      {@HiveField(0)
      @JsonKey(defaultValue: const <String>{})
          final Set<String> storeId = const <String>{},
      @HiveField(1)
      @JsonKey(defaultValue: 60)
          this.pageSize = 60,
      @HiveField(2)
          this.sortBy = SortBy.Deal_Rating,
      @HiveField(3)
      @JsonKey(name: 'desc', defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          this.isAscendant = false,
      @HiveField(4)
      @JsonKey(defaultValue: 0)
          this.lowerPrice = 0,
      @HiveField(5)
      @JsonKey(defaultValue: 0)
          this.upperPrice = 50,
      @HiveField(6)
      @JsonKey(defaultValue: 0)
          this.metacritic = 0,
      @HiveField(7)
      @JsonKey(defaultValue: 0)
          this.steamRating = 0,
      @HiveField(8)
      @JsonKey(defaultValue: const <String>{})
          final Set<String> steamAppId = const <String>{},
      @HiveField(9)
      @JsonKey(name: 'AAA', defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          this.onlyRetail = false,
      @HiveField(10)
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          this.steamWorks = false,
      @HiveField(11)
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          this.onSale = false,
      this.title = '',
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          this.exact = false})
      : _storeId = storeId,
        _steamAppId = steamAppId,
        super._();

  factory _$_Filter.fromJson(Map<String, dynamic> json) =>
      _$$_FilterFromJson(json);

  final Set<String> _storeId;
  @override
  @HiveField(0)
  @JsonKey(defaultValue: const <String>{})
  Set<String> get storeId {
    if (_storeId is EqualUnmodifiableSetView) return _storeId;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_storeId);
  }

  @override
  @HiveField(1)
  @JsonKey(defaultValue: 60)
  final int pageSize;
  @override
  @JsonKey()
  @HiveField(2)
  final SortBy sortBy;
  @override
  @HiveField(3)
  @JsonKey(
      name: 'desc',
      defaultValue: false,
      toJson: _boolToInt,
      fromJson: _intToBool)
  final bool isAscendant;
  @override
  @HiveField(4)
  @JsonKey(defaultValue: 0)
  final int lowerPrice;
  @override
  @HiveField(5)
  @JsonKey(defaultValue: 0)
  final int upperPrice;
  @override
  @HiveField(6)
  @JsonKey(defaultValue: 0)
  final int metacritic;
  @override
  @HiveField(7)
  @JsonKey(defaultValue: 0)
  final int steamRating;
  final Set<String> _steamAppId;
  @override
  @HiveField(8)
  @JsonKey(defaultValue: const <String>{})
  Set<String> get steamAppId {
    if (_steamAppId is EqualUnmodifiableSetView) return _steamAppId;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_steamAppId);
  }

  @override
  @HiveField(9)
  @JsonKey(
      name: 'AAA',
      defaultValue: false,
      toJson: _boolToInt,
      fromJson: _intToBool)
  final bool onlyRetail;
  @override
  @HiveField(10)
  @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
  final bool steamWorks;
  @override
  @HiveField(11)
  @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
  final bool onSale;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
  final bool exact;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Filter(storeId: $storeId, pageSize: $pageSize, sortBy: $sortBy, isAscendant: $isAscendant, lowerPrice: $lowerPrice, upperPrice: $upperPrice, metacritic: $metacritic, steamRating: $steamRating, steamAppId: $steamAppId, onlyRetail: $onlyRetail, steamWorks: $steamWorks, onSale: $onSale, title: $title, exact: $exact)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Filter'))
      ..add(DiagnosticsProperty('storeId', storeId))
      ..add(DiagnosticsProperty('pageSize', pageSize))
      ..add(DiagnosticsProperty('sortBy', sortBy))
      ..add(DiagnosticsProperty('isAscendant', isAscendant))
      ..add(DiagnosticsProperty('lowerPrice', lowerPrice))
      ..add(DiagnosticsProperty('upperPrice', upperPrice))
      ..add(DiagnosticsProperty('metacritic', metacritic))
      ..add(DiagnosticsProperty('steamRating', steamRating))
      ..add(DiagnosticsProperty('steamAppId', steamAppId))
      ..add(DiagnosticsProperty('onlyRetail', onlyRetail))
      ..add(DiagnosticsProperty('steamWorks', steamWorks))
      ..add(DiagnosticsProperty('onSale', onSale))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('exact', exact));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Filter &&
            const DeepCollectionEquality().equals(other._storeId, _storeId) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy) &&
            (identical(other.isAscendant, isAscendant) ||
                other.isAscendant == isAscendant) &&
            (identical(other.lowerPrice, lowerPrice) ||
                other.lowerPrice == lowerPrice) &&
            (identical(other.upperPrice, upperPrice) ||
                other.upperPrice == upperPrice) &&
            (identical(other.metacritic, metacritic) ||
                other.metacritic == metacritic) &&
            (identical(other.steamRating, steamRating) ||
                other.steamRating == steamRating) &&
            const DeepCollectionEquality()
                .equals(other._steamAppId, _steamAppId) &&
            (identical(other.onlyRetail, onlyRetail) ||
                other.onlyRetail == onlyRetail) &&
            (identical(other.steamWorks, steamWorks) ||
                other.steamWorks == steamWorks) &&
            (identical(other.onSale, onSale) || other.onSale == onSale) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.exact, exact) || other.exact == exact));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_storeId),
      pageSize,
      sortBy,
      isAscendant,
      lowerPrice,
      upperPrice,
      metacritic,
      steamRating,
      const DeepCollectionEquality().hash(_steamAppId),
      onlyRetail,
      steamWorks,
      onSale,
      title,
      exact);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FilterCopyWith<_$_Filter> get copyWith =>
      __$$_FilterCopyWithImpl<_$_Filter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FilterToJson(
      this,
    );
  }
}

abstract class _Filter extends Filter {
  factory _Filter(
      {@HiveField(0)
      @JsonKey(defaultValue: const <String>{})
          final Set<String> storeId,
      @HiveField(1)
      @JsonKey(defaultValue: 60)
          final int pageSize,
      @HiveField(2)
          final SortBy sortBy,
      @HiveField(3)
      @JsonKey(name: 'desc', defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          final bool isAscendant,
      @HiveField(4)
      @JsonKey(defaultValue: 0)
          final int lowerPrice,
      @HiveField(5)
      @JsonKey(defaultValue: 0)
          final int upperPrice,
      @HiveField(6)
      @JsonKey(defaultValue: 0)
          final int metacritic,
      @HiveField(7)
      @JsonKey(defaultValue: 0)
          final int steamRating,
      @HiveField(8)
      @JsonKey(defaultValue: const <String>{})
          final Set<String> steamAppId,
      @HiveField(9)
      @JsonKey(name: 'AAA', defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          final bool onlyRetail,
      @HiveField(10)
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          final bool steamWorks,
      @HiveField(11)
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          final bool onSale,
      final String title,
      @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
          final bool exact}) = _$_Filter;
  _Filter._() : super._();

  factory _Filter.fromJson(Map<String, dynamic> json) = _$_Filter.fromJson;

  @override
  @HiveField(0)
  @JsonKey(defaultValue: const <String>{})
  Set<String> get storeId;
  @override
  @HiveField(1)
  @JsonKey(defaultValue: 60)
  int get pageSize;
  @override
  @HiveField(2)
  SortBy get sortBy;
  @override
  @HiveField(3)
  @JsonKey(
      name: 'desc',
      defaultValue: false,
      toJson: _boolToInt,
      fromJson: _intToBool)
  bool get isAscendant;
  @override
  @HiveField(4)
  @JsonKey(defaultValue: 0)
  int get lowerPrice;
  @override
  @HiveField(5)
  @JsonKey(defaultValue: 0)
  int get upperPrice;
  @override
  @HiveField(6)
  @JsonKey(defaultValue: 0)
  int get metacritic;
  @override
  @HiveField(7)
  @JsonKey(defaultValue: 0)
  int get steamRating;
  @override
  @HiveField(8)
  @JsonKey(defaultValue: const <String>{})
  Set<String> get steamAppId;
  @override
  @HiveField(9)
  @JsonKey(
      name: 'AAA',
      defaultValue: false,
      toJson: _boolToInt,
      fromJson: _intToBool)
  bool get onlyRetail;
  @override
  @HiveField(10)
  @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
  bool get steamWorks;
  @override
  @HiveField(11)
  @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
  bool get onSale;
  @override
  String get title;
  @override
  @JsonKey(defaultValue: false, toJson: _boolToInt, fromJson: _intToBool)
  bool get exact;
  @override
  @JsonKey(ignore: true)
  _$$_FilterCopyWith<_$_Filter> get copyWith =>
      throw _privateConstructorUsedError;
}
