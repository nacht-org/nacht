import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:nacht/database/database.dart';
import 'package:nacht_sources/nacht_sources.dart' as sources;

MetaEntriesCompanion metaDataIntoCompanion(sources.MetaData input) {
  return MetaEntriesCompanion(
    name: Value(input.name),
    value: Value(input.value),
    namespaceId: Value(NamespaceSeed.fromNamespace(input.namespace)),
    others: Value(input.others.isEmpty ? null : json.encode(input.others)),
  );
}
