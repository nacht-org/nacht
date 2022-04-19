// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'volume_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$VolumeEntityTearOff {
  const _$VolumeEntityTearOff();

  _VolumeEntity call(
      {required int? id,
      required int index,
      required String name,
      required List<ChapterEntity> chapters,
      required int? novelId}) {
    return _VolumeEntity(
      id: id,
      index: index,
      name: name,
      chapters: chapters,
      novelId: novelId,
    );
  }
}

/// @nodoc
const $VolumeEntity = _$VolumeEntityTearOff();

/// @nodoc
mixin _$VolumeEntity {
  int? get id => throw _privateConstructorUsedError;
  int get index => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<ChapterEntity> get chapters => throw _privateConstructorUsedError;
  int? get novelId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $VolumeEntityCopyWith<VolumeEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VolumeEntityCopyWith<$Res> {
  factory $VolumeEntityCopyWith(
          VolumeEntity value, $Res Function(VolumeEntity) then) =
      _$VolumeEntityCopyWithImpl<$Res>;
  $Res call(
      {int? id,
      int index,
      String name,
      List<ChapterEntity> chapters,
      int? novelId});
}

/// @nodoc
class _$VolumeEntityCopyWithImpl<$Res> implements $VolumeEntityCopyWith<$Res> {
  _$VolumeEntityCopyWithImpl(this._value, this._then);

  final VolumeEntity _value;
  // ignore: unused_field
  final $Res Function(VolumeEntity) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? index = freezed,
    Object? name = freezed,
    Object? chapters = freezed,
    Object? novelId = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      chapters: chapters == freezed
          ? _value.chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as List<ChapterEntity>,
      novelId: novelId == freezed
          ? _value.novelId
          : novelId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$VolumeEntityCopyWith<$Res>
    implements $VolumeEntityCopyWith<$Res> {
  factory _$VolumeEntityCopyWith(
          _VolumeEntity value, $Res Function(_VolumeEntity) then) =
      __$VolumeEntityCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? id,
      int index,
      String name,
      List<ChapterEntity> chapters,
      int? novelId});
}

/// @nodoc
class __$VolumeEntityCopyWithImpl<$Res> extends _$VolumeEntityCopyWithImpl<$Res>
    implements _$VolumeEntityCopyWith<$Res> {
  __$VolumeEntityCopyWithImpl(
      _VolumeEntity _value, $Res Function(_VolumeEntity) _then)
      : super(_value, (v) => _then(v as _VolumeEntity));

  @override
  _VolumeEntity get _value => super._value as _VolumeEntity;

  @override
  $Res call({
    Object? id = freezed,
    Object? index = freezed,
    Object? name = freezed,
    Object? chapters = freezed,
    Object? novelId = freezed,
  }) {
    return _then(_VolumeEntity(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      chapters: chapters == freezed
          ? _value.chapters
          : chapters // ignore: cast_nullable_to_non_nullable
              as List<ChapterEntity>,
      novelId: novelId == freezed
          ? _value.novelId
          : novelId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$_VolumeEntity implements _VolumeEntity {
  _$_VolumeEntity(
      {required this.id,
      required this.index,
      required this.name,
      required this.chapters,
      required this.novelId});

  @override
  final int? id;
  @override
  final int index;
  @override
  final String name;
  @override
  final List<ChapterEntity> chapters;
  @override
  final int? novelId;

  @override
  String toString() {
    return 'VolumeEntity(id: $id, index: $index, name: $name, chapters: $chapters, novelId: $novelId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _VolumeEntity &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.index, index) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.chapters, chapters) &&
            const DeepCollectionEquality().equals(other.novelId, novelId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(index),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(chapters),
      const DeepCollectionEquality().hash(novelId));

  @JsonKey(ignore: true)
  @override
  _$VolumeEntityCopyWith<_VolumeEntity> get copyWith =>
      __$VolumeEntityCopyWithImpl<_VolumeEntity>(this, _$identity);
}

abstract class _VolumeEntity implements VolumeEntity {
  factory _VolumeEntity(
      {required int? id,
      required int index,
      required String name,
      required List<ChapterEntity> chapters,
      required int? novelId}) = _$_VolumeEntity;

  @override
  int? get id;
  @override
  int get index;
  @override
  String get name;
  @override
  List<ChapterEntity> get chapters;
  @override
  int? get novelId;
  @override
  @JsonKey(ignore: true)
  _$VolumeEntityCopyWith<_VolumeEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
