import 'package:flutter/material.dart';

class CustomMenuCardTrailing extends StatefulWidget {
  const CustomMenuCardTrailing({
    super.key,
    required this.expansionTileController,
  });

  final ExpansionTileController expansionTileController;

  @override
  State<CustomMenuCardTrailing> createState() => _CustomMenuCardTrailingState();
}

class _CustomMenuCardTrailingState extends State<CustomMenuCardTrailing> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.edit_note_sharp)),
        IconButton(
            onPressed: () {}, icon: const Icon(Icons.delete_forever_outlined)),
        IconButton(
            onPressed: () {
              setState(
                () {
                  if (isExpanded) {
                    widget.expansionTileController.collapse();
                  } else {
                    widget.expansionTileController.expand();
                  }
                },
              );
              isExpanded = !isExpanded;
            },
            icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more)),
      ],
    );
  }
}
