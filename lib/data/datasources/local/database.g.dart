// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Status extends DataClass implements Insertable<Status> {
  final int id;
  final String value;
  Status({required this.id, required this.value});
  factory Status.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Status(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      value: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}value'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['value'] = Variable<String>(value);
    return map;
  }

  StatusesCompanion toCompanion(bool nullToAbsent) {
    return StatusesCompanion(
      id: Value(id),
      value: Value(value),
    );
  }

  factory Status.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Status(
      id: serializer.fromJson<int>(json['id']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'value': serializer.toJson<String>(value),
    };
  }

  Status copyWith({int? id, String? value}) => Status(
        id: id ?? this.id,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('Status(')
          ..write('id: $id, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Status && other.id == this.id && other.value == this.value);
}

class StatusesCompanion extends UpdateCompanion<Status> {
  final Value<int> id;
  final Value<String> value;
  const StatusesCompanion({
    this.id = const Value.absent(),
    this.value = const Value.absent(),
  });
  StatusesCompanion.insert({
    this.id = const Value.absent(),
    required String value,
  }) : value = Value(value);
  static Insertable<Status> custom({
    Expression<int>? id,
    Expression<String>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (value != null) 'value': value,
    });
  }

  StatusesCompanion copyWith({Value<int>? id, Value<String>? value}) {
    return StatusesCompanion(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StatusesCompanion(')
          ..write('id: $id, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $StatusesTable extends Statuses with TableInfo<$StatusesTable, Status> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StatusesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String?> value = GeneratedColumn<String?>(
      'value', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
      type: const StringType(),
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, value];
  @override
  String get aliasedName => _alias ?? 'statuses';
  @override
  String get actualTableName => 'statuses';
  @override
  VerificationContext validateIntegrity(Insertable<Status> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Status map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Status.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $StatusesTable createAlias(String alias) {
    return $StatusesTable(attachedDatabase, alias);
  }
}

class WorkType extends DataClass implements Insertable<WorkType> {
  final int id;
  final String value;
  WorkType({required this.id, required this.value});
  factory WorkType.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return WorkType(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      value: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}value'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['value'] = Variable<String>(value);
    return map;
  }

  WorkTypesCompanion toCompanion(bool nullToAbsent) {
    return WorkTypesCompanion(
      id: Value(id),
      value: Value(value),
    );
  }

  factory WorkType.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkType(
      id: serializer.fromJson<int>(json['id']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'value': serializer.toJson<String>(value),
    };
  }

  WorkType copyWith({int? id, String? value}) => WorkType(
        id: id ?? this.id,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('WorkType(')
          ..write('id: $id, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkType && other.id == this.id && other.value == this.value);
}

class WorkTypesCompanion extends UpdateCompanion<WorkType> {
  final Value<int> id;
  final Value<String> value;
  const WorkTypesCompanion({
    this.id = const Value.absent(),
    this.value = const Value.absent(),
  });
  WorkTypesCompanion.insert({
    this.id = const Value.absent(),
    required String value,
  }) : value = Value(value);
  static Insertable<WorkType> custom({
    Expression<int>? id,
    Expression<String>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (value != null) 'value': value,
    });
  }

  WorkTypesCompanion copyWith({Value<int>? id, Value<String>? value}) {
    return WorkTypesCompanion(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkTypesCompanion(')
          ..write('id: $id, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $WorkTypesTable extends WorkTypes
    with TableInfo<$WorkTypesTable, WorkType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkTypesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String?> value = GeneratedColumn<String?>(
      'value', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
      type: const StringType(),
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, value];
  @override
  String get aliasedName => _alias ?? 'work_types';
  @override
  String get actualTableName => 'work_types';
  @override
  VerificationContext validateIntegrity(Insertable<WorkType> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkType map(Map<String, dynamic> data, {String? tablePrefix}) {
    return WorkType.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $WorkTypesTable createAlias(String alias) {
    return $WorkTypesTable(attachedDatabase, alias);
  }
}

class ReadingDirection extends DataClass
    implements Insertable<ReadingDirection> {
  final int id;
  final String value;
  ReadingDirection({required this.id, required this.value});
  factory ReadingDirection.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ReadingDirection(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      value: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}value'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['value'] = Variable<String>(value);
    return map;
  }

  ReadingDirectionsCompanion toCompanion(bool nullToAbsent) {
    return ReadingDirectionsCompanion(
      id: Value(id),
      value: Value(value),
    );
  }

  factory ReadingDirection.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadingDirection(
      id: serializer.fromJson<int>(json['id']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'value': serializer.toJson<String>(value),
    };
  }

  ReadingDirection copyWith({int? id, String? value}) => ReadingDirection(
        id: id ?? this.id,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('ReadingDirection(')
          ..write('id: $id, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReadingDirection &&
          other.id == this.id &&
          other.value == this.value);
}

class ReadingDirectionsCompanion extends UpdateCompanion<ReadingDirection> {
  final Value<int> id;
  final Value<String> value;
  const ReadingDirectionsCompanion({
    this.id = const Value.absent(),
    this.value = const Value.absent(),
  });
  ReadingDirectionsCompanion.insert({
    this.id = const Value.absent(),
    required String value,
  }) : value = Value(value);
  static Insertable<ReadingDirection> custom({
    Expression<int>? id,
    Expression<String>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (value != null) 'value': value,
    });
  }

  ReadingDirectionsCompanion copyWith({Value<int>? id, Value<String>? value}) {
    return ReadingDirectionsCompanion(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingDirectionsCompanion(')
          ..write('id: $id, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $ReadingDirectionsTable extends ReadingDirections
    with TableInfo<$ReadingDirectionsTable, ReadingDirection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingDirectionsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String?> value = GeneratedColumn<String?>(
      'value', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
      type: const StringType(),
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, value];
  @override
  String get aliasedName => _alias ?? 'reading_directions';
  @override
  String get actualTableName => 'reading_directions';
  @override
  VerificationContext validateIntegrity(Insertable<ReadingDirection> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReadingDirection map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ReadingDirection.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ReadingDirectionsTable createAlias(String alias) {
    return $ReadingDirectionsTable(attachedDatabase, alias);
  }
}

class Novel extends DataClass implements Insertable<Novel> {
  final int id;
  final String title;
  final String description;
  final String? author;
  final String? thumbnailUrl;
  final String url;
  final int statusId;
  final String lang;
  final int workTypeId;
  final int readingDirectionId;
  Novel(
      {required this.id,
      required this.title,
      required this.description,
      this.author,
      this.thumbnailUrl,
      required this.url,
      required this.statusId,
      required this.lang,
      required this.workTypeId,
      required this.readingDirectionId});
  factory Novel.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Novel(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      author: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}author']),
      thumbnailUrl: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}thumbnail_url']),
      url: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}url'])!,
      statusId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}status_id'])!,
      lang: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lang'])!,
      workTypeId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}work_type_id'])!,
      readingDirectionId: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}reading_direction_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String?>(author);
    }
    if (!nullToAbsent || thumbnailUrl != null) {
      map['thumbnail_url'] = Variable<String?>(thumbnailUrl);
    }
    map['url'] = Variable<String>(url);
    map['status_id'] = Variable<int>(statusId);
    map['lang'] = Variable<String>(lang);
    map['work_type_id'] = Variable<int>(workTypeId);
    map['reading_direction_id'] = Variable<int>(readingDirectionId);
    return map;
  }

  NovelsCompanion toCompanion(bool nullToAbsent) {
    return NovelsCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      author:
          author == null && nullToAbsent ? const Value.absent() : Value(author),
      thumbnailUrl: thumbnailUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnailUrl),
      url: Value(url),
      statusId: Value(statusId),
      lang: Value(lang),
      workTypeId: Value(workTypeId),
      readingDirectionId: Value(readingDirectionId),
    );
  }

  factory Novel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Novel(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      author: serializer.fromJson<String?>(json['author']),
      thumbnailUrl: serializer.fromJson<String?>(json['thumbnailUrl']),
      url: serializer.fromJson<String>(json['url']),
      statusId: serializer.fromJson<int>(json['statusId']),
      lang: serializer.fromJson<String>(json['lang']),
      workTypeId: serializer.fromJson<int>(json['workTypeId']),
      readingDirectionId: serializer.fromJson<int>(json['readingDirectionId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'author': serializer.toJson<String?>(author),
      'thumbnailUrl': serializer.toJson<String?>(thumbnailUrl),
      'url': serializer.toJson<String>(url),
      'statusId': serializer.toJson<int>(statusId),
      'lang': serializer.toJson<String>(lang),
      'workTypeId': serializer.toJson<int>(workTypeId),
      'readingDirectionId': serializer.toJson<int>(readingDirectionId),
    };
  }

  Novel copyWith(
          {int? id,
          String? title,
          String? description,
          String? author,
          String? thumbnailUrl,
          String? url,
          int? statusId,
          String? lang,
          int? workTypeId,
          int? readingDirectionId}) =>
      Novel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        author: author ?? this.author,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
        url: url ?? this.url,
        statusId: statusId ?? this.statusId,
        lang: lang ?? this.lang,
        workTypeId: workTypeId ?? this.workTypeId,
        readingDirectionId: readingDirectionId ?? this.readingDirectionId,
      );
  @override
  String toString() {
    return (StringBuffer('Novel(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('author: $author, ')
          ..write('thumbnailUrl: $thumbnailUrl, ')
          ..write('url: $url, ')
          ..write('statusId: $statusId, ')
          ..write('lang: $lang, ')
          ..write('workTypeId: $workTypeId, ')
          ..write('readingDirectionId: $readingDirectionId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description, author, thumbnailUrl,
      url, statusId, lang, workTypeId, readingDirectionId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Novel &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.author == this.author &&
          other.thumbnailUrl == this.thumbnailUrl &&
          other.url == this.url &&
          other.statusId == this.statusId &&
          other.lang == this.lang &&
          other.workTypeId == this.workTypeId &&
          other.readingDirectionId == this.readingDirectionId);
}

class NovelsCompanion extends UpdateCompanion<Novel> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> description;
  final Value<String?> author;
  final Value<String?> thumbnailUrl;
  final Value<String> url;
  final Value<int> statusId;
  final Value<String> lang;
  final Value<int> workTypeId;
  final Value<int> readingDirectionId;
  const NovelsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.author = const Value.absent(),
    this.thumbnailUrl = const Value.absent(),
    this.url = const Value.absent(),
    this.statusId = const Value.absent(),
    this.lang = const Value.absent(),
    this.workTypeId = const Value.absent(),
    this.readingDirectionId = const Value.absent(),
  });
  NovelsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String description,
    this.author = const Value.absent(),
    this.thumbnailUrl = const Value.absent(),
    required String url,
    required int statusId,
    required String lang,
    required int workTypeId,
    required int readingDirectionId,
  })  : title = Value(title),
        description = Value(description),
        url = Value(url),
        statusId = Value(statusId),
        lang = Value(lang),
        workTypeId = Value(workTypeId),
        readingDirectionId = Value(readingDirectionId);
  static Insertable<Novel> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String?>? author,
    Expression<String?>? thumbnailUrl,
    Expression<String>? url,
    Expression<int>? statusId,
    Expression<String>? lang,
    Expression<int>? workTypeId,
    Expression<int>? readingDirectionId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (author != null) 'author': author,
      if (thumbnailUrl != null) 'thumbnail_url': thumbnailUrl,
      if (url != null) 'url': url,
      if (statusId != null) 'status_id': statusId,
      if (lang != null) 'lang': lang,
      if (workTypeId != null) 'work_type_id': workTypeId,
      if (readingDirectionId != null)
        'reading_direction_id': readingDirectionId,
    });
  }

  NovelsCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? description,
      Value<String?>? author,
      Value<String?>? thumbnailUrl,
      Value<String>? url,
      Value<int>? statusId,
      Value<String>? lang,
      Value<int>? workTypeId,
      Value<int>? readingDirectionId}) {
    return NovelsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      author: author ?? this.author,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      url: url ?? this.url,
      statusId: statusId ?? this.statusId,
      lang: lang ?? this.lang,
      workTypeId: workTypeId ?? this.workTypeId,
      readingDirectionId: readingDirectionId ?? this.readingDirectionId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (author.present) {
      map['author'] = Variable<String?>(author.value);
    }
    if (thumbnailUrl.present) {
      map['thumbnail_url'] = Variable<String?>(thumbnailUrl.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (statusId.present) {
      map['status_id'] = Variable<int>(statusId.value);
    }
    if (lang.present) {
      map['lang'] = Variable<String>(lang.value);
    }
    if (workTypeId.present) {
      map['work_type_id'] = Variable<int>(workTypeId.value);
    }
    if (readingDirectionId.present) {
      map['reading_direction_id'] = Variable<int>(readingDirectionId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NovelsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('author: $author, ')
          ..write('thumbnailUrl: $thumbnailUrl, ')
          ..write('url: $url, ')
          ..write('statusId: $statusId, ')
          ..write('lang: $lang, ')
          ..write('workTypeId: $workTypeId, ')
          ..write('readingDirectionId: $readingDirectionId')
          ..write(')'))
        .toString();
  }
}

class $NovelsTable extends Novels with TableInfo<$NovelsTable, Novel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NovelsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String?> author = GeneratedColumn<String?>(
      'author', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _thumbnailUrlMeta =
      const VerificationMeta('thumbnailUrl');
  @override
  late final GeneratedColumn<String?> thumbnailUrl = GeneratedColumn<String?>(
      'thumbnail_url', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String?> url = GeneratedColumn<String?>(
      'url', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL UNIQUE');
  final VerificationMeta _statusIdMeta = const VerificationMeta('statusId');
  @override
  late final GeneratedColumn<int?> statusId = GeneratedColumn<int?>(
      'status_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES statuses (id)');
  final VerificationMeta _langMeta = const VerificationMeta('lang');
  @override
  late final GeneratedColumn<String?> lang = GeneratedColumn<String?>(
      'lang', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 8),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _workTypeIdMeta = const VerificationMeta('workTypeId');
  @override
  late final GeneratedColumn<int?> workTypeId = GeneratedColumn<int?>(
      'work_type_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES work_types (id)');
  final VerificationMeta _readingDirectionIdMeta =
      const VerificationMeta('readingDirectionId');
  @override
  late final GeneratedColumn<int?> readingDirectionId = GeneratedColumn<int?>(
      'reading_direction_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES reading_directions (id)');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        description,
        author,
        thumbnailUrl,
        url,
        statusId,
        lang,
        workTypeId,
        readingDirectionId
      ];
  @override
  String get aliasedName => _alias ?? 'novels';
  @override
  String get actualTableName => 'novels';
  @override
  VerificationContext validateIntegrity(Insertable<Novel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    }
    if (data.containsKey('thumbnail_url')) {
      context.handle(
          _thumbnailUrlMeta,
          thumbnailUrl.isAcceptableOrUnknown(
              data['thumbnail_url']!, _thumbnailUrlMeta));
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('status_id')) {
      context.handle(_statusIdMeta,
          statusId.isAcceptableOrUnknown(data['status_id']!, _statusIdMeta));
    } else if (isInserting) {
      context.missing(_statusIdMeta);
    }
    if (data.containsKey('lang')) {
      context.handle(
          _langMeta, lang.isAcceptableOrUnknown(data['lang']!, _langMeta));
    } else if (isInserting) {
      context.missing(_langMeta);
    }
    if (data.containsKey('work_type_id')) {
      context.handle(
          _workTypeIdMeta,
          workTypeId.isAcceptableOrUnknown(
              data['work_type_id']!, _workTypeIdMeta));
    } else if (isInserting) {
      context.missing(_workTypeIdMeta);
    }
    if (data.containsKey('reading_direction_id')) {
      context.handle(
          _readingDirectionIdMeta,
          readingDirectionId.isAcceptableOrUnknown(
              data['reading_direction_id']!, _readingDirectionIdMeta));
    } else if (isInserting) {
      context.missing(_readingDirectionIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Novel map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Novel.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NovelsTable createAlias(String alias) {
    return $NovelsTable(attachedDatabase, alias);
  }
}

class NovelCategory extends DataClass implements Insertable<NovelCategory> {
  final int id;
  final String value;
  NovelCategory({required this.id, required this.value});
  factory NovelCategory.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NovelCategory(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      value: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}value'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['value'] = Variable<String>(value);
    return map;
  }

  NovelCategoriesCompanion toCompanion(bool nullToAbsent) {
    return NovelCategoriesCompanion(
      id: Value(id),
      value: Value(value),
    );
  }

  factory NovelCategory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NovelCategory(
      id: serializer.fromJson<int>(json['id']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'value': serializer.toJson<String>(value),
    };
  }

  NovelCategory copyWith({int? id, String? value}) => NovelCategory(
        id: id ?? this.id,
        value: value ?? this.value,
      );
  @override
  String toString() {
    return (StringBuffer('NovelCategory(')
          ..write('id: $id, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NovelCategory &&
          other.id == this.id &&
          other.value == this.value);
}

class NovelCategoriesCompanion extends UpdateCompanion<NovelCategory> {
  final Value<int> id;
  final Value<String> value;
  const NovelCategoriesCompanion({
    this.id = const Value.absent(),
    this.value = const Value.absent(),
  });
  NovelCategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String value,
  }) : value = Value(value);
  static Insertable<NovelCategory> custom({
    Expression<int>? id,
    Expression<String>? value,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (value != null) 'value': value,
    });
  }

  NovelCategoriesCompanion copyWith({Value<int>? id, Value<String>? value}) {
    return NovelCategoriesCompanion(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NovelCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }
}

class $NovelCategoriesTable extends NovelCategories
    with TableInfo<$NovelCategoriesTable, NovelCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NovelCategoriesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String?> value = GeneratedColumn<String?>(
      'value', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, value];
  @override
  String get aliasedName => _alias ?? 'novel_categories';
  @override
  String get actualTableName => 'novel_categories';
  @override
  VerificationContext validateIntegrity(Insertable<NovelCategory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NovelCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NovelCategory.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NovelCategoriesTable createAlias(String alias) {
    return $NovelCategoriesTable(attachedDatabase, alias);
  }
}

class NovelCategoriesJunctionData extends DataClass
    implements Insertable<NovelCategoriesJunctionData> {
  final int categoryId;
  final int novelId;
  NovelCategoriesJunctionData(
      {required this.categoryId, required this.novelId});
  factory NovelCategoriesJunctionData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NovelCategoriesJunctionData(
      categoryId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category_id'])!,
      novelId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}novel_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['category_id'] = Variable<int>(categoryId);
    map['novel_id'] = Variable<int>(novelId);
    return map;
  }

  NovelCategoriesJunctionCompanion toCompanion(bool nullToAbsent) {
    return NovelCategoriesJunctionCompanion(
      categoryId: Value(categoryId),
      novelId: Value(novelId),
    );
  }

  factory NovelCategoriesJunctionData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NovelCategoriesJunctionData(
      categoryId: serializer.fromJson<int>(json['categoryId']),
      novelId: serializer.fromJson<int>(json['novelId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'categoryId': serializer.toJson<int>(categoryId),
      'novelId': serializer.toJson<int>(novelId),
    };
  }

  NovelCategoriesJunctionData copyWith({int? categoryId, int? novelId}) =>
      NovelCategoriesJunctionData(
        categoryId: categoryId ?? this.categoryId,
        novelId: novelId ?? this.novelId,
      );
  @override
  String toString() {
    return (StringBuffer('NovelCategoriesJunctionData(')
          ..write('categoryId: $categoryId, ')
          ..write('novelId: $novelId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(categoryId, novelId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NovelCategoriesJunctionData &&
          other.categoryId == this.categoryId &&
          other.novelId == this.novelId);
}

class NovelCategoriesJunctionCompanion
    extends UpdateCompanion<NovelCategoriesJunctionData> {
  final Value<int> categoryId;
  final Value<int> novelId;
  const NovelCategoriesJunctionCompanion({
    this.categoryId = const Value.absent(),
    this.novelId = const Value.absent(),
  });
  NovelCategoriesJunctionCompanion.insert({
    required int categoryId,
    required int novelId,
  })  : categoryId = Value(categoryId),
        novelId = Value(novelId);
  static Insertable<NovelCategoriesJunctionData> custom({
    Expression<int>? categoryId,
    Expression<int>? novelId,
  }) {
    return RawValuesInsertable({
      if (categoryId != null) 'category_id': categoryId,
      if (novelId != null) 'novel_id': novelId,
    });
  }

  NovelCategoriesJunctionCompanion copyWith(
      {Value<int>? categoryId, Value<int>? novelId}) {
    return NovelCategoriesJunctionCompanion(
      categoryId: categoryId ?? this.categoryId,
      novelId: novelId ?? this.novelId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (novelId.present) {
      map['novel_id'] = Variable<int>(novelId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NovelCategoriesJunctionCompanion(')
          ..write('categoryId: $categoryId, ')
          ..write('novelId: $novelId')
          ..write(')'))
        .toString();
  }
}

class $NovelCategoriesJunctionTable extends NovelCategoriesJunction
    with TableInfo<$NovelCategoriesJunctionTable, NovelCategoriesJunctionData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NovelCategoriesJunctionTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _categoryIdMeta = const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int?> categoryId = GeneratedColumn<int?>(
      'category_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES novel_categories (id)');
  final VerificationMeta _novelIdMeta = const VerificationMeta('novelId');
  @override
  late final GeneratedColumn<int?> novelId = GeneratedColumn<int?>(
      'novel_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES novels (id)');
  @override
  List<GeneratedColumn> get $columns => [categoryId, novelId];
  @override
  String get aliasedName => _alias ?? 'novel_categories_junction';
  @override
  String get actualTableName => 'novel_categories_junction';
  @override
  VerificationContext validateIntegrity(
      Insertable<NovelCategoriesJunctionData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('novel_id')) {
      context.handle(_novelIdMeta,
          novelId.isAcceptableOrUnknown(data['novel_id']!, _novelIdMeta));
    } else if (isInserting) {
      context.missing(_novelIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  NovelCategoriesJunctionData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    return NovelCategoriesJunctionData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $NovelCategoriesJunctionTable createAlias(String alias) {
    return $NovelCategoriesJunctionTable(attachedDatabase, alias);
  }
}

class Volume extends DataClass implements Insertable<Volume> {
  final int id;
  final int volumeIndex;
  final String name;
  final int novelId;
  Volume(
      {required this.id,
      required this.volumeIndex,
      required this.name,
      required this.novelId});
  factory Volume.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Volume(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      volumeIndex: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}volume_index'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      novelId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}novel_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['volume_index'] = Variable<int>(volumeIndex);
    map['name'] = Variable<String>(name);
    map['novel_id'] = Variable<int>(novelId);
    return map;
  }

  VolumesCompanion toCompanion(bool nullToAbsent) {
    return VolumesCompanion(
      id: Value(id),
      volumeIndex: Value(volumeIndex),
      name: Value(name),
      novelId: Value(novelId),
    );
  }

  factory Volume.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Volume(
      id: serializer.fromJson<int>(json['id']),
      volumeIndex: serializer.fromJson<int>(json['volumeIndex']),
      name: serializer.fromJson<String>(json['name']),
      novelId: serializer.fromJson<int>(json['novelId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'volumeIndex': serializer.toJson<int>(volumeIndex),
      'name': serializer.toJson<String>(name),
      'novelId': serializer.toJson<int>(novelId),
    };
  }

  Volume copyWith({int? id, int? volumeIndex, String? name, int? novelId}) =>
      Volume(
        id: id ?? this.id,
        volumeIndex: volumeIndex ?? this.volumeIndex,
        name: name ?? this.name,
        novelId: novelId ?? this.novelId,
      );
  @override
  String toString() {
    return (StringBuffer('Volume(')
          ..write('id: $id, ')
          ..write('volumeIndex: $volumeIndex, ')
          ..write('name: $name, ')
          ..write('novelId: $novelId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, volumeIndex, name, novelId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Volume &&
          other.id == this.id &&
          other.volumeIndex == this.volumeIndex &&
          other.name == this.name &&
          other.novelId == this.novelId);
}

class VolumesCompanion extends UpdateCompanion<Volume> {
  final Value<int> id;
  final Value<int> volumeIndex;
  final Value<String> name;
  final Value<int> novelId;
  const VolumesCompanion({
    this.id = const Value.absent(),
    this.volumeIndex = const Value.absent(),
    this.name = const Value.absent(),
    this.novelId = const Value.absent(),
  });
  VolumesCompanion.insert({
    this.id = const Value.absent(),
    required int volumeIndex,
    required String name,
    required int novelId,
  })  : volumeIndex = Value(volumeIndex),
        name = Value(name),
        novelId = Value(novelId);
  static Insertable<Volume> custom({
    Expression<int>? id,
    Expression<int>? volumeIndex,
    Expression<String>? name,
    Expression<int>? novelId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (volumeIndex != null) 'volume_index': volumeIndex,
      if (name != null) 'name': name,
      if (novelId != null) 'novel_id': novelId,
    });
  }

  VolumesCompanion copyWith(
      {Value<int>? id,
      Value<int>? volumeIndex,
      Value<String>? name,
      Value<int>? novelId}) {
    return VolumesCompanion(
      id: id ?? this.id,
      volumeIndex: volumeIndex ?? this.volumeIndex,
      name: name ?? this.name,
      novelId: novelId ?? this.novelId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (volumeIndex.present) {
      map['volume_index'] = Variable<int>(volumeIndex.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (novelId.present) {
      map['novel_id'] = Variable<int>(novelId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VolumesCompanion(')
          ..write('id: $id, ')
          ..write('volumeIndex: $volumeIndex, ')
          ..write('name: $name, ')
          ..write('novelId: $novelId')
          ..write(')'))
        .toString();
  }
}

class $VolumesTable extends Volumes with TableInfo<$VolumesTable, Volume> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VolumesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _volumeIndexMeta =
      const VerificationMeta('volumeIndex');
  @override
  late final GeneratedColumn<int?> volumeIndex = GeneratedColumn<int?>(
      'volume_index', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 124),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _novelIdMeta = const VerificationMeta('novelId');
  @override
  late final GeneratedColumn<int?> novelId = GeneratedColumn<int?>(
      'novel_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES novels (id)');
  @override
  List<GeneratedColumn> get $columns => [id, volumeIndex, name, novelId];
  @override
  String get aliasedName => _alias ?? 'volumes';
  @override
  String get actualTableName => 'volumes';
  @override
  VerificationContext validateIntegrity(Insertable<Volume> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('volume_index')) {
      context.handle(
          _volumeIndexMeta,
          volumeIndex.isAcceptableOrUnknown(
              data['volume_index']!, _volumeIndexMeta));
    } else if (isInserting) {
      context.missing(_volumeIndexMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('novel_id')) {
      context.handle(_novelIdMeta,
          novelId.isAcceptableOrUnknown(data['novel_id']!, _novelIdMeta));
    } else if (isInserting) {
      context.missing(_novelIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Volume map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Volume.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $VolumesTable createAlias(String alias) {
    return $VolumesTable(attachedDatabase, alias);
  }
}

class Chapter extends DataClass implements Insertable<Chapter> {
  final int id;
  final int chapterIndex;
  final String title;
  final String? content;
  final String url;
  final DateTime? updated;
  final int volumeId;
  Chapter(
      {required this.id,
      required this.chapterIndex,
      required this.title,
      this.content,
      required this.url,
      this.updated,
      required this.volumeId});
  factory Chapter.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Chapter(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      chapterIndex: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}chapter_index'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content']),
      url: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}url'])!,
      updated: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated']),
      volumeId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}volume_id'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['chapter_index'] = Variable<int>(chapterIndex);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String?>(content);
    }
    map['url'] = Variable<String>(url);
    if (!nullToAbsent || updated != null) {
      map['updated'] = Variable<DateTime?>(updated);
    }
    map['volume_id'] = Variable<int>(volumeId);
    return map;
  }

  ChaptersCompanion toCompanion(bool nullToAbsent) {
    return ChaptersCompanion(
      id: Value(id),
      chapterIndex: Value(chapterIndex),
      title: Value(title),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      url: Value(url),
      updated: updated == null && nullToAbsent
          ? const Value.absent()
          : Value(updated),
      volumeId: Value(volumeId),
    );
  }

  factory Chapter.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Chapter(
      id: serializer.fromJson<int>(json['id']),
      chapterIndex: serializer.fromJson<int>(json['chapterIndex']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String?>(json['content']),
      url: serializer.fromJson<String>(json['url']),
      updated: serializer.fromJson<DateTime?>(json['updated']),
      volumeId: serializer.fromJson<int>(json['volumeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'chapterIndex': serializer.toJson<int>(chapterIndex),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String?>(content),
      'url': serializer.toJson<String>(url),
      'updated': serializer.toJson<DateTime?>(updated),
      'volumeId': serializer.toJson<int>(volumeId),
    };
  }

  Chapter copyWith(
          {int? id,
          int? chapterIndex,
          String? title,
          String? content,
          String? url,
          DateTime? updated,
          int? volumeId}) =>
      Chapter(
        id: id ?? this.id,
        chapterIndex: chapterIndex ?? this.chapterIndex,
        title: title ?? this.title,
        content: content ?? this.content,
        url: url ?? this.url,
        updated: updated ?? this.updated,
        volumeId: volumeId ?? this.volumeId,
      );
  @override
  String toString() {
    return (StringBuffer('Chapter(')
          ..write('id: $id, ')
          ..write('chapterIndex: $chapterIndex, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('url: $url, ')
          ..write('updated: $updated, ')
          ..write('volumeId: $volumeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, chapterIndex, title, content, url, updated, volumeId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Chapter &&
          other.id == this.id &&
          other.chapterIndex == this.chapterIndex &&
          other.title == this.title &&
          other.content == this.content &&
          other.url == this.url &&
          other.updated == this.updated &&
          other.volumeId == this.volumeId);
}

class ChaptersCompanion extends UpdateCompanion<Chapter> {
  final Value<int> id;
  final Value<int> chapterIndex;
  final Value<String> title;
  final Value<String?> content;
  final Value<String> url;
  final Value<DateTime?> updated;
  final Value<int> volumeId;
  const ChaptersCompanion({
    this.id = const Value.absent(),
    this.chapterIndex = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.url = const Value.absent(),
    this.updated = const Value.absent(),
    this.volumeId = const Value.absent(),
  });
  ChaptersCompanion.insert({
    this.id = const Value.absent(),
    required int chapterIndex,
    required String title,
    this.content = const Value.absent(),
    required String url,
    this.updated = const Value.absent(),
    required int volumeId,
  })  : chapterIndex = Value(chapterIndex),
        title = Value(title),
        url = Value(url),
        volumeId = Value(volumeId);
  static Insertable<Chapter> custom({
    Expression<int>? id,
    Expression<int>? chapterIndex,
    Expression<String>? title,
    Expression<String?>? content,
    Expression<String>? url,
    Expression<DateTime?>? updated,
    Expression<int>? volumeId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (chapterIndex != null) 'chapter_index': chapterIndex,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (url != null) 'url': url,
      if (updated != null) 'updated': updated,
      if (volumeId != null) 'volume_id': volumeId,
    });
  }

  ChaptersCompanion copyWith(
      {Value<int>? id,
      Value<int>? chapterIndex,
      Value<String>? title,
      Value<String?>? content,
      Value<String>? url,
      Value<DateTime?>? updated,
      Value<int>? volumeId}) {
    return ChaptersCompanion(
      id: id ?? this.id,
      chapterIndex: chapterIndex ?? this.chapterIndex,
      title: title ?? this.title,
      content: content ?? this.content,
      url: url ?? this.url,
      updated: updated ?? this.updated,
      volumeId: volumeId ?? this.volumeId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (chapterIndex.present) {
      map['chapter_index'] = Variable<int>(chapterIndex.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String?>(content.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (updated.present) {
      map['updated'] = Variable<DateTime?>(updated.value);
    }
    if (volumeId.present) {
      map['volume_id'] = Variable<int>(volumeId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChaptersCompanion(')
          ..write('id: $id, ')
          ..write('chapterIndex: $chapterIndex, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('url: $url, ')
          ..write('updated: $updated, ')
          ..write('volumeId: $volumeId')
          ..write(')'))
        .toString();
  }
}

class $ChaptersTable extends Chapters with TableInfo<$ChaptersTable, Chapter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChaptersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _chapterIndexMeta =
      const VerificationMeta('chapterIndex');
  @override
  late final GeneratedColumn<int?> chapterIndex = GeneratedColumn<int?>(
      'chapter_index', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'content', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String?> url = GeneratedColumn<String?>(
      'url', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _updatedMeta = const VerificationMeta('updated');
  @override
  late final GeneratedColumn<DateTime?> updated = GeneratedColumn<DateTime?>(
      'updated', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _volumeIdMeta = const VerificationMeta('volumeId');
  @override
  late final GeneratedColumn<int?> volumeId = GeneratedColumn<int?>(
      'volume_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES volumes (id)');
  @override
  List<GeneratedColumn> get $columns =>
      [id, chapterIndex, title, content, url, updated, volumeId];
  @override
  String get aliasedName => _alias ?? 'chapters';
  @override
  String get actualTableName => 'chapters';
  @override
  VerificationContext validateIntegrity(Insertable<Chapter> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('chapter_index')) {
      context.handle(
          _chapterIndexMeta,
          chapterIndex.isAcceptableOrUnknown(
              data['chapter_index']!, _chapterIndexMeta));
    } else if (isInserting) {
      context.missing(_chapterIndexMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('updated')) {
      context.handle(_updatedMeta,
          updated.isAcceptableOrUnknown(data['updated']!, _updatedMeta));
    }
    if (data.containsKey('volume_id')) {
      context.handle(_volumeIdMeta,
          volumeId.isAcceptableOrUnknown(data['volume_id']!, _volumeIdMeta));
    } else if (isInserting) {
      context.missing(_volumeIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Chapter map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Chapter.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ChaptersTable createAlias(String alias) {
    return $ChaptersTable(attachedDatabase, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $StatusesTable statuses = $StatusesTable(this);
  late final $WorkTypesTable workTypes = $WorkTypesTable(this);
  late final $ReadingDirectionsTable readingDirections =
      $ReadingDirectionsTable(this);
  late final $NovelsTable novels = $NovelsTable(this);
  late final $NovelCategoriesTable novelCategories =
      $NovelCategoriesTable(this);
  late final $NovelCategoriesJunctionTable novelCategoriesJunction =
      $NovelCategoriesJunctionTable(this);
  late final $VolumesTable volumes = $VolumesTable(this);
  late final $ChaptersTable chapters = $ChaptersTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        statuses,
        workTypes,
        readingDirections,
        novels,
        novelCategories,
        novelCategoriesJunction,
        volumes,
        chapters
      ];
}
