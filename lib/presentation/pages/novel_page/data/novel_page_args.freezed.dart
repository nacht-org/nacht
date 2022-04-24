// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'novel_page_args.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$NovelEntityArgumentTearOff {
  const _$NovelEntityArgumentTearOff();

  _PartialEntity partial(PartialNovelEntity novel) {
    return _PartialEntity(
      novel,
    );
  }

  _CompleteEntity complete(NovelEntity novel) {
    return _CompleteEntity(
      novel,
    );
  }
}

/// @nodoc
const $NovelEntityArgument = _$NovelEntityArgumentTearOff();

/// @nodoc
mixin _$NovelEntityArgument {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PartialNovelEntity novel) partial,
    required TResult Function(NovelEntity novel) complete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(PartialNovelEntity novel)? partial,
    TResult Function(NovelEntity novel)? complete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PartialNovelEntity novel)? partial,
    TResult Function(NovelEntity novel)? complete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PartialEntity value) partial,
    required TResult Function(_CompleteEntity value) complete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_PartialEntity value)? partial,
    TResult Function(_CompleteEntity value)? complete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PartialEntity value)? partial,
    TResult Function(_CompleteEntity value)? complete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NovelEntityArgumentCopyWith<$Res> {
  factory $NovelEntityArgumentCopyWith(
          NovelEntityArgument value, $Res Function(NovelEntityArgument) then) =
      _$NovelEntityArgumentCopyWithImpl<$Res>;
}

/// @nodoc
class _$NovelEntityArgumentCopyWithImpl<$Res>
    implements $NovelEntityArgumentCopyWith<$Res> {
  _$NovelEntityArgumentCopyWithImpl(this._value, this._then);

  final NovelEntityArgument _value;
  // ignore: unused_field
  final $Res Function(NovelEntityArgument) _then;
}

/// @nodoc
abstract class _$PartialEntityCopyWith<$Res> {
  factory _$PartialEntityCopyWith(
          _PartialEntity value, $Res Function(_PartialEntity) then) =
      __$PartialEntityCopyWithImpl<$Res>;
  $Res call({PartialNovelEntity novel});

  $PartialNovelEntityCopyWith<$Res> get novel;
}

/// @nodoc
class __$PartialEntityCopyWithImpl<$Res>
    extends _$NovelEntityArgumentCopyWithImpl<$Res>
    implements _$PartialEntityCopyWith<$Res> {
  __$PartialEntityCopyWithImpl(
      _PartialEntity _value, $Res Function(_PartialEntity) _then)
      : super(_value, (v) => _then(v as _PartialEntity));

  @override
  _PartialEntity get _value => super._value as _PartialEntity;

  @override
  $Res call({
    Object? novel = freezed,
  }) {
    return _then(_PartialEntity(
      novel == freezed
          ? _value.novel
          : novel // ignore: cast_nullable_to_non_nullable
              as PartialNovelEntity,
    ));
  }

  @override
  $PartialNovelEntityCopyWith<$Res> get novel {
    return $PartialNovelEntityCopyWith<$Res>(_value.novel, (value) {
      return _then(_value.copyWith(novel: value));
    });
  }
}

/// @nodoc

class _$_PartialEntity implements _PartialEntity {
  _$_PartialEntity(this.novel);

  @override
  final PartialNovelEntity novel;

