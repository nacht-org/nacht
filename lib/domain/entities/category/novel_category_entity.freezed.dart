// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'novel_category_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$NovelCategoryEntityTearOff {
  const _$NovelCategoryEntityTearOff();

  _NovelCategoryEntity call(CategoryEntity category, List<NovelEntity> novels) {
    return _NovelCategoryEntity(
      category,
      novels,
    );
  }
}

/// @nodoc
const $NovelCategoryEntity = _$NovelCategoryEntityTearOff();

/// @nodoc
mixin _$NovelCategoryEntity {
  CategoryEntity get category => throw _privateConstructorUsedError;
  List<NovelEntity> get novels => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NovelCategoryEntityCopyWith<NovelCategoryEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NovelCategoryEntityCopyWith<$Res> {
  factory $NovelCategoryEntityCopyWith(
          NovelCategoryEntity value, $Res Function(NovelCategoryEntity) then) =
      _$NovelCategoryEntityCopyWithImpl<$Res>;
  $Res call({CategoryEntity category, List<NovelEntity> novels});

  $CategoryEntityCopyWith<$Res> get category;
}

/// @nodoc
class _$NovelCategoryEntityCopyWithImpl<$Res>
    implements $NovelCategoryEntityCopyWith<$Res> {
  _$NovelCategoryEntityCopyWithImpl(this._value, this._then);

  final NovelCategoryEntity _value;
  // ignore: unused_field
  final $Res Function(NovelCategoryEntity) _then;

  @override
  $Res call({
    Object? category = freezed,
    Object? novels = freezed,
  }) {
    return _then(_value.copyWith(
      category: category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryEntity,
      novels: novels == freezed
          ? _value.novels
          : novels // ignore: cast_nullable_to_non_nullable
              as List<NovelEntity>,
    ));
  }

  @override
  $CategoryEntityCopyWith<$Res> get category {
    return $CategoryEntityCopyWith<$Res>(_value.category, (value) {
      return _then(_value.copyWith(category: value));
    });
  }
}

/// @nodoc
abstract class _$NovelCategoryEntityCopyWith<$Res>
    implements $NovelCategoryEntityCopyWith<$Res> {
  factory _$NovelCategoryEntityCopyWith(_NovelCategoryEntity value,
          $Res Function(_NovelCategoryEntity) then) =
      __$NovelCategoryEntityCopyWithImpl<$Res>;
  @override
  $Res call({CategoryEntity category, List<NovelEntity> novels});

  @override
  $CategoryEntityCopyWith<$Res> get category;
}

/// @nodoc
class __$NovelCategoryEntityCopyWithImpl<$Res>
    extends _$NovelCategoryEntityCopyWithImpl<$Res>
    implements _$NovelCategoryEntityCopyWith<$Res> {
  __$NovelCategoryEntityCopyWithImpl(
      _NovelCategoryEntity _value, $Res Function(_NovelCategoryEntity) _then)
      : super(_value, (v) => _then(v as _NovelCategoryEntity));

  @override
  _NovelCategoryEntity get _value => super._value as _NovelCategoryEntity;

  @override
  $Res call({
    Object? category = freezed,
    Object? novels = freezed,
  }) {
    return _then(_NovelCategoryEntity(
      category == freezed
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as CategoryEntity,
      novels == freezed
          ? _value.novels
          : novels // ignore: cast_nullable_to_non_nullable
              as List<NovelEntity>,
    ));
  }
}

/// @nodoc

class _$_NovelCategoryEntity implements _NovelCategoryEntity {
  _$_NovelCategoryEntity(this.category, this.novels);

  @override
  final CategoryEntity category;
  @override
  final List<NovelEntity> novels;

  @override
  String toString() {
    return 'NovelCategoryEntity(category: $category, novels: $novels)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NovelCategoryEntity &&
            const DeepCollectionEquality().equals(other.category, category) &&
            const DeepCollectionEquality().equals(other.novels, novels));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(category),
      const DeepCollectionEquality().hash(novels));

  @JsonKey(ignore: true)
  @override
  _$NovelCategoryEntityCopyWith<_NovelCategoryEntity> get copyWith =>
      __$NovelCategoryEntityCopyWithImpl<_NovelCategoryEntity>(
          this, _$identity);
}

abstract class _NovelCategoryEntity implements NovelCategoryEntity {
  factory _NovelCategoryEntity(
          CategoryEntity category, List<NovelEntity> novels) =
      _$_NovelCategoryEntity;

  @override
  CategoryEntity get category;
  @override
  List<NovelEntity> get novels;
  @override
  @JsonKey(ignore: true)
  _$NovelCategoryEntityCopyWith<_NovelCategoryEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
