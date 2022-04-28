// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'asset_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AssetEntityTearOff {
  const _$AssetEntityTearOff();

  _AssetEntity call(
      {required int id, required String path, required String mimetype}) {
    return _AssetEntity(
      id: id,
      path: path,
      mimetype: mimetype,
    );
  }
}

/// @nodoc
const $AssetEntity = _$AssetEntityTearOff();

/// @nodoc
mixin _$AssetEntity {
  int get id => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  String get mimetype => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AssetEntityCopyWith<AssetEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssetEntityCopyWith<$Res> {
  factory $AssetEntityCopyWith(
          AssetEntity value, $Res Function(AssetEntity) then) =
      _$AssetEntityCopyWithImpl<$Res>;
  $Res call({int id, String path, String mimetype});
}

/// @nodoc
class _$AssetEntityCopyWithImpl<$Res> implements $AssetEntityCopyWith<$Res> {
  _$AssetEntityCopyWithImpl(this._value, this._then);

  final AssetEntity _value;
  // ignore: unused_field
  final $Res Function(AssetEntity) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? path = freezed,
    Object? mimetype = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      mimetype: mimetype == freezed
          ? _value.mimetype
          : mimetype // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$AssetEntityCopyWith<$Res>
    implements $AssetEntityCopyWith<$Res> {
  factory _$AssetEntityCopyWith(
          _AssetEntity value, $Res Function(_AssetEntity) then) =
      __$AssetEntityCopyWithImpl<$Res>;
  @override
  $Res call({int id, String path, String mimetype});
}

/// @nodoc
class __$AssetEntityCopyWithImpl<$Res> extends _$AssetEntityCopyWithImpl<$Res>
    implements _$AssetEntityCopyWith<$Res> {
  __$AssetEntityCopyWithImpl(
      _AssetEntity _value, $Res Function(_AssetEntity) _then)
      : super(_value, (v) => _then(v as _AssetEntity));

  @override
  _AssetEntity get _value => super._value as _AssetEntity;

  @override
  $Res call({
    Object? id = freezed,
    Object? path = freezed,
    Object? mimetype = freezed,
  }) {
    return _then(_AssetEntity(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      mimetype: mimetype == freezed
          ? _value.mimetype
          : mimetype // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_AssetEntity implements _AssetEntity {
  _$_AssetEntity(
      {required this.id, required this.path, required this.mimetype});

  @override
  final int id;
  @override
  final String path;
  @override
  final String mimetype;

  @override
  String toString() {
    return 'AssetEntity(id: $id, path: $path, mimetype: $mimetype)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AssetEntity &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.path, path) &&
            const DeepCollectionEquality().equals(other.mimetype, mimetype));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(path),
      const DeepCollectionEquality().hash(mimetype));

  @JsonKey(ignore: true)
  @override
  _$AssetEntityCopyWith<_AssetEntity> get copyWith =>
      __$AssetEntityCopyWithImpl<_AssetEntity>(this, _$identity);
}

abstract class _AssetEntity implements AssetEntity {
  factory _AssetEntity(
      {required int id,
      required String path,
      required String mimetype}) = _$_AssetEntity;

  @override
  int get id;
  @override
  String get path;
  @override
  String get mimetype;
  @override
  @JsonKey(ignore: true)
  _$AssetEntityCopyWith<_AssetEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