  @override
  String toString() {
    return 'NovelEntityArgument.partial(novel: $novel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PartialEntity &&
            const DeepCollectionEquality().equals(other.novel, novel));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(novel));

  @JsonKey(ignore: true)
  @override
  _$PartialEntityCopyWith<_PartialEntity> get copyWith =>
      __$PartialEntityCopyWithImpl<_PartialEntity>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PartialNovelEntity novel) partial,
    required TResult Function(NovelEntity novel) complete,
  }) {
    return partial(novel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(PartialNovelEntity novel)? partial,
    TResult Function(NovelEntity novel)? complete,
  }) {
    return partial?.call(novel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PartialNovelEntity novel)? partial,
    TResult Function(NovelEntity novel)? complete,
    required TResult orElse(),
  }) {
    if (partial != null) {
      return partial(novel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PartialEntity value) partial,
    required TResult Function(_CompleteEntity value) complete,
  }) {
    return partial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_PartialEntity value)? partial,
    TResult Function(_CompleteEntity value)? complete,
  }) {
    return partial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PartialEntity value)? partial,
    TResult Function(_CompleteEntity value)? complete,
    required TResult orElse(),
  }) {
    if (partial != null) {
      return partial(this);
    }
    return orElse();
  }
}

abstract class _PartialEntity implements NovelEntityArgument {
  factory _PartialEntity(PartialNovelEntity novel) = _$_PartialEntity;

  PartialNovelEntity get novel;
  @JsonKey(ignore: true)
  _$PartialEntityCopyWith<_PartialEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$CompleteEntityCopyWith<$Res> {
  factory _$CompleteEntityCopyWith(
          _CompleteEntity value, $Res Function(_CompleteEntity) then) =
      __$CompleteEntityCopyWithImpl<$Res>;
  $Res call({NovelEntity novel});

  $NovelEntityCopyWith<$Res> get novel;
}

/// @nodoc
class __$CompleteEntityCopyWithImpl<$Res>
    extends _$NovelEntityArgumentCopyWithImpl<$Res>
    implements _$CompleteEntityCopyWith<$Res> {
  __$CompleteEntityCopyWithImpl(
      _CompleteEntity _value, $Res Function(_CompleteEntity) _then)
      : super(_value, (v) => _then(v as _CompleteEntity));

  @override
  _CompleteEntity get _value => super._value as _CompleteEntity;

  @override
  $Res call({
    Object? novel = freezed,
  }) {
    return _then(_CompleteEntity(
      novel == freezed
          ? _value.novel
          : novel // ignore: cast_nullable_to_non_nullable
              as NovelEntity,
    ));
  }

  @override
  $NovelEntityCopyWith<$Res> get novel {
    return $NovelEntityCopyWith<$Res>(_value.novel, (value) {
      return _then(_value.copyWith(novel: value));
    });
  }
}

/// @nodoc

class _$_CompleteEntity implements _CompleteEntity {
  _$_CompleteEntity(this.novel);

  @override
  final NovelEntity novel;

  @override
  String toString() {
    return 'NovelEntityArgument.complete(novel: $novel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CompleteEntity &&
            const DeepCollectionEquality().equals(other.novel, novel));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(novel));

  @JsonKey(ignore: true)
  @override
  _$CompleteEntityCopyWith<_CompleteEntity> get copyWith =>
      __$CompleteEntityCopyWithImpl<_CompleteEntity>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PartialNovelEntity novel) partial,
    required TResult Function(NovelEntity novel) complete,
  }) {
    return complete(novel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(PartialNovelEntity novel)? partial,
    TResult Function(NovelEntity novel)? complete,
  }) {
    return complete?.call(novel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PartialNovelEntity novel)? partial,
    TResult Function(NovelEntity novel)? complete,
    required TResult orElse(),
  }) {
    if (complete != null) {
      return complete(novel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PartialEntity value) partial,
    required TResult Function(_CompleteEntity value) complete,
  }) {
    return complete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_PartialEntity value)? partial,
    TResult Function(_CompleteEntity value)? complete,
  }) {
    return complete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PartialEntity value)? partial,
    TResult Function(_CompleteEntity value)? complete,
    required TResult orElse(),
  }) {
    if (complete != null) {
      return complete(this);
    }
    return orElse();
  }
}

abstract class _CompleteEntity implements NovelEntityArgument {
  factory _CompleteEntity(NovelEntity novel) = _$_CompleteEntity;

  NovelEntity get novel;
  @JsonKey(ignore: true)
  _$CompleteEntityCopyWith<_CompleteEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
