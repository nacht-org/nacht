import 'package:chapturn/domain/entities/novel/novel_entity.dart';
import 'package:chapturn/domain/repositories/asset_repository.dart';
import 'package:chapturn/domain/repositories/novel_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/failure.dart';

class GetNovel {
  GetNovel({
    required this.novelRepository,
    required this.assetRepository,
  });

  final NovelLocalRepository novelRepository;
  final AssetRepository assetRepository;

  Future<Either<Failure, NovelEntity>> execute(int id) {
    return novelRepository.getNovel(id);
  }
}
