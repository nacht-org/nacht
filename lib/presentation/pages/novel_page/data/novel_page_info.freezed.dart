// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'novel_page_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$NovelPageInfoTearOff {
  const _$NovelPageInfoTearOff();

  _NovelPageInfo call(
      {required String title,
      required Option<String> coverUrl,
      required Option<AssetEntity> cover,
      required Option<String> author,
      required NovelStatus status,
      required Option<Meta> meta}) {
    return _NovelPageInfo(
      title: title,
      coverUrl: coverUrl,
      cover: cover,
      author: author,
      status: status,
      meta: meta,
    );
  }
}

/// @nodoc
const $NovelPageInfo = _$NovelPageInfoTearOff();

/// @nodoc
mixin _$NovelPageInfo {
  String get title => throw _privateConstructorUsedError;
  Option<String> get coverUrl => throw _privateConstructorUsedError;
  Option<AssetEntity> get cover => throw _privateConstructorUsedError;
  Option<String> get author => throw _privateConstructorUsedError;
  NovelStatus get status => throw _privateConstructorUsedError;
  Option<Meta> get meta => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NovelPageInfoCopyWith<NovelPageInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NovelPageInfoCopyWith<$Res> {
  factory $NovelPageInfoCopyWith(
          NovelPageInfo value, $Res Function(NovelPageInfo) then) =
      _$NovelPageInfoCopyWithImpl<$Res>;
  $Res call(
      {String title,
      Option<String> coverUrl,
      Option<AssetEntity> cover,
      Option<String> author,
      NovelStatus status,
      Option<Meta> meta});
}

/// @nodoc
class _$NovelPageInfoCopyWithImpl<$Res>
    implements $NovelPageInfoCopyWith<$Res> {
  _$NovelPageInfoCopyWithImpl(this._value, this._then);

  final NovelPageInfo _value;
  // ignore: unused_field
  final $Res Function(NovelPageInfo) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? coverUrl = freezed,
    Object? cover = freezed,
    Object? author = freezed,
    Object? status = freezed,
    Object? meta = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      coverUrl: coverUrl == freezed
          ? _value.coverUrl
          : coverUrl // ignore: cast_nullable_to_non_nullable
              as Option<String>,
      cover: cover == freezed
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as Option<AssetEntity>,
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as Option<String>,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as NovelStatus,
      meta: meta == freezed
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as Option<Meta>,
    ));
  }
}

/// @nodoc
abstract class _$NovelPageInfoCopyWith<$Res>
    implements $NovelPageInfoCopyWith<$Res> {
  factory _$NovelPageInfoCopyWith(
          _NovelPageInfo value, $Res Function(_NovelPageInfo) then) =
      __$NovelPageInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String title,
      Option<String> coverUrl,
      Option<AssetEntity> cover,
      Option<String> author,
      NovelStatus status,
      Option<Meta> meta});
}

/// @nodoc
class __$NovelPageInfoCopyWithImpl<$Res>
    extends _$NovelPageInfoCopyWithImpl<$Res>
    implements _$NovelPageInfoCopyWith<$Res> {
  __$NovelPageInfoCopyWithImpl(
      _NovelPageInfo _value, $Res Function(_NovelPageInfo) _then)
      : super(_value, (v) => _then(v as _NovelPageInfo));

  @override
  _NovelPageInfo get _value => super._value as _NovelPageInfo;

  @override
  $Res call({
    Object? title = freezed,
    Object? coverUrl = freezed,
    Object? cover = freezed,
    Object? author = freezed,
    Object? status = freezed,
    Object? meta = freezed,
  }) {
    return _then(_NovelPageInfo(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      coverUrl: coverUrl == freezed
          ? _value.coverUrl
          : coverUrl // ignore: cast_nullable_to_non_nullable
              as Option<String>,
      cover: cover == freezed
          ? _value.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as Option<AssetEntity>,
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as Option<String>,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as NovelStatus,
      meta: meta == freezed
          ? _value.meta
          : meta // ignore: cast_nullable_to_non_nullable
              as Option<Meta>,
    ));
  }
}

/// @nodoc

class _$_NovelPageInfo implements _NovelPageInfo {
  _$_NovelPageInfo(
      {required this.title,
      required this.coverUrl,
      required this.cover,
      required this.author,
      required this.status,
      required this.meta});

  @override
  final String title;
  @override
  final Option<String> coverUrl;
  @override
  final Option<AssetEntity> cover;
  @override
  final Option<String> author;
  @override
  final NovelStatus status;
  @override
  final Option<Meta> meta;

