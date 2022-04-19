// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'novel_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$NovelEntityTearOff {
  const _$NovelEntityTearOff();

  _NovelEntity call(
      {required int? id,
      required String title,
      required String url,
      required String? author,
      required List<String> description,
      required String? thumbnailUrl,
      required NovelStatus status,
      required String lang,
      required List<VolumeEntity> volumes,
      required List<MetaData> metadata,
      required WorkType workType,
      required ReadingDirection readingDirection}) {
    return _NovelEntity(
      id: id,
      title: title,
      url: url,
      author: author,
      description: description,
      thumbnailUrl: thumbnailUrl,
      status: status,
      lang: lang,
      volumes: volumes,
      metadata: metadata,
      workType: workType,
      readingDirection: readingDirection,
    );
  }
}

/// @nodoc
const $NovelEntity = _$NovelEntityTearOff();

/// @nodoc
mixin _$NovelEntity {
  int? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String? get author => throw _privateConstructorUsedError;
  List<String> get description => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  NovelStatus get status => throw _privateConstructorUsedError;
  String get lang => throw _privateConstructorUsedError;
  List<VolumeEntity> get volumes => throw _privateConstructorUsedError;
  List<MetaData> get metadata => throw _privateConstructorUsedError;
  WorkType get workType => throw _privateConstructorUsedError;
  ReadingDirection get readingDirection => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NovelEntityCopyWith<NovelEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NovelEntityCopyWith<$Res> {
  factory $NovelEntityCopyWith(
          NovelEntity value, $Res Function(NovelEntity) then) =
      _$NovelEntityCopyWithImpl<$Res>;
  $Res call(
      {int? id,
      String title,
      String url,
      String? author,
      List<String> description,
      String? thumbnailUrl,
      NovelStatus status,
      String lang,
      List<VolumeEntity> volumes,
      List<MetaData> metadata,
      WorkType workType,
      ReadingDirection readingDirection});
}

/// @nodoc
class _$NovelEntityCopyWithImpl<$Res> implements $NovelEntityCopyWith<$Res> {
  _$NovelEntityCopyWithImpl(this._value, this._then);

  final NovelEntity _value;
  // ignore: unused_field
  final $Res Function(NovelEntity) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? url = freezed,
    Object? author = freezed,
    Object? description = freezed,
    Object? thumbnailUrl = freezed,
    Object? status = freezed,
    Object? lang = freezed,
    Object? volumes = freezed,
    Object? metadata = freezed,
    Object? workType = freezed,
    Object? readingDirection = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as List<String>,
      thumbnailUrl: thumbnailUrl == freezed
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as NovelStatus,
      lang: lang == freezed
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String,
      volumes: volumes == freezed
          ? _value.volumes
          : volumes // ignore: cast_nullable_to_non_nullable
              as List<VolumeEntity>,
      metadata: metadata == freezed
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as List<MetaData>,
      workType: workType == freezed
          ? _value.workType
          : workType // ignore: cast_nullable_to_non_nullable
              as WorkType,
      readingDirection: readingDirection == freezed
          ? _value.readingDirection
          : readingDirection // ignore: cast_nullable_to_non_nullable
              as ReadingDirection,
    ));
  }
}

/// @nodoc
abstract class _$NovelEntityCopyWith<$Res>
    implements $NovelEntityCopyWith<$Res> {
  factory _$NovelEntityCopyWith(
          _NovelEntity value, $Res Function(_NovelEntity) then) =
      __$NovelEntityCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? id,
      String title,
      String url,
      String? author,
      List<String> description,
      String? thumbnailUrl,
      NovelStatus status,
      String lang,
      List<VolumeEntity> volumes,
      List<MetaData> metadata,
      WorkType workType,
      ReadingDirection readingDirection});
}

