import 'package:nacht/core/misc/filter_utils.dart';

enum BrowseFilter with BinaryFilter {
  unsupported(name: 'Unsupported', bit: 0x00000001);

  const BrowseFilter({
    required this.name,
    required this.bit,
  });

  final String name;

  @override
  final int bit;
}
