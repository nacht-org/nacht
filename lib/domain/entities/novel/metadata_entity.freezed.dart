// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'metadata_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MetaDataEntityTearOff {
  const _$MetaDataEntityTearOff();

  _MetaDataEntity call(
      {required int id,
      required String name,
      required String value,
      required Namespace namespace,
      required Map<String, Object> others,
      required int novelId}) {
    return _MetaDataEntity(
      id: id,
      name: name,
      value: value,
      namespace: namespace,
      others: others,
      novelId: novelId,
    );
  }
}

/// @nodoc
const $MetaDataEntity = _$MetaDataEntityTearOff();

/// @nodoc
mixin _$MetaDataEntity {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  Namespace get namespace => throw _privateConstructorUsedError;
  Map<String, Object> get others => throw _privateConstructorUsedError;
  int get novelId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MetaDataEntityCopyWith<MetaDataEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MetaDataEntityCopyWith<$Res> {
  factory $MetaDataEntityCopyWith(
          MetaDataEntity value, $Res Function(MetaDataEntity) then) =
      _$MetaDataEntityCopyWithImpl<$Res>;
  $Res call(
      {int id,
      String name,
      String value,
      Namespace namespace,
      Map<String, Object> others,
      int novelId});
}

/// @nodoc
class _$MetaDataEntityCopyWithImpl<$Res>
    implements $MetaDataEntityCopyWith<$Res> {
  _$MetaDataEntityCopyWithImpl(this._value, this._then);

  final MetaDataEntity _value;
  // ignore: unused_field
  final $Res Function(MetaDataEntity) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? value = freezed,
    Object? namespace = freezed,
    Object? others = freezed,
    Object? novelId = freezed,
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
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      namespace: namespace == freezed
          ? _value.namespace
          : namespace // ignore: cast_nullable_to_non_nullable
              as Namespace,
      others: others == freezed
          ? _value.others
          : others // ignore: cast_nullable_to_non_nullable
              as Map<String, Object>,
      novelId: novelId == freezed
          ? _value.novelId
          : novelId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$MetaDataEntityCopyWith<$Res>
    implements $MetaDataEntityCopyWith<$Res> {
  factory _$MetaDataEntityCopyWith(
          _MetaDataEntity value, $Res Function(_MetaDataEntity) then) =
      __$MetaDataEntityCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      String name,
      String value,
      Namespace namespace,
      Map<String, Object> others,
      int novelId});
}

/// @nodoc
class __$MetaDataEntityCopyWithImpl<$Res>
    extends _$MetaDataEntityCopyWithImpl<$Res>
    implements _$MetaDataEntityCopyWith<$Res> {
  __$MetaDataEntityCopyWithImpl(
      _MetaDataEntity _value, $Res Function(_MetaDataEntity) _then)
      : super(_value, (v) => _then(v as _MetaDataEntity));

  @override
  _MetaDataEntity get _value => super._value as _MetaDataEntity;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? value = freezed,
    Object? namespace = freezed,
    Object? others = freezed,
    Object? novelId = freezed,
  }) {
    return _then(_MetaDataEntity(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      namespace: namespace == freezed
          ? _value.namespace
          : namespace // ignore: cast_nullable_to_non_nullable
              as Namespace,
      others: others == freezed
          ? _value.others
          : others // ignore: cast_nullable_to_non_nullable
              as Map<String, Object>,
      novelId: novelId == freezed
          ? _value.novelId
          : novelId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_MetaDataEntity implements _MetaDataEntity {
  _$_MetaDataEntity(
      {required this.id,
      required this.name,
      required this.value,
      required this.namespace,
      required this.others,
      required this.novelId});

  @override
  final int id;
  @override
  final String name;
  @override
  final String value;
  @override
  final Namespace namespace;
  @override
  final Map<String, Object> others;
  @override
  final int novelId;

  @override
  String toString() {
    return 'MetaDataEntity(id: $id, name: $name, value: $value, namespace: $namespace, others: $others, novelId: $novelId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MetaDataEntity &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality().equals(other.namespace, namespace) &&
            const DeepCollectionEquality().equals(other.others, others) &&
            const DeepCollectionEquality().equals(other.novelId, novelId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(value),
      const DeepCollectionEquality().hash(namespace),
      const DeepCollectionEquality().hash(others),
      const DeepCollectionEquality().hash(novelId));

  @JsonKey(ignore: true)
  @override
  _$MetaDataEntityCopyWith<_MetaDataEntity> get copyWith =>
      __$MetaDataEntityCopyWithImpl<_MetaDataEntity>(this, _$identity);
}

abstract class _MetaDataEntity implements MetaDataEntity {
  factory _MetaDataEntity(
      {required int id,
      required String name,
      required String value,
      required Namespace namespace,
      required Map<String, Object> others,
      required int novelId}) = _$_MetaDataEntity;

  @override
  int get id;
  @override
  String get name;
  @override
  String get value;
  @override
  Namespace get namespace;
  @override
  Map<String, Object> get others;
  @override
  int get novelId;
  @override
  @JsonKey(ignore: true)
  _$MetaDataEntityCopyWith<_MetaDataEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
