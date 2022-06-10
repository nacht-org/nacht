import 'package:flutter/material.dart';

class StepListTile extends StatelessWidget {
  const StepListTile({
    Key? key,
    required this.title,
    required this.value,
    this.subtitle,
    required this.onChanged,
    this.step = 1.0,
    this.min,
    this.max,
  })  : assert(step > 0),
        assert(max == null || value <= max),
        assert(min == null || value >= min),
        super(key: key);

  final Widget title;
  final Widget? subtitle;
  final void Function(double value) onChanged;

  final double value;
  final double? min;
  final double? max;
  final double step;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title,
      subtitle: subtitle,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: min == null || value > min!
                ? () => onChanged(value - step)
                : null,
            icon: const Icon(Icons.remove),
            tooltip: 'Decrease value by $step',
          ),
          IconButton(
            onPressed: max == null || value < max!
                ? () => onChanged(value + step)
                : null,
            icon: const Icon(Icons.add),
            tooltip: 'Increase value by $step',
          ),
        ],
      ),
    );
  }
}
