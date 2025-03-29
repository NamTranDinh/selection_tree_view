import 'package:flutter/material.dart';
import 'package:selection_tree_view/models/tree_node.dart';

typedef TitleBuilder = Widget Function(String title);

typedef PrefixIconBuilder = Widget Function(TreeNode node);

typedef TreeRowDecoration = BoxDecoration Function(TreeNode node, int index);