/// @nodoc
class __$NovelEntityCopyWithImpl<$Res> extends _$NovelEntityCopyWithImpl<$Res>
    implements _$NovelEntityCopyWith<$Res> {
  __$NovelEntityCopyWithImpl(
      _NovelEntity _value, $Res Function(_NovelEntity) _then)
      : super(_value, (v) => _then(v as _NovelEntity));

  @override
  _NovelEntity get _value => super._value as _NovelEntity;

  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? url = freezed,
    Object? author = freezed,
    Object? description = freezed,
    Object? thumbnailUrl = freezed,
    Object? status = freezed,
    Object? lang = freezed,
    Object? volumes = freezed,
    Object? metadata = freezed,
    Object? workType = freezed,
    Object? readingDirection = freezed,
  }) {
    return _then(_NovelEntity(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as List<String>,
      thumbnailUrl: thumbnailUrl == freezed
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as NovelStatus,
      lang: lang == freezed
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String,
      volumes: volumes == freezed
          ? _value.volumes
          : volumes // ignore: cast_nullable_to_non_nullable
              as List<VolumeEntity>,
      metadata: metadata == freezed
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as List<MetaData>,
      workType: workType == freezed
          ? _value.workType
          : workType // ignore: cast_nullable_to_non_nullable
              as WorkType,
      readingDirection: readingDirection == freezed
          ? _value.readingDirection
          : readingDirection // ignore: cast_nullable_to_non_nullable
              as ReadingDirection,
    ));
  }
}

/// @nodoc

class _$_NovelEntity implements _NovelEntity {
  _$_NovelEntity(
      {required this.id,
      required this.title,
      required this.url,
      required this.author,
      required this.description,
      required this.thumbnailUrl,
      required this.status,
      required this.lang,
      required this.volumes,
      required this.metadata,
      required this.workType,
      required this.readingDirection});

  @override
  final int? id;
  @override
  final String title;
  @override
  final String url;
  @override
  final String? author;
  @override
  final List<String> description;
  @override
  final String? thumbnailUrl;
  @override
  final NovelStatus status;
  @override
  final String lang;
  @override
  final List<VolumeEntity> volumes;
  @override
  final List<MetaData> metadata;
  @override
  final WorkType workType;
  @override
  final ReadingDirection readingDirection;

  @override
  String toString() {
    return 'NovelEntity(id: $id, title: $title, url: $url, author: $author, description: $description, thumbnailUrl: $thumbnailUrl, status: $status, lang: $lang, volumes: $volumes, metadata: $metadata, workType: $workType, readingDirection: $readingDirection)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NovelEntity &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality().equals(other.author, author) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality()
                .equals(other.thumbnailUrl, thumbnailUrl) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.lang, lang) &&
            const DeepCollectionEquality().equals(other.volumes, volumes) &&
            const DeepCollectionEquality().equals(other.metadata, metadata) &&
            const DeepCollectionEquality().equals(other.workType, workType) &&
            const DeepCollectionEquality()
                .equals(other.readingDirection, readingDirection));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(author),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(thumbnailUrl),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(lang),
      const DeepCollectionEquality().hash(volumes),
      const DeepCollectionEquality().hash(metadata),
      const DeepCollectionEquality().hash(workType),
      const DeepCollectionEquality().hash(readingDirection));

  @JsonKey(ignore: true)
  @override
  _$NovelEntityCopyWith<_NovelEntity> get copyWith =>
      __$NovelEntityCopyWithImpl<_NovelEntity>(this, _$identity);
}

abstract class _NovelEntity implements NovelEntity {
  factory _NovelEntity(
      {required int? id,
      required String title,
      required String url,
      required String? author,
      required List<String> description,
      required String? thumbnailUrl,
      required NovelStatus status,
      required String lang,
      required List<VolumeEntity> volumes,
      required List<MetaData> metadata,
      required WorkType workType,
      required ReadingDirection readingDirection}) = _$_NovelEntity;

  @override
  int? get id;
  @override
  String get title;
  @override
  String get url;
  @override
  String? get author;
  @override
  List<String> get description;
  @override
  String? get thumbnailUrl;
  @override
  NovelStatus get status;
  @override
  String get lang;
  @override
  List<VolumeEntity> get volumes;
  @override
  List<MetaData> get metadata;
  @override
  WorkType get workType;
  @override
  ReadingDirection get readingDirection;
  @override
  @JsonKey(ignore: true)
  _$NovelEntityCopyWith<_NovelEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
