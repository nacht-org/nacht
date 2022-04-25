// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'category_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CategoryEntityTearOff {
  const _$CategoryEntityTearOff();

  _CategoryEntity call(
      {required int id, required String name, required bool isDefault}) {
    return _CategoryEntity(
      id: id,
      name: name,
      isDefault: isDefault,
    );
  }
}

/// @nodoc
const $CategoryEntity = _$CategoryEntityTearOff();

/// @nodoc
mixin _$CategoryEntity {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  bool get isDefault => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CategoryEntityCopyWith<CategoryEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryEntityCopyWith<$Res> {
  factory $CategoryEntityCopyWith(
          CategoryEntity value, $Res Function(CategoryEntity) then) =
      _$CategoryEntityCopyWithImpl<$Res>;
  $Res call({int id, String name, bool isDefault});
}

/// @nodoc
class _$CategoryEntityCopyWithImpl<$Res>
    implements $CategoryEntityCopyWith<$Res> {
  _$CategoryEntityCopyWithImpl(this._value, this._then);

  final CategoryEntity _value;
  // ignore: unused_field
  final $Res Function(CategoryEntity) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? isDefault = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isDefault: isDefault == freezed
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$CategoryEntityCopyWith<$Res>
    implements $CategoryEntityCopyWith<$Res> {
  factory _$CategoryEntityCopyWith(
          _CategoryEntity value, $Res Function(_CategoryEntity) then) =
      __$CategoryEntityCopyWithImpl<$Res>;
  @override
  $Res call({int id, String name, bool isDefault});
}

/// @nodoc
class __$CategoryEntityCopyWithImpl<$Res>
    extends _$CategoryEntityCopyWithImpl<$Res>
    implements _$CategoryEntityCopyWith<$Res> {
  __$CategoryEntityCopyWithImpl(
      _CategoryEntity _value, $Res Function(_CategoryEntity) _then)
      : super(_value, (v) => _then(v as _CategoryEntity));

  @override
  _CategoryEntity get _value => super._value as _CategoryEntity;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? isDefault = freezed,
  }) {
    return _then(_CategoryEntity(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      isDefault: isDefault == freezed
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_CategoryEntity implements _CategoryEntity {
  _$_CategoryEntity(
      {required this.id, required this.name, required this.isDefault});

  @override
  final int id;
  @override
  final String name;
  @override
  final bool isDefault;

  @override
  String toString() {
    return 'CategoryEntity(id: $id, name: $name, isDefault: $isDefault)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CategoryEntity &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.isDefault, isDefault));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(isDefault));

  @JsonKey(ignore: true)
  @override
  _$CategoryEntityCopyWith<_CategoryEntity> get copyWith =>
      __$CategoryEntityCopyWithImpl<_CategoryEntity>(this, _$identity);
}

abstract class _CategoryEntity implements CategoryEntity {
  factory _CategoryEntity(
      {required int id,
      required String name,
      required bool isDefault}) = _$_CategoryEntity;

  @override
  int get id;
  @override
  String get name;
  @override
  bool get isDefault;
  @override
  @JsonKey(ignore: true)
  _$CategoryEntityCopyWith<_CategoryEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
