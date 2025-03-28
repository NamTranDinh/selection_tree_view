import 'package:flutter/material.dart';

class TreeViewSelected extends StatefulWidget {
  const TreeViewSelected({super.key});

  @override
  State<TreeViewSelected> createState() => _TreeViewSelectedState();
}

class _TreeViewSelectedState extends State<TreeViewSelected> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
