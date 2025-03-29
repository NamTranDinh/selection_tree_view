import 'package:flutter/material.dart';

class TreeConfiguration {
  TreeConfiguration({
    this.titleStyle = const TextStyle(),
    this.nodeHeight = 36,
    this.prefixIcon = const Icon(Icons.arrow_drop_up),
    this.animatedDuration = const Duration(milliseconds: 150),
    this.showCheckbox = true,
    this.animatePrefixIcon = true,
  });

  TextStyle titleStyle;
  double nodeHeight;
  bool isShowChild = true;
  bool isExpanded = true;
  bool showCheckbox;
  Widget prefixIcon;
  bool animatePrefixIcon;
  Duration animatedDuration;

  TreeConfiguration copyWith({
    TextStyle? titleStyle,
    double? nodeHeight,
    Widget? prefixIcon,
    Duration? animatedDuration,
    bool? showCheckbox,
    bool? animatePrefixIcon,
  }) {
    return TreeConfiguration(
      titleStyle: titleStyle ?? this.titleStyle,
      nodeHeight: nodeHeight ?? this.nodeHeight,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      animatedDuration: animatedDuration ?? this.animatedDuration,
      showCheckbox: showCheckbox ?? this.showCheckbox,
      animatePrefixIcon: animatePrefixIcon ?? this.animatePrefixIcon,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titleStyle': titleStyle,
      'nodeHeight': nodeHeight,
      'isShowChild': isShowChild,
      'status': isExpanded,
      'prefixIcon': prefixIcon,
      'animatedDuration': animatedDuration,
      'showCheckbox': showCheckbox,
      'animatePrefixIcon': animatePrefixIcon,
    };
  }
}
