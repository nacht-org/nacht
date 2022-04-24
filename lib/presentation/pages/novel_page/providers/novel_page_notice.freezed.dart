// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'novel_page_notice.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$NovelPageNoticeTearOff {
  const _$NovelPageNoticeTearOff();

  _ErrorNotice error(String message) {
    return _ErrorNotice(
      message,
    );
  }
}

/// @nodoc
const $NovelPageNotice = _$NovelPageNoticeTearOff();

/// @nodoc
mixin _$NovelPageNotice {
  String get message => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ErrorNotice value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ErrorNotice value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ErrorNotice value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NovelPageNoticeCopyWith<NovelPageNotice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NovelPageNoticeCopyWith<$Res> {
  factory $NovelPageNoticeCopyWith(
          NovelPageNotice value, $Res Function(NovelPageNotice) then) =
      _$NovelPageNoticeCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class _$NovelPageNoticeCopyWithImpl<$Res>
    implements $NovelPageNoticeCopyWith<$Res> {
  _$NovelPageNoticeCopyWithImpl(this._value, this._then);

  final NovelPageNotice _value;
  // ignore: unused_field
  final $Res Function(NovelPageNotice) _then;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$ErrorNoticeCopyWith<$Res>
    implements $NovelPageNoticeCopyWith<$Res> {
  factory _$ErrorNoticeCopyWith(
          _ErrorNotice value, $Res Function(_ErrorNotice) then) =
      __$ErrorNoticeCopyWithImpl<$Res>;
  @override
  $Res call({String message});
}

/// @nodoc
class __$ErrorNoticeCopyWithImpl<$Res>
    extends _$NovelPageNoticeCopyWithImpl<$Res>
    implements _$ErrorNoticeCopyWith<$Res> {
  __$ErrorNoticeCopyWithImpl(
      _ErrorNotice _value, $Res Function(_ErrorNotice) _then)
      : super(_value, (v) => _then(v as _ErrorNotice));

  @override
  _ErrorNotice get _value => super._value as _ErrorNotice;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_ErrorNotice(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ErrorNotice implements _ErrorNotice {
  _$_ErrorNotice(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'NovelPageNotice.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ErrorNotice &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$ErrorNoticeCopyWith<_ErrorNotice> get copyWith =>
      __$ErrorNoticeCopyWithImpl<_ErrorNotice>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ErrorNotice value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ErrorNotice value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ErrorNotice value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ErrorNotice implements NovelPageNotice {
  factory _ErrorNotice(String message) = _$_ErrorNotice;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$ErrorNoticeCopyWith<_ErrorNotice> get copyWith =>
      throw _privateConstructorUsedError;
}
