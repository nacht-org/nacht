import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ClearableTextField extends HookConsumerWidget {
  const ClearableTextField({
    Key? key,
    this.text,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.autofocus = false,
    this.decoration,
    this.textInputAction,
  })  : assert(text == null || controller == null),
        super(key: key);

  final String? text;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final bool autofocus;
  final InputDecoration? decoration;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final iconTheme = IconTheme.of(context);

    final textController = controller ??
        useTextEditingController.fromValue(
          TextEditingValue(text: text ?? ''),
        );

    useEffect(() {
      if (text != null && textController.text != text) {
        textController.text = text!;
      }
      return null;
    }, [text]);

    final clearable = _useClearable(textController);
    final suffixIcon = IconButton(
      icon: Icon(Icons.clear, size: iconTheme.size),
      onPressed: clearable.value
          ? () {
              textController.clear();
              onClear?.call();
            }
          : null,
    );

    return TextField(
      controller: textController,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      autofocus: autofocus,
      textInputAction: textInputAction,
      decoration: decoration?.copyWith(suffixIcon: suffixIcon) ??
          InputDecoration(suffixIcon: suffixIcon),
    );
  }
}

ValueNotifier<bool> _useClearable(TextEditingController controller) {
  final update = useValueListenable(controller);
  final clearable = useState(false);

  useEffect(() {
    clearable.value = update.text.isNotEmpty;
    return null;
  }, [update]);

  return clearable;
}
