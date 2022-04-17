import 'package:equatable/equatable.dart';
import 'package:path/path.dart' as p;

class Migration extends Equatable {
  const Migration({
    required this.version,
    required this.name,
    required this.path,
  });

  final String name;
  final int version;
  final String path;

  @override
  List<Object?> get props => [name, version, path];

  static Migration fromPath(String filePath) {
    final fileName = p.basename(filePath);
    final segments = fileName.split('__');

    final number = int.parse(segments[0].substring(1));
    final name =
        segments[1].substring(0, segments[1].length - 4).replaceAll('-', ' ');

    return Migration(
      version: number,
      name: name,
      path: filePath,
    );
  }
}
