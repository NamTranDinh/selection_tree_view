import 'package:flutter/material.dart';

class PermissionSelected extends StatefulWidget {
  const PermissionSelected({super.key});

  @override
  State<PermissionSelected> createState() => _PermissionSelectedState();
}

class _PermissionSelectedState extends State<PermissionSelected> {
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
