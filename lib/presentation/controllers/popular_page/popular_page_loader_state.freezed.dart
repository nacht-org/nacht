// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'popular_page_loader_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PopularPageLoaderStateTearOff {
  const _$PopularPageLoaderStateTearOff();

  _PopularPageLoaderData data(List<PartialNovelEntity> novels) {
    return _PopularPageLoaderData(
      novels,
    );
  }

  _PopularPageLoaderLoading loading() {
    return const _PopularPageLoaderLoading();
  }
}

/// @nodoc
const $PopularPageLoaderState = _$PopularPageLoaderStateTearOff();

/// @nodoc
mixin _$PopularPageLoaderState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<PartialNovelEntity> novels) data,
    required TResult Function() loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<PartialNovelEntity> novels)? data,
    TResult Function()? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<PartialNovelEntity> novels)? data,
    TResult Function()? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PopularPageLoaderData value) data,
    required TResult Function(_PopularPageLoaderLoading value) loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_PopularPageLoaderData value)? data,
    TResult Function(_PopularPageLoaderLoading value)? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PopularPageLoaderData value)? data,
    TResult Function(_PopularPageLoaderLoading value)? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PopularPageLoaderStateCopyWith<$Res> {
  factory $PopularPageLoaderStateCopyWith(PopularPageLoaderState value,
          $Res Function(PopularPageLoaderState) then) =
      _$PopularPageLoaderStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$PopularPageLoaderStateCopyWithImpl<$Res>
    implements $PopularPageLoaderStateCopyWith<$Res> {
  _$PopularPageLoaderStateCopyWithImpl(this._value, this._then);

  final PopularPageLoaderState _value;
  // ignore: unused_field
  final $Res Function(PopularPageLoaderState) _then;
}

/// @nodoc
abstract class _$PopularPageLoaderDataCopyWith<$Res> {
  factory _$PopularPageLoaderDataCopyWith(_PopularPageLoaderData value,
          $Res Function(_PopularPageLoaderData) then) =
      __$PopularPageLoaderDataCopyWithImpl<$Res>;
  $Res call({List<PartialNovelEntity> novels});
}

/// @nodoc
class __$PopularPageLoaderDataCopyWithImpl<$Res>
    extends _$PopularPageLoaderStateCopyWithImpl<$Res>
    implements _$PopularPageLoaderDataCopyWith<$Res> {
  __$PopularPageLoaderDataCopyWithImpl(_PopularPageLoaderData _value,
      $Res Function(_PopularPageLoaderData) _then)
      : super(_value, (v) => _then(v as _PopularPageLoaderData));

  @override
  _PopularPageLoaderData get _value => super._value as _PopularPageLoaderData;

  @override
  $Res call({
    Object? novels = freezed,
  }) {
    return _then(_PopularPageLoaderData(
      novels == freezed
          ? _value.novels
          : novels // ignore: cast_nullable_to_non_nullable
              as List<PartialNovelEntity>,
    ));
  }
}

/// @nodoc

class _$_PopularPageLoaderData implements _PopularPageLoaderData {
  const _$_PopularPageLoaderData(this.novels);

  @override
  final List<PartialNovelEntity> novels;

  @override
  String toString() {
    return 'PopularPageLoaderState.data(novels: $novels)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PopularPageLoaderData &&
            const DeepCollectionEquality().equals(other.novels, novels));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(novels));

  @JsonKey(ignore: true)
  @override
  _$PopularPageLoaderDataCopyWith<_PopularPageLoaderData> get copyWith =>
      __$PopularPageLoaderDataCopyWithImpl<_PopularPageLoaderData>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<PartialNovelEntity> novels) data,
    required TResult Function() loading,
  }) {
    return data(novels);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<PartialNovelEntity> novels)? data,
    TResult Function()? loading,
  }) {
    return data?.call(novels);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<PartialNovelEntity> novels)? data,
    TResult Function()? loading,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(novels);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PopularPageLoaderData value) data,
    required TResult Function(_PopularPageLoaderLoading value) loading,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_PopularPageLoaderData value)? data,
    TResult Function(_PopularPageLoaderLoading value)? loading,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PopularPageLoaderData value)? data,
    TResult Function(_PopularPageLoaderLoading value)? loading,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _PopularPageLoaderData implements PopularPageLoaderState {
  const factory _PopularPageLoaderData(List<PartialNovelEntity> novels) =
      _$_PopularPageLoaderData;

  List<PartialNovelEntity> get novels;
  @JsonKey(ignore: true)
  _$PopularPageLoaderDataCopyWith<_PopularPageLoaderData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$PopularPageLoaderLoadingCopyWith<$Res> {
  factory _$PopularPageLoaderLoadingCopyWith(_PopularPageLoaderLoading value,
          $Res Function(_PopularPageLoaderLoading) then) =
      __$PopularPageLoaderLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$PopularPageLoaderLoadingCopyWithImpl<$Res>
    extends _$PopularPageLoaderStateCopyWithImpl<$Res>
    implements _$PopularPageLoaderLoadingCopyWith<$Res> {
  __$PopularPageLoaderLoadingCopyWithImpl(_PopularPageLoaderLoading _value,
      $Res Function(_PopularPageLoaderLoading) _then)
      : super(_value, (v) => _then(v as _PopularPageLoaderLoading));

  @override
  _PopularPageLoaderLoading get _value =>
      super._value as _PopularPageLoaderLoading;
}

/// @nodoc

class _$_PopularPageLoaderLoading implements _PopularPageLoaderLoading {
  const _$_PopularPageLoaderLoading();

  @override
  String toString() {
    return 'PopularPageLoaderState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PopularPageLoaderLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<PartialNovelEntity> novels) data,
    required TResult Function() loading,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(List<PartialNovelEntity> novels)? data,
    TResult Function()? loading,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<PartialNovelEntity> novels)? data,
    TResult Function()? loading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PopularPageLoaderData value) data,
    required TResult Function(_PopularPageLoaderLoading value) loading,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_PopularPageLoaderData value)? data,
    TResult Function(_PopularPageLoaderLoading value)? loading,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PopularPageLoaderData value)? data,
    TResult Function(_PopularPageLoaderLoading value)? loading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _PopularPageLoaderLoading implements PopularPageLoaderState {
  const factory _PopularPageLoaderLoading() = _$_PopularPageLoaderLoading;
}
