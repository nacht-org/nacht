// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'asset_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AssetDataTearOff {
  const _$AssetDataTearOff();

  _AssetData call(List<int> data, String mimetype, String hash) {
    return _AssetData(
      data,
      mimetype,
      hash,
    );
  }
}

/// @nodoc
const $AssetData = _$AssetDataTearOff();

/// @nodoc
mixin _$AssetData {
  List<int> get bytes => throw _privateConstructorUsedError;
  String get mimetype => throw _privateConstructorUsedError;
  String get hash => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AssetDataCopyWith<AssetData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssetDataCopyWith<$Res> {
  factory $AssetDataCopyWith(AssetData value, $Res Function(AssetData) then) =
      _$AssetDataCopyWithImpl<$Res>;
  $Res call({List<int> data, String mimetype, String hash});
}

/// @nodoc
class _$AssetDataCopyWithImpl<$Res> implements $AssetDataCopyWith<$Res> {
  _$AssetDataCopyWithImpl(this._value, this._then);

  final AssetData _value;
  // ignore: unused_field
  final $Res Function(AssetData) _then;

  @override
  $Res call({
    Object? data = freezed,
    Object? mimetype = freezed,
    Object? hash = freezed,
  }) {
    return _then(_value.copyWith(
      data: data == freezed
          ? _value.bytes
          : data // ignore: cast_nullable_to_non_nullable
              as List<int>,
      mimetype: mimetype == freezed
          ? _value.mimetype
          : mimetype // ignore: cast_nullable_to_non_nullable
              as String,
      hash: hash == freezed
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$AssetDataCopyWith<$Res> implements $AssetDataCopyWith<$Res> {
  factory _$AssetDataCopyWith(
          _AssetData value, $Res Function(_AssetData) then) =
      __$AssetDataCopyWithImpl<$Res>;
  @override
  $Res call({List<int> data, String mimetype, String hash});
}

/// @nodoc
class __$AssetDataCopyWithImpl<$Res> extends _$AssetDataCopyWithImpl<$Res>
    implements _$AssetDataCopyWith<$Res> {
  __$AssetDataCopyWithImpl(_AssetData _value, $Res Function(_AssetData) _then)
      : super(_value, (v) => _then(v as _AssetData));

  @override
  _AssetData get _value => super._value as _AssetData;

  @override
  $Res call({
    Object? data = freezed,
    Object? mimetype = freezed,
    Object? hash = freezed,
  }) {
    return _then(_AssetData(
      data == freezed
          ? _value.bytes
          : data // ignore: cast_nullable_to_non_nullable
              as List<int>,
      mimetype == freezed
          ? _value.mimetype
          : mimetype // ignore: cast_nullable_to_non_nullable
              as String,
      hash == freezed
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_AssetData implements _AssetData {
  _$_AssetData(this.bytes, this.mimetype, this.hash);

  @override
  final List<int> bytes;
  @override
  final String mimetype;
  @override
  final String hash;

  @override
  String toString() {
    return 'AssetData(data: $bytes, mimetype: $mimetype, hash: $hash)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AssetData &&
            const DeepCollectionEquality().equals(other.bytes, bytes) &&
            const DeepCollectionEquality().equals(other.mimetype, mimetype) &&
            const DeepCollectionEquality().equals(other.hash, hash));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(bytes),
      const DeepCollectionEquality().hash(mimetype),
      const DeepCollectionEquality().hash(hash));

  @JsonKey(ignore: true)
  @override
  _$AssetDataCopyWith<_AssetData> get copyWith =>
      __$AssetDataCopyWithImpl<_AssetData>(this, _$identity);
}

abstract class _AssetData implements AssetData {
  factory _AssetData(List<int> data, String mimetype, String hash) =
      _$_AssetData;

  @override
  List<int> get bytes;
  @override
  String get mimetype;
  @override
  String get hash;
  @override
  @JsonKey(ignore: true)
  _$AssetDataCopyWith<_AssetData> get copyWith =>
      throw _privateConstructorUsedError;
}
