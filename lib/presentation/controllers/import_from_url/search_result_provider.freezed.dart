// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'search_result_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ImportUrlResultTearOff {
  const _$ImportUrlResultTearOff();

  _EmptyImportUrlResult empty() {
    return const _EmptyImportUrlResult();
  }

  _FoundImportUrlResult found(CrawlerFactory crawlerFactory) {
    return _FoundImportUrlResult(
      crawlerFactory,
    );
  }

  _NotFoundImportUrlResult notFound() {
    return const _NotFoundImportUrlResult();
  }

  _NotAUrlImportUrlResult error(String reason) {
    return _NotAUrlImportUrlResult(
      reason,
    );
  }
}

/// @nodoc
const $ImportUrlResult = _$ImportUrlResultTearOff();

/// @nodoc
mixin _$ImportUrlResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(CrawlerFactory crawlerFactory) found,
    required TResult Function() notFound,
    required TResult Function(String reason) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(CrawlerFactory crawlerFactory)? found,
    TResult Function()? notFound,
    TResult Function(String reason)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(CrawlerFactory crawlerFactory)? found,
    TResult Function()? notFound,
    TResult Function(String reason)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EmptyImportUrlResult value) empty,
    required TResult Function(_FoundImportUrlResult value) found,
    required TResult Function(_NotFoundImportUrlResult value) notFound,
    required TResult Function(_NotAUrlImportUrlResult value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_EmptyImportUrlResult value)? empty,
    TResult Function(_FoundImportUrlResult value)? found,
    TResult Function(_NotFoundImportUrlResult value)? notFound,
    TResult Function(_NotAUrlImportUrlResult value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EmptyImportUrlResult value)? empty,
    TResult Function(_FoundImportUrlResult value)? found,
    TResult Function(_NotFoundImportUrlResult value)? notFound,
    TResult Function(_NotAUrlImportUrlResult value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImportUrlResultCopyWith<$Res> {
  factory $ImportUrlResultCopyWith(
          ImportUrlResult value, $Res Function(ImportUrlResult) then) =
      _$ImportUrlResultCopyWithImpl<$Res>;
}

/// @nodoc
class _$ImportUrlResultCopyWithImpl<$Res>
    implements $ImportUrlResultCopyWith<$Res> {
  _$ImportUrlResultCopyWithImpl(this._value, this._then);

  final ImportUrlResult _value;
  // ignore: unused_field
  final $Res Function(ImportUrlResult) _then;
}

/// @nodoc
abstract class _$EmptyImportUrlResultCopyWith<$Res> {
  factory _$EmptyImportUrlResultCopyWith(_EmptyImportUrlResult value,
          $Res Function(_EmptyImportUrlResult) then) =
      __$EmptyImportUrlResultCopyWithImpl<$Res>;
}

/// @nodoc
class __$EmptyImportUrlResultCopyWithImpl<$Res>
    extends _$ImportUrlResultCopyWithImpl<$Res>
    implements _$EmptyImportUrlResultCopyWith<$Res> {
  __$EmptyImportUrlResultCopyWithImpl(
      _EmptyImportUrlResult _value, $Res Function(_EmptyImportUrlResult) _then)
      : super(_value, (v) => _then(v as _EmptyImportUrlResult));

  @override
  _EmptyImportUrlResult get _value => super._value as _EmptyImportUrlResult;
}

/// @nodoc

class _$_EmptyImportUrlResult implements _EmptyImportUrlResult {
  const _$_EmptyImportUrlResult();

  @override
  String toString() {
    return 'ImportUrlResult.empty()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _EmptyImportUrlResult);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(CrawlerFactory crawlerFactory) found,
    required TResult Function() notFound,
    required TResult Function(String reason) error,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(CrawlerFactory crawlerFactory)? found,
    TResult Function()? notFound,
    TResult Function(String reason)? error,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(CrawlerFactory crawlerFactory)? found,
    TResult Function()? notFound,
    TResult Function(String reason)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EmptyImportUrlResult value) empty,
    required TResult Function(_FoundImportUrlResult value) found,
    required TResult Function(_NotFoundImportUrlResult value) notFound,
    required TResult Function(_NotAUrlImportUrlResult value) error,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_EmptyImportUrlResult value)? empty,
    TResult Function(_FoundImportUrlResult value)? found,
    TResult Function(_NotFoundImportUrlResult value)? notFound,
    TResult Function(_NotAUrlImportUrlResult value)? error,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EmptyImportUrlResult value)? empty,
    TResult Function(_FoundImportUrlResult value)? found,
    TResult Function(_NotFoundImportUrlResult value)? notFound,
    TResult Function(_NotAUrlImportUrlResult value)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class _EmptyImportUrlResult implements ImportUrlResult {
  const factory _EmptyImportUrlResult() = _$_EmptyImportUrlResult;
}

