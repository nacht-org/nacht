import 'package:chapturn/data/mappers/network/connection_mapper.dart';
import 'package:chapturn/data/mappers/sources/partial_novel_source_mapper.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final partialNovelSourceFromMapper =
    Provider<SourceToPartialNovelMapper>((ref) => SourceToPartialNovelMapper());

final connectivityToConnectionMapper = Provider<ConnectivityToConnectionMapper>(
    ((ref) => ConnectivityToConnectionMapper()));
