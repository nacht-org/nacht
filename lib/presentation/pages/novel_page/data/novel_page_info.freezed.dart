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
      required Option<String> author,
      required Option<NovelStatus> status,
      required Option<Meta> meta}) {
    return _NovelPageInfo(
      title: title,
      coverUrl: coverUrl,
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
  Option<String> get author => throw _privateConstructorUsedError;
  Option<NovelStatus> get status => throw _privateConstructorUsedError;
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
      Option<String> author,
      Option<NovelStatus> status,
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
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as Option<String>,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Option<NovelStatus>,
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
      Option<String> author,
      Option<NovelStatus> status,
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
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as Option<String>,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Option<NovelStatus>,
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
      required this.author,
      required this.status,
      required this.meta});

  @override
  final String title;
  @override
  final Option<String> coverUrl;
  @override
  final Option<String> author;
  @override
  final Option<NovelStatus> status;
  @override
  final Option<Meta> meta;

  @override
  String toString() {
    return 'NovelPageInfo(title: $title, coverUrl: $coverUrl, author: $author, status: $status, meta: $meta)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NovelPageInfo &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.coverUrl, coverUrl) &&
            const DeepCollectionEquality().equals(other.author, author) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.meta, meta));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(coverUrl),
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
      required Option<String> author,
      required Option<NovelStatus> status,
      required Option<Meta> meta}) = _$_NovelPageInfo;

  @override
  String get title;
  @override
  Option<String> get coverUrl;
  @override
  Option<String> get author;
  @override
  Option<NovelStatus> get status;
  @override
  Option<Meta> get meta;
  @override
  @JsonKey(ignore: true)
  _$NovelPageInfoCopyWith<_NovelPageInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