/// @nodoc
abstract class _$FoundImportUrlResultCopyWith<$Res> {
  factory _$FoundImportUrlResultCopyWith(_FoundImportUrlResult value,
          $Res Function(_FoundImportUrlResult) then) =
      __$FoundImportUrlResultCopyWithImpl<$Res>;
  $Res call({CrawlerFactory crawlerFactory});
}

/// @nodoc
class __$FoundImportUrlResultCopyWithImpl<$Res>
    extends _$ImportUrlResultCopyWithImpl<$Res>
    implements _$FoundImportUrlResultCopyWith<$Res> {
  __$FoundImportUrlResultCopyWithImpl(
      _FoundImportUrlResult _value, $Res Function(_FoundImportUrlResult) _then)
      : super(_value, (v) => _then(v as _FoundImportUrlResult));

  @override
  _FoundImportUrlResult get _value => super._value as _FoundImportUrlResult;

  @override
  $Res call({
    Object? crawlerFactory = freezed,
  }) {
    return _then(_FoundImportUrlResult(
      crawlerFactory == freezed
          ? _value.crawlerFactory
          : crawlerFactory // ignore: cast_nullable_to_non_nullable
              as CrawlerFactory,
    ));
  }
}

/// @nodoc

class _$_FoundImportUrlResult implements _FoundImportUrlResult {
  const _$_FoundImportUrlResult(this.crawlerFactory);

  @override
  final CrawlerFactory crawlerFactory;

  @override
  String toString() {
    return 'ImportUrlResult.found(crawlerFactory: $crawlerFactory)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FoundImportUrlResult &&
            const DeepCollectionEquality()
                .equals(other.crawlerFactory, crawlerFactory));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(crawlerFactory));

  @JsonKey(ignore: true)
  @override
  _$FoundImportUrlResultCopyWith<_FoundImportUrlResult> get copyWith =>
      __$FoundImportUrlResultCopyWithImpl<_FoundImportUrlResult>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(CrawlerFactory crawlerFactory) found,
    required TResult Function() notFound,
    required TResult Function(String reason) error,
  }) {
    return found(crawlerFactory);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(CrawlerFactory crawlerFactory)? found,
    TResult Function()? notFound,
    TResult Function(String reason)? error,
  }) {
    return found?.call(crawlerFactory);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(CrawlerFactory crawlerFactory)? found,
    TResult Function()? notFound,
    TResult Function(String reason)? error,
    required TResult orElse(),
  }) {
    if (found != null) {
      return found(crawlerFactory);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EmptyImportUrlResult value) empty,
    required TResult Function(_FoundImportUrlResult value) found,
    required TResult Function(_NotFoundImportUrlResult value) notFound,
    required TResult Function(_NotAUrlImportUrlResult value) error,
  }) {
    return found(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_EmptyImportUrlResult value)? empty,
    TResult Function(_FoundImportUrlResult value)? found,
    TResult Function(_NotFoundImportUrlResult value)? notFound,
    TResult Function(_NotAUrlImportUrlResult value)? error,
  }) {
    return found?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EmptyImportUrlResult value)? empty,
    TResult Function(_FoundImportUrlResult value)? found,
    TResult Function(_NotFoundImportUrlResult value)? notFound,
    TResult Function(_NotAUrlImportUrlResult value)? error,
    required TResult orElse(),
  }) {
    if (found != null) {
      return found(this);
    }
    return orElse();
  }
}

abstract class _FoundImportUrlResult implements ImportUrlResult {
  const factory _FoundImportUrlResult(CrawlerFactory crawlerFactory) =
      _$_FoundImportUrlResult;

  CrawlerFactory get crawlerFactory;
  @JsonKey(ignore: true)
  _$FoundImportUrlResultCopyWith<_FoundImportUrlResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$NotFoundImportUrlResultCopyWith<$Res> {
  factory _$NotFoundImportUrlResultCopyWith(_NotFoundImportUrlResult value,
          $Res Function(_NotFoundImportUrlResult) then) =
      __$NotFoundImportUrlResultCopyWithImpl<$Res>;
}

/// @nodoc
class __$NotFoundImportUrlResultCopyWithImpl<$Res>
    extends _$ImportUrlResultCopyWithImpl<$Res>
    implements _$NotFoundImportUrlResultCopyWith<$Res> {
  __$NotFoundImportUrlResultCopyWithImpl(_NotFoundImportUrlResult _value,
      $Res Function(_NotFoundImportUrlResult) _then)
      : super(_value, (v) => _then(v as _NotFoundImportUrlResult));

  @override
  _NotFoundImportUrlResult get _value =>
      super._value as _NotFoundImportUrlResult;
}

/// @nodoc

class _$_NotFoundImportUrlResult implements _NotFoundImportUrlResult {
  const _$_NotFoundImportUrlResult();

