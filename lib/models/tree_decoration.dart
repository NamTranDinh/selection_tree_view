import 'package:flutter/material.dart';

typedef TitleBuilder = Widget Function(String title);

class TreeDecoration {
  TreeDecoration({
    this.titleStyle = const TextStyle(),
    this.nodeHeight = 36,
    this.prefixIcon = const Icon(Icons.arrow_drop_up),
    this.animatedDuration = const Duration(milliseconds: 150),
  });

  TextStyle titleStyle;
  double nodeHeight;
  bool isShowChild = true;
  bool status = true;
  Widget prefixIcon;
  Duration animatedDuration;

  TreeDecoration copyWith({
    TextStyle? titleStyle,
    double? nodeHeight,
    Widget? prefixIcon,
    Duration? animatedDuration,
  }) {
    return TreeDecoration(
      titleStyle: titleStyle ?? this.titleStyle,
      nodeHeight: nodeHeight ?? this.nodeHeight,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      animatedDuration: animatedDuration ?? this.animatedDuration,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titleStyle': titleStyle,
      'nodeHeight': nodeHeight,
      'isShowChild': isShowChild,
      'status': status,
      'prefixIcon': prefixIcon,
      'animatedDuration': animatedDuration,
    };
  }
}