  @override
  String toString() {
    return 'NovelPageInfo(title: $title, coverUrl: $coverUrl, cover: $cover, author: $author, status: $status, meta: $meta)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NovelPageInfo &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.coverUrl, coverUrl) &&
            const DeepCollectionEquality().equals(other.cover, cover) &&
            const DeepCollectionEquality().equals(other.author, author) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.meta, meta));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(coverUrl),
      const DeepCollectionEquality().hash(cover),
      const DeepCollectionEquality().hash(author),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(meta));

  @JsonKey(ignore: true)
  @override
  _$NovelPageInfoCopyWith<_NovelPageInfo> get copyWith =>
      __$NovelPageInfoCopyWithImpl<_NovelPageInfo>(this, _$identity);
}

abstract class _NovelPageInfo implements NovelPageInfo {
  factory _NovelPageInfo(
      {required String title,
      required Option<String> coverUrl,
      required Option<AssetEntity> cover,
      required Option<String> author,
      required NovelStatus status,
      required Option<Meta> meta}) = _$_NovelPageInfo;

  @override
  String get title;
  @override
  Option<String> get coverUrl;
  @override
  Option<AssetEntity> get cover;
  @override
  Option<String> get author;
  @override
  NovelStatus get status;
  @override
  Option<Meta> get meta;
  @override
  @JsonKey(ignore: true)
  _$NovelPageInfoCopyWith<_NovelPageInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$NovelPageMoreTearOff {
  const _$NovelPageMoreTearOff();

  _NovelPageMore call(
      {required List<String> description, required List<String> tags}) {
    return _NovelPageMore(
      description: description,
      tags: tags,
    );
  }
}

/// @nodoc
const $NovelPageMore = _$NovelPageMoreTearOff();

/// @nodoc
mixin _$NovelPageMore {
  List<String> get description => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NovelPageMoreCopyWith<NovelPageMore> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NovelPageMoreCopyWith<$Res> {
  factory $NovelPageMoreCopyWith(
          NovelPageMore value, $Res Function(NovelPageMore) then) =
      _$NovelPageMoreCopyWithImpl<$Res>;
  $Res call({List<String> description, List<String> tags});
}

/// @nodoc
class _$NovelPageMoreCopyWithImpl<$Res>
    implements $NovelPageMoreCopyWith<$Res> {
  _$NovelPageMoreCopyWithImpl(this._value, this._then);

  final NovelPageMore _value;
  // ignore: unused_field
  final $Res Function(NovelPageMore) _then;

  @override
  $Res call({
    Object? description = freezed,
    Object? tags = freezed,
  }) {
    return _then(_value.copyWith(
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$NovelPageMoreCopyWith<$Res>
    implements $NovelPageMoreCopyWith<$Res> {
  factory _$NovelPageMoreCopyWith(
          _NovelPageMore value, $Res Function(_NovelPageMore) then) =
      __$NovelPageMoreCopyWithImpl<$Res>;
  @override
  $Res call({List<String> description, List<String> tags});
}

/// @nodoc
class __$NovelPageMoreCopyWithImpl<$Res>
    extends _$NovelPageMoreCopyWithImpl<$Res>
    implements _$NovelPageMoreCopyWith<$Res> {
  __$NovelPageMoreCopyWithImpl(
      _NovelPageMore _value, $Res Function(_NovelPageMore) _then)
      : super(_value, (v) => _then(v as _NovelPageMore));

  @override
  _NovelPageMore get _value => super._value as _NovelPageMore;

  @override
  $Res call({
    Object? description = freezed,
    Object? tags = freezed,
  }) {
    return _then(_NovelPageMore(
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_NovelPageMore implements _NovelPageMore {
  _$_NovelPageMore({required this.description, required this.tags});

  @override
  final List<String> description;
  @override
  final List<String> tags;

  @override
  String toString() {
    return 'NovelPageMore(description: $description, tags: $tags)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NovelPageMore &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.tags, tags));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(tags));

  @JsonKey(ignore: true)
  @override
  _$NovelPageMoreCopyWith<_NovelPageMore> get copyWith =>
      __$NovelPageMoreCopyWithImpl<_NovelPageMore>(this, _$identity);
}

abstract class _NovelPageMore implements NovelPageMore {
  factory _NovelPageMore(
      {required List<String> description,
      required List<String> tags}) = _$_NovelPageMore;

  @override
  List<String> get description;
  @override
  List<String> get tags;
  @override
  @JsonKey(ignore: true)
  _$NovelPageMoreCopyWith<_NovelPageMore> get copyWith =>
      throw _privateConstructorUsedError;
}
