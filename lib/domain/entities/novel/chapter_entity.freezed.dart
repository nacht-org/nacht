// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'chapter_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ChapterEntityTearOff {
  const _$ChapterEntityTearOff();

  _ChapterEntity call(
      {required int id,
      required int index,
      required String title,
      required String? content,
      required String url,
      required DateTime? updated,
      required int volumeId}) {
    return _ChapterEntity(
      id: id,
      index: index,
      title: title,
      content: content,
      url: url,
      updated: updated,
      volumeId: volumeId,
    );
  }
}

/// @nodoc
const $ChapterEntity = _$ChapterEntityTearOff();

/// @nodoc
mixin _$ChapterEntity {
  int get id => throw _privateConstructorUsedError;
  int get index => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  DateTime? get updated => throw _privateConstructorUsedError;
  int get volumeId => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChapterEntityCopyWith<ChapterEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChapterEntityCopyWith<$Res> {
  factory $ChapterEntityCopyWith(
          ChapterEntity value, $Res Function(ChapterEntity) then) =
      _$ChapterEntityCopyWithImpl<$Res>;
  $Res call(
      {int id,
      int index,
      String title,
      String? content,
      String url,
      DateTime? updated,
      int volumeId});
}

/// @nodoc
class _$ChapterEntityCopyWithImpl<$Res>
    implements $ChapterEntityCopyWith<$Res> {
  _$ChapterEntityCopyWithImpl(this._value, this._then);

  final ChapterEntity _value;
  // ignore: unused_field
  final $Res Function(ChapterEntity) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? index = freezed,
    Object? title = freezed,
    Object? content = freezed,
    Object? url = freezed,
    Object? updated = freezed,
    Object? volumeId = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      updated: updated == freezed
          ? _value.updated
          : updated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      volumeId: volumeId == freezed
          ? _value.volumeId
          : volumeId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$ChapterEntityCopyWith<$Res>
    implements $ChapterEntityCopyWith<$Res> {
  factory _$ChapterEntityCopyWith(
          _ChapterEntity value, $Res Function(_ChapterEntity) then) =
      __$ChapterEntityCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      int index,
      String title,
      String? content,
      String url,
      DateTime? updated,
      int volumeId});
}

/// @nodoc
class __$ChapterEntityCopyWithImpl<$Res>
    extends _$ChapterEntityCopyWithImpl<$Res>
    implements _$ChapterEntityCopyWith<$Res> {
  __$ChapterEntityCopyWithImpl(
      _ChapterEntity _value, $Res Function(_ChapterEntity) _then)
      : super(_value, (v) => _then(v as _ChapterEntity));

  @override
  _ChapterEntity get _value => super._value as _ChapterEntity;

  @override
  $Res call({
    Object? id = freezed,
    Object? index = freezed,
    Object? title = freezed,
    Object? content = freezed,
    Object? url = freezed,
    Object? updated = freezed,
    Object? volumeId = freezed,
  }) {
    return _then(_ChapterEntity(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      index: index == freezed
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: content == freezed
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      updated: updated == freezed
          ? _value.updated
          : updated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      volumeId: volumeId == freezed
          ? _value.volumeId
          : volumeId // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_ChapterEntity implements _ChapterEntity {
  _$_ChapterEntity(
      {required this.id,
      required this.index,
      required this.title,
      required this.content,
      required this.url,
      required this.updated,
      required this.volumeId});

  @override
  final int id;
  @override
  final int index;
  @override
  final String title;
  @override
  final String? content;
  @override
  final String url;
  @override
  final DateTime? updated;
  @override
  final int volumeId;

  @override
  String toString() {
    return 'ChapterEntity(id: $id, index: $index, title: $title, content: $content, url: $url, updated: $updated, volumeId: $volumeId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChapterEntity &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.index, index) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.content, content) &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality().equals(other.updated, updated) &&
            const DeepCollectionEquality().equals(other.volumeId, volumeId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(index),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(content),
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(updated),
      const DeepCollectionEquality().hash(volumeId));

  @JsonKey(ignore: true)
  @override
  _$ChapterEntityCopyWith<_ChapterEntity> get copyWith =>
      __$ChapterEntityCopyWithImpl<_ChapterEntity>(this, _$identity);
}

abstract class _ChapterEntity implements ChapterEntity {
  factory _ChapterEntity(
      {required int id,
      required int index,
      required String title,
      required String? content,
      required String url,
      required DateTime? updated,
      required int volumeId}) = _$_ChapterEntity;

  @override
  int get id;
  @override
  int get index;
  @override
  String get title;
  @override
  String? get content;
  @override
  String get url;
  @override
  DateTime? get updated;
  @override
  int get volumeId;
  @override
  @JsonKey(ignore: true)
  _$ChapterEntityCopyWith<_ChapterEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
