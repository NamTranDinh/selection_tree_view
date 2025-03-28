import 'dart:ui';

class TreeDecoration {
  TreeDecoration({
    required this.titleStyle,
    required this.nodeHeight,
    required this.isShowChild,
    required this.status,
  });

  factory TreeDecoration.init() {
    return TreeDecoration(
      titleStyle: TextStyle(),
      nodeHeight: 35,
      isShowChild: true,
      status: true,
    );
  }

  TextStyle titleStyle;
  double nodeHeight;
  bool isShowChild;
  bool status;
}

class TreeNode {
  TreeNode({
    this.title,
    this.code,
    this.isCheck = false,
    this.parent,
    required this.children,
    this.hierarchy = 0,
  });

  String? title;
  String? code;
  bool? isCheck;
  TreeNode? parent;
  int hierarchy;
  List<TreeNode> children;
  TreeDecoration decoration = TreeDecoration.init();

  TreeNode copyWith({
    String? title,
    String? code,
    bool? isCheck,
    TreeNode? parent,
    int? hierarchy,
    List<TreeNode>? children,
  }) {
    return TreeNode(
      title: title ?? this.title,
      code: code ?? this.code,
      isCheck: isCheck ?? this.isCheck,
      parent: parent ?? this.parent,
      hierarchy: hierarchy ?? this.hierarchy,
      children: children ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'code': code,
      'isCheck': isCheck,
      'parent': parent?.title,
      'hierarchy': hierarchy,
      'children': children.map((child) => child.toJson()).toList(),
    };
  }
}
