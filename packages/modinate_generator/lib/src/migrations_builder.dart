import 'dart:async';

import 'package:build/build.dart';
import 'package:modinate_core/modinate_core.dart';
import 'package:modinate_generator/src/constants.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as path;

class MigrationsBuilder extends Builder {
  static final _migrationFiles = Glob('assets/migrations/*.sql');

  @override
  Map<String, List<String>> get buildExtensions {
    return const {
      r'$lib$': ['generated/migrations.g.dart'],
    };
  }

  void writeMigration(StringBuffer buffer, Migration info) {
    buffer.writeln('Migration(');
    buffer.writeln('  version: ${info.version},');
    buffer.writeln('  name: "${info.name}",');
    buffer.writeln('  path: "${info.path}",');
    buffer.writeln('),');
  }

  static AssetId _allFileOutput(BuildStep buildStep) {
    return AssetId(
      buildStep.inputId.package,
      path.join(generatedPath, 'migrations.g.dart'),
    );
  }

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final migrations = <Migration>[];
    await for (final input in buildStep.findAssets(_migrationFiles)) {
      migrations.add(Migration.fromPath(input.path));
    }

    migrations.sort((a, b) => a.version.compareTo(b.version));

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
}
