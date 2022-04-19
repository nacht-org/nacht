import 'package:chapturn/core/failure.dart';
import 'package:chapturn/domain/providers/providers.dart';
import 'package:chapturn/presentation/controllers/import_from_url/searchbar_notifier.dart';
import 'package:chapturn/utils/uri.dart';
import 'package:chapturn_sources/chapturn_sources.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'search_result_provider.freezed.dart';

@freezed
class ImportUrlResult with _$ImportUrlResult {
  const factory ImportUrlResult.empty() = _EmptyImportUrlResult;
  const factory ImportUrlResult.found(CrawlerFactory crawlerFactory) =
      _FoundImportUrlResult;
  const factory ImportUrlResult.notFound() = _NotFoundImportUrlResult;
  const factory ImportUrlResult.error(String reason) = _NotAUrlImportUrlResult;
}

final importFromUrlResult = Provider<ImportUrlResult>((ref) {
  final text = ref.watch(importUrlSearchBarProvider);
  if (text.isEmpty) {
    return const ImportUrlResult.empty();
  }

  if (!isUriValid(text)) {
    return const ImportUrlResult.error('The provided url is invalid.');
  }

  return ref.watch(getCrawlerFactoryFor).execute(text).fold(
    (failure) {
      if (failure is CrawlerNotFound) {
        return const ImportUrlResult.notFound();
      }

      return const ImportUrlResult.error('Unexpected error');
    },
    (data) => ImportUrlResult.found(data),
  );
});
