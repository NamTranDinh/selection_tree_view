import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selection_tree_view/models/tree_node.dart';
import 'package:selection_tree_view/models/tree_decoration.dart';
import 'package:selection_tree_view/viewmodel/tree_view_cubit.dart';

class SelectionTreeView extends StatefulWidget {
  const SelectionTreeView({
    super.key,
    this.rootNodes,
    this.decoration,
    this.onSelectNode,
    this.titleBuilder,
  });

  final List<TreeNode>? rootNodes;
  final TreeDecoration? decoration;
  final Function(List<TreeNode>? rootNodes)? onSelectNode;
  final TitleBuilder? titleBuilder;

  @override
  State<SelectionTreeView> createState() => _SelectionTreeViewState();
}

class _SelectionTreeViewState extends State<SelectionTreeView> {
  @override
  void initState() {
    BlocProvider.of<TreeViewCubit>(context).initRootNodes(
      rootNodes: widget.rootNodes,
      decoration: widget.decoration,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TreeViewCubit, TreeViewState>(
      builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: state.rootNodes?.length,
          itemBuilder: (context, index) => buildTreeNode(state, index),
        );
      },
    );
  }

  Widget buildTreeNode(TreeViewState state, int index) {
    final treeWidget = <Widget>[];
    final node = state.rootNodes![index];
    if (node.parent == null) {
      treeWidget.add(itemPermission(node: node, state: state));
    }

    if (node.children.isNotEmpty) {
      void loop(TreeNode nodeChild) {
        for (final e in nodeChild.children) {
          treeWidget.add(itemPermission(node: e, state: state));
          loop(e);
        }
      }

      loop(node);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: treeWidget,
    );
  }

  Widget itemPermission({
    required TreeNode node,
    required TreeViewState state,
  }) {
    return InkWell(
      onTap: () => context.read<TreeViewCubit>().toggleNode(node),
      child: AnimatedContainer(
        duration: node.decoration.animatedDuration,
        height: node.decoration.isShowChild ? node.decoration.nodeHeight : 0,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 5),
        margin: EdgeInsets.only(
          left: node.hierarchy * 20 + (node.children.isEmpty ? 25 : 0),
        ),
        child: AnimatedOpacity(
          opacity: node.decoration.isShowChild ? 1 : 0,
          duration: const Duration(milliseconds: 100),
          child: Row(
            children: [
              if (node.children.isNotEmpty)
                AnimatedRotation(
                  turns: node.decoration.status ? 0 : 0.5,
                  duration: node.decoration.animatedDuration,
                  child: node.decoration.prefixIcon,
                ),
              Checkbox(
                value: node.isCheck,
                onChanged: (value) {
                  if (node.parent != null && node.children.isEmpty) {
                    context.read<TreeViewCubit>().onSelectNodeChildren(node);
                  } else {
                    context.read<TreeViewCubit>().onSelectParentNode(node);
                  }
                  if (widget.onSelectNode != null) {
                    widget.onSelectNode!(state.rootNodes);
                  }
                },
                tristate: true,
              ),
              if (widget.titleBuilder != null)
                widget.titleBuilder!('${node.title}')
              else
                Text('${node.title}', style: node.decoration.titleStyle),
            ],
          ),
        ),
      ),
    );
  }
}
