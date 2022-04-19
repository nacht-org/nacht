// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'partial_novel_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PartialNovelEntityTearOff {
  const _$PartialNovelEntityTearOff();

  _PartialNovelEntity call(
      {required String title,
      required String url,
      String? thumbnailUrl,
      String? author}) {
    return _PartialNovelEntity(
      title: title,
      url: url,
      thumbnailUrl: thumbnailUrl,
      author: author,
    );
  }
}

/// @nodoc
const $PartialNovelEntity = _$PartialNovelEntityTearOff();

/// @nodoc
mixin _$PartialNovelEntity {
  String get title => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String? get thumbnailUrl => throw _privateConstructorUsedError;
  String? get author => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PartialNovelEntityCopyWith<PartialNovelEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartialNovelEntityCopyWith<$Res> {
  factory $PartialNovelEntityCopyWith(
          PartialNovelEntity value, $Res Function(PartialNovelEntity) then) =
      _$PartialNovelEntityCopyWithImpl<$Res>;
  $Res call({String title, String url, String? thumbnailUrl, String? author});
}

/// @nodoc
class _$PartialNovelEntityCopyWithImpl<$Res>
    implements $PartialNovelEntityCopyWith<$Res> {
  _$PartialNovelEntityCopyWithImpl(this._value, this._then);

  final PartialNovelEntity _value;
  // ignore: unused_field
  final $Res Function(PartialNovelEntity) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? url = freezed,
    Object? thumbnailUrl = freezed,
    Object? author = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: thumbnailUrl == freezed
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$PartialNovelEntityCopyWith<$Res>
    implements $PartialNovelEntityCopyWith<$Res> {
  factory _$PartialNovelEntityCopyWith(
          _PartialNovelEntity value, $Res Function(_PartialNovelEntity) then) =
      __$PartialNovelEntityCopyWithImpl<$Res>;
  @override
  $Res call({String title, String url, String? thumbnailUrl, String? author});
}

/// @nodoc
class __$PartialNovelEntityCopyWithImpl<$Res>
    extends _$PartialNovelEntityCopyWithImpl<$Res>
    implements _$PartialNovelEntityCopyWith<$Res> {
  __$PartialNovelEntityCopyWithImpl(
      _PartialNovelEntity _value, $Res Function(_PartialNovelEntity) _then)
      : super(_value, (v) => _then(v as _PartialNovelEntity));

  @override
  _PartialNovelEntity get _value => super._value as _PartialNovelEntity;

  @override
  $Res call({
    Object? title = freezed,
    Object? url = freezed,
    Object? thumbnailUrl = freezed,
    Object? author = freezed,
  }) {
    return _then(_PartialNovelEntity(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: thumbnailUrl == freezed
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_PartialNovelEntity implements _PartialNovelEntity {
  _$_PartialNovelEntity(
      {required this.title, required this.url, this.thumbnailUrl, this.author});

  @override
  final String title;
  @override
  final String url;
  @override
  final String? thumbnailUrl;
  @override
  final String? author;

  @override
  String toString() {
    return 'PartialNovelEntity(title: $title, url: $url, thumbnailUrl: $thumbnailUrl, author: $author)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PartialNovelEntity &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality()
                .equals(other.thumbnailUrl, thumbnailUrl) &&
            const DeepCollectionEquality().equals(other.author, author));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(thumbnailUrl),
      const DeepCollectionEquality().hash(author));

  @JsonKey(ignore: true)
  @override
  _$PartialNovelEntityCopyWith<_PartialNovelEntity> get copyWith =>
      __$PartialNovelEntityCopyWithImpl<_PartialNovelEntity>(this, _$identity);
}

abstract class _PartialNovelEntity implements PartialNovelEntity {
  factory _PartialNovelEntity(
      {required String title,
      required String url,
      String? thumbnailUrl,
      String? author}) = _$_PartialNovelEntity;

  @override
  String get title;
  @override
  String get url;
  @override
  String? get thumbnailUrl;
  @override
  String? get author;
  @override
  @JsonKey(ignore: true)
  _$PartialNovelEntityCopyWith<_PartialNovelEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
