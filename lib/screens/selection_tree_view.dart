import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selection_tree_view/models/tree_node.dart';
import 'package:selection_tree_view/models/tree_configuration.dart';
import 'package:selection_tree_view/utils/extensions.dart';
import 'package:selection_tree_view/utils/globals.dart';
import 'package:selection_tree_view/viewmodel/tree_view_cubit.dart';

class SelectionTreeView extends StatefulWidget {
  const SelectionTreeView({
    super.key,
    required this.rootNodes,
    required this.onSelectNode,
    this.treeConfiguration,
    this.titleBuilder,
    this.prefixIconBuilder,
    this.treeRowDecoration,
  });

  final List<TreeNode> rootNodes;
  final TreeConfiguration? treeConfiguration;
  final Function(List<TreeNode>? rootNodes, TreeNode nodeSelected) onSelectNode;
  final TitleBuilder? titleBuilder;
  final PrefixIconBuilder? prefixIconBuilder;
  final TreeRowDecoration? treeRowDecoration;

  @override
  State<SelectionTreeView> createState() => _SelectionTreeViewState();
}

class _SelectionTreeViewState extends State<SelectionTreeView> {
  late TreeViewCubit cubit;
  late int itemIndex;

  @override
  void initState() {
    cubit = TreeViewCubit();
    itemIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TreeViewCubit>.value(
      value: cubit
        ..initRootNodes(
          rootNodes: widget.rootNodes,
          treeConfiguration: widget.treeConfiguration,
        ),
      child: BlocBuilder<TreeViewCubit, TreeViewState>(
        builder: (context, state) {
          return Material(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.rootNodes?.length,
              itemBuilder: (context, index) => buildTreeNode(state, index),
            ),
          );
        },
      ),
    );
  }

  Widget buildTreeNode(TreeViewState state, int index) {
    final treeWidget = <Widget>[];
    final node = state.rootNodes![index];
    if (node.parent == null) {
      treeWidget.add(
        itemPermission(node: node, state: state, index: itemIndex++),
      );
    }

    if (node.children.isNotEmpty) {
      void loop(TreeNode nodeChild) {
        for (final e in nodeChild.children) {
          treeWidget.add(
            itemPermission(node: e, state: state, index: itemIndex++),
          );
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
    required int index,
  }) {
    return InkWell(
      onTap: () => cubit.collapseExpandNode(node),
      child: AnimatedContainer(
        duration: node.treeConfiguration.animatedDuration,
        height: node.treeConfiguration.isShowChild
            ? node.treeConfiguration.nodeHeight
            : 0,
        alignment: Alignment.centerLeft,
        decoration: widget.treeRowDecoration != null
            ? widget.treeRowDecoration!(node, index)
            : null,
        padding: EdgeInsets.only(
          top: 5,
          bottom: 5,
          left: node.hierarchy * 20 + (node.children.isEmpty ? 25 : 0),
        ),
        child: AnimatedOpacity(
          opacity: node.treeConfiguration.isShowChild ? 1 : 0,
          duration: const Duration(milliseconds: 100),
          child: Row(
            children: [
              AnimatedRotation(
                turns: node.treeConfiguration.animatePrefixIcon &&
                        node.treeConfiguration.isExpanded
                    ? 0
                    : 0.5,
                duration: node.treeConfiguration.animatedDuration,
                child: widget.prefixIconBuilder != null
                    ? widget.prefixIconBuilder!(node)
                    : node.children.isEmpty
                        ? SizedBox()
                        : node.treeConfiguration.prefixIcon,
              ),
              if (node.treeConfiguration.showCheckbox)
                Checkbox(
                  value: node.isCheck,
                  onChanged: (value) {
                    if (node.parent != null && node.children.isEmpty) {
                      cubit.onSelectNodeChildren(node);
                    } else {
                      cubit.onSelectParentNode(node);
                    }
                    widget.onSelectNode(state.rootNodes, node);
                  },
                  tristate: true,
                ),
              if (widget.titleBuilder != null)
                widget.titleBuilder!('${node.title}')
              else
                Expanded(
                  child: Text(
                    '${node.title?.trim().toFirstCapital}',
                    style: node.treeConfiguration.titleStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
