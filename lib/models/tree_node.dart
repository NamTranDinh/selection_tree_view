import 'package:selection_tree_view/models/tree_decoration.dart';

class TreeNode {
  TreeNode({
    this.title,
    this.code,
    this.isCheck = false,
    this.hierarchy = 0,
    this.parent,
    required this.children,
  });

  String? title;
  String? code;
  bool? isCheck;
  int hierarchy;
  TreeNode? parent;
  List<TreeNode> children;
  TreeDecoration decoration = TreeDecoration();

  TreeNode copyWith({
    String? title,
    String? code,
    bool? isCheck,
    int? hierarchy,
    TreeNode? parent,
    List<TreeNode>? children,
  }) {
    return TreeNode(
      title: title ?? this.title,
      code: code ?? this.code,
      isCheck: isCheck ?? this.isCheck,
      hierarchy: hierarchy ?? this.hierarchy,
      parent: parent ?? this.parent,
      children: children ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'code': code,
      'isCheck': isCheck,
      'hierarchy': hierarchy,
      'parent': parent?.title,
      'children': children.map((child) => child.toJson()).toList(),
      // 'decoration': decoration.toJson(),
    };
  }
}
