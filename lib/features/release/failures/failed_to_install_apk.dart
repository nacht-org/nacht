import 'package:nacht/core/core.dart';

class FailedToInstallApk extends Failure {
  final String filePath;

  const FailedToInstallApk(this.filePath, super.message);

  @override
  List<Object?> get props => [...super.props, filePath];
}