  @override
  String toString() {
    return 'ImportUrlResult.notFound()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _NotFoundImportUrlResult);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(CrawlerFactory crawlerFactory) found,
    required TResult Function() notFound,
    required TResult Function(String reason) error,
  }) {
    return notFound();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(CrawlerFactory crawlerFactory)? found,
    TResult Function()? notFound,
    TResult Function(String reason)? error,
  }) {
    return notFound?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(CrawlerFactory crawlerFactory)? found,
    TResult Function()? notFound,
    TResult Function(String reason)? error,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EmptyImportUrlResult value) empty,
    required TResult Function(_FoundImportUrlResult value) found,
    required TResult Function(_NotFoundImportUrlResult value) notFound,
    required TResult Function(_NotAUrlImportUrlResult value) error,
  }) {
    return notFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_EmptyImportUrlResult value)? empty,
    TResult Function(_FoundImportUrlResult value)? found,
    TResult Function(_NotFoundImportUrlResult value)? notFound,
    TResult Function(_NotAUrlImportUrlResult value)? error,
  }) {
    return notFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EmptyImportUrlResult value)? empty,
    TResult Function(_FoundImportUrlResult value)? found,
    TResult Function(_NotFoundImportUrlResult value)? notFound,
    TResult Function(_NotAUrlImportUrlResult value)? error,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(this);
    }
    return orElse();
  }
}

abstract class _NotFoundImportUrlResult implements ImportUrlResult {
  const factory _NotFoundImportUrlResult() = _$_NotFoundImportUrlResult;
}

/// @nodoc
abstract class _$NotAUrlImportUrlResultCopyWith<$Res> {
  factory _$NotAUrlImportUrlResultCopyWith(_NotAUrlImportUrlResult value,
          $Res Function(_NotAUrlImportUrlResult) then) =
      __$NotAUrlImportUrlResultCopyWithImpl<$Res>;
  $Res call({String reason});
}

/// @nodoc
class __$NotAUrlImportUrlResultCopyWithImpl<$Res>
    extends _$ImportUrlResultCopyWithImpl<$Res>
    implements _$NotAUrlImportUrlResultCopyWith<$Res> {
  __$NotAUrlImportUrlResultCopyWithImpl(_NotAUrlImportUrlResult _value,
      $Res Function(_NotAUrlImportUrlResult) _then)
      : super(_value, (v) => _then(v as _NotAUrlImportUrlResult));

  @override
  _NotAUrlImportUrlResult get _value => super._value as _NotAUrlImportUrlResult;

  @override
  $Res call({
    Object? reason = freezed,
  }) {
    return _then(_NotAUrlImportUrlResult(
      reason == freezed
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_NotAUrlImportUrlResult implements _NotAUrlImportUrlResult {
  const _$_NotAUrlImportUrlResult(this.reason);

  @override
  final String reason;

  @override
  String toString() {
    return 'ImportUrlResult.error(reason: $reason)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NotAUrlImportUrlResult &&
            const DeepCollectionEquality().equals(other.reason, reason));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(reason));

  @JsonKey(ignore: true)
  @override
  _$NotAUrlImportUrlResultCopyWith<_NotAUrlImportUrlResult> get copyWith =>
      __$NotAUrlImportUrlResultCopyWithImpl<_NotAUrlImportUrlResult>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(CrawlerFactory crawlerFactory) found,
    required TResult Function() notFound,
    required TResult Function(String reason) error,
  }) {
    return error(reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(CrawlerFactory crawlerFactory)? found,
    TResult Function()? notFound,
    TResult Function(String reason)? error,
  }) {
    return error?.call(reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(CrawlerFactory crawlerFactory)? found,
    TResult Function()? notFound,
    TResult Function(String reason)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EmptyImportUrlResult value) empty,
    required TResult Function(_FoundImportUrlResult value) found,
    required TResult Function(_NotFoundImportUrlResult value) notFound,
    required TResult Function(_NotAUrlImportUrlResult value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_EmptyImportUrlResult value)? empty,
    TResult Function(_FoundImportUrlResult value)? found,
    TResult Function(_NotFoundImportUrlResult value)? notFound,
    TResult Function(_NotAUrlImportUrlResult value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EmptyImportUrlResult value)? empty,
    TResult Function(_FoundImportUrlResult value)? found,
    TResult Function(_NotFoundImportUrlResult value)? notFound,
    TResult Function(_NotAUrlImportUrlResult value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _NotAUrlImportUrlResult implements ImportUrlResult {
  const factory _NotAUrlImportUrlResult(String reason) =
      _$_NotAUrlImportUrlResult;

  String get reason;
  @JsonKey(ignore: true)
  _$NotAUrlImportUrlResultCopyWith<_NotAUrlImportUrlResult> get copyWith =>
      throw _privateConstructorUsedError;
}
