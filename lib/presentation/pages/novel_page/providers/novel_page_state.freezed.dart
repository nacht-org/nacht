// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'novel_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$NovelPageStateTearOff {
  const _$NovelPageStateTearOff();

  _NovelPagePartial partial(PartialNovelEntity entity) {
    return _NovelPagePartial(
      entity,
    );
  }

  _NovelPageLoaded loaded(NovelEntity entity) {
    return _NovelPageLoaded(
      entity,
    );
  }
}

/// @nodoc
const $NovelPageState = _$NovelPageStateTearOff();

/// @nodoc
mixin _$NovelPageState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PartialNovelEntity entity) partial,
    required TResult Function(NovelEntity entity) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(PartialNovelEntity entity)? partial,
    TResult Function(NovelEntity entity)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PartialNovelEntity entity)? partial,
    TResult Function(NovelEntity entity)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NovelPagePartial value) partial,
    required TResult Function(_NovelPageLoaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_NovelPagePartial value)? partial,
    TResult Function(_NovelPageLoaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NovelPagePartial value)? partial,
    TResult Function(_NovelPageLoaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NovelPageStateCopyWith<$Res> {
  factory $NovelPageStateCopyWith(
          NovelPageState value, $Res Function(NovelPageState) then) =
      _$NovelPageStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$NovelPageStateCopyWithImpl<$Res>
    implements $NovelPageStateCopyWith<$Res> {
  _$NovelPageStateCopyWithImpl(this._value, this._then);

  final NovelPageState _value;
  // ignore: unused_field
  final $Res Function(NovelPageState) _then;
}

/// @nodoc
abstract class _$NovelPagePartialCopyWith<$Res> {
  factory _$NovelPagePartialCopyWith(
          _NovelPagePartial value, $Res Function(_NovelPagePartial) then) =
      __$NovelPagePartialCopyWithImpl<$Res>;
  $Res call({PartialNovelEntity entity});

  $PartialNovelEntityCopyWith<$Res> get entity;
}

/// @nodoc
class __$NovelPagePartialCopyWithImpl<$Res>
    extends _$NovelPageStateCopyWithImpl<$Res>
    implements _$NovelPagePartialCopyWith<$Res> {
  __$NovelPagePartialCopyWithImpl(
      _NovelPagePartial _value, $Res Function(_NovelPagePartial) _then)
      : super(_value, (v) => _then(v as _NovelPagePartial));

  @override
  _NovelPagePartial get _value => super._value as _NovelPagePartial;

  @override
  $Res call({
    Object? entity = freezed,
  }) {
    return _then(_NovelPagePartial(
      entity == freezed
          ? _value.entity
          : entity // ignore: cast_nullable_to_non_nullable
              as PartialNovelEntity,
    ));
  }

  @override
  $PartialNovelEntityCopyWith<$Res> get entity {
    return $PartialNovelEntityCopyWith<$Res>(_value.entity, (value) {
      return _then(_value.copyWith(entity: value));
    });
  }
}

/// @nodoc

class _$_NovelPagePartial implements _NovelPagePartial {
  _$_NovelPagePartial(this.entity);

  @override
  final PartialNovelEntity entity;

  @override
  String toString() {
    return 'NovelPageState.partial(entity: $entity)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NovelPagePartial &&
            const DeepCollectionEquality().equals(other.entity, entity));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(entity));

  @JsonKey(ignore: true)
  @override
  _$NovelPagePartialCopyWith<_NovelPagePartial> get copyWith =>
      __$NovelPagePartialCopyWithImpl<_NovelPagePartial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PartialNovelEntity entity) partial,
    required TResult Function(NovelEntity entity) loaded,
  }) {
    return partial(entity);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(PartialNovelEntity entity)? partial,
    TResult Function(NovelEntity entity)? loaded,
  }) {
    return partial?.call(entity);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PartialNovelEntity entity)? partial,
    TResult Function(NovelEntity entity)? loaded,
    required TResult orElse(),
  }) {
    if (partial != null) {
      return partial(entity);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NovelPagePartial value) partial,
    required TResult Function(_NovelPageLoaded value) loaded,
  }) {
    return partial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_NovelPagePartial value)? partial,
    TResult Function(_NovelPageLoaded value)? loaded,
  }) {
    return partial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NovelPagePartial value)? partial,
    TResult Function(_NovelPageLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (partial != null) {
      return partial(this);
    }
    return orElse();
  }
}

abstract class _NovelPagePartial implements NovelPageState {
  factory _NovelPagePartial(PartialNovelEntity entity) = _$_NovelPagePartial;

  PartialNovelEntity get entity;
  @JsonKey(ignore: true)
  _$NovelPagePartialCopyWith<_NovelPagePartial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$NovelPageLoadedCopyWith<$Res> {
  factory _$NovelPageLoadedCopyWith(
          _NovelPageLoaded value, $Res Function(_NovelPageLoaded) then) =
      __$NovelPageLoadedCopyWithImpl<$Res>;
  $Res call({NovelEntity entity});

  $NovelEntityCopyWith<$Res> get entity;
}

/// @nodoc
class __$NovelPageLoadedCopyWithImpl<$Res>
    extends _$NovelPageStateCopyWithImpl<$Res>
    implements _$NovelPageLoadedCopyWith<$Res> {
  __$NovelPageLoadedCopyWithImpl(
      _NovelPageLoaded _value, $Res Function(_NovelPageLoaded) _then)
      : super(_value, (v) => _then(v as _NovelPageLoaded));

  @override
  _NovelPageLoaded get _value => super._value as _NovelPageLoaded;

  @override
  $Res call({
    Object? entity = freezed,
  }) {
    return _then(_NovelPageLoaded(
      entity == freezed
          ? _value.entity
          : entity // ignore: cast_nullable_to_non_nullable
              as NovelEntity,
    ));
  }

  @override
  $NovelEntityCopyWith<$Res> get entity {
    return $NovelEntityCopyWith<$Res>(_value.entity, (value) {
      return _then(_value.copyWith(entity: value));
    });
  }
}

/// @nodoc

class _$_NovelPageLoaded implements _NovelPageLoaded {
  _$_NovelPageLoaded(this.entity);

  @override
  final NovelEntity entity;

  @override
  String toString() {
    return 'NovelPageState.loaded(entity: $entity)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NovelPageLoaded &&
            const DeepCollectionEquality().equals(other.entity, entity));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(entity));

  @JsonKey(ignore: true)
  @override
  _$NovelPageLoadedCopyWith<_NovelPageLoaded> get copyWith =>
      __$NovelPageLoadedCopyWithImpl<_NovelPageLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PartialNovelEntity entity) partial,
    required TResult Function(NovelEntity entity) loaded,
  }) {
    return loaded(entity);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(PartialNovelEntity entity)? partial,
    TResult Function(NovelEntity entity)? loaded,
  }) {
    return loaded?.call(entity);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PartialNovelEntity entity)? partial,
    TResult Function(NovelEntity entity)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(entity);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NovelPagePartial value) partial,
    required TResult Function(_NovelPageLoaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_NovelPagePartial value)? partial,
    TResult Function(_NovelPageLoaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NovelPagePartial value)? partial,
    TResult Function(_NovelPageLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _NovelPageLoaded implements NovelPageState {
  factory _NovelPageLoaded(NovelEntity entity) = _$_NovelPageLoaded;

  NovelEntity get entity;
  @JsonKey(ignore: true)
  _$NovelPageLoadedCopyWith<_NovelPageLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}
