import 'package:chapturn/data/exception.dart';
import 'package:chapturn/domain/mapper.dart';

class SeedToMimeTypeMapper implements Mapper<int, String> {
  @override
  String from(int input) {
    switch (input) {
      case 1:
        return 'image/apng';
      case 2:
        return 'image/avif';
      case 3:
        return 'image/gif';
      case 4:
        return 'image/jpeg';
      case 5:
        return 'image/png';
      case 6:
        return 'image/svg+xml';
      case 7:
        return 'image/webp';
      default:
        throw SeedException();
    }
  }
}

class MimeTypeToSeedMapper implements Mapper<String, int> {
  @override
  int from(String input) {
    switch (input) {
      case 'image/apng':
        return 1;
      case 'image/avif':
        return 2;
      case 'image/gif':
        return 3;
      case 'image/jpeg':
        return 4;
      case 'image/png':
        return 5;
      case 'image/svg+xml':
        return 6;
      case 'image/webp':
        return 7;
      default:
        throw SeedException();
    }
  }
}
