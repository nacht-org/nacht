import 'dart:async';

import 'package:build/build.dart';
import 'package:modinate_generator/src/constants.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as path;

import 'migration.dart';

class MigrationsBuilder extends Builder {
  static final _migrationFiles = Glob('assets/migrations/*.sql');

  static AssetId _allFileOutput(BuildStep buildStep) {
    return AssetId(
      buildStep.inputId.package,
      path.join(generatedPath, 'migrations.g.dart'),
    );
  }

  @override
  Map<String, List<String>> get buildExtensions {
    return const {
      r'$lib$': ['generated/migrations.g.dart'],
    };
  }

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final migrations = <Migration>[];
    await for (final input in buildStep.findAssets(_migrationFiles)) {
      migrations.add(migrationFromPath(input.path));
    }

    migrations.sort((a, b) => a.number.compareTo(b.number));

    final output = _allFileOutput(buildStep);

    final buffer = StringBuffer();
    buffer.writeln(generatedWarning);
    buffer.writeln();
    buffer.writeln('import "$packagePath";');
    buffer.writeln();
    buffer.writeln('const migrations = <Migration>[');
    for (final migration in migrations) {
      writeMigration(buffer, migration);
    }
    buffer.writeln('];');

    return buildStep.writeAsString(output, buffer.toString());
  }

  void writeMigration(StringBuffer buffer, Migration info) {
    buffer.writeln('Migration(');
    buffer.writeln('  number: ${info.number},');
    buffer.writeln('  name: "${info.name}",');
    buffer.writeln('  path: "${info.path}",');
    buffer.writeln('),');
  }

  static Migration migrationFromPath(String filePath) {
    final fileName = path.basename(filePath);
    final segments = fileName.split('__');

    final number = int.parse(segments[0].substring(1));
    final name =
        segments[1].substring(0, segments[1].length - 4).replaceAll('-', ' ');

    return Migration(
      number: number,
      name: name,
      path: filePath,
    );
  }
}
