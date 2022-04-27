import 'package:chapturn/domain/entities/novel/novel_entity.dart';
import 'package:chapturn/domain/repositories/novel_repository.dart';
import 'package:dartz/dartz.dart';

import '../../core/failure.dart';

class GetNovel {
  final NovelLocalRepository novelRepository;

  GetNovel({required this.novelRepository});

  Future<Either<Failure, NovelEntity>> execute(int id) {
    return novelRepository.getNovel(id);
  }
}
