import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tree_view_flutter/models/tree_node.dart';
import 'package:tree_view_flutter/viewmodel/permission_cubit.dart';

class ListPermission extends StatefulWidget {
  const ListPermission({super.key});

  @override
  State<ListPermission> createState() => _ListPermissionState();
}

class _ListPermissionState extends State<ListPermission> {
  double turns = 0;

  @override
  void initState() {
    BlocProvider.of<PermissionCubit>(context).getPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: BlocBuilder<PermissionCubit, PermissionState>(
        builder: (context, state) {
          if (state.status == NetworkProcess.success) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.rootNodes?.length,
              itemBuilder: (context, index) => buildTreeNode(state, index),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildTreeNode(PermissionState state, int index) {
    final treeWidget = <Widget>[];
    final node = state.rootNodes![index];
    if (node.parent == null) {
      treeWidget.add(itemPermission(node: node));
    }

    if (node.children.isNotEmpty) {
      void loop(TreeNode nodeChild) {
        for (final e in nodeChild.children) {
          treeWidget.add(itemPermission(node: e));
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

  void toggleNode(TreeNode node) {
    final status = node.decoration.status = !node.decoration.status;
    findChildren(node, status);
    setState(() {});
  }

  void findChildren(TreeNode node, bool status) {
    for (final e in node.children) {
      e.decoration.isShowChild = status;
      e.decoration.status = status;
      findChildren(e, status);
    }
  }

  Widget itemPermission({required TreeNode node}) {
    return InkWell(
      onTap: () => toggleNode(node),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
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
                  duration: const Duration(milliseconds: 150),
                  child: const Icon(Icons.arrow_drop_up),
                ),
              Checkbox(
                value: node.isCheck,
                onChanged: (value) {
                  if (node.parent != null && node.children.isEmpty) {
                    context.read<PermissionCubit>().onSelectNodeChildren(node);
                  } else {
                    context.read<PermissionCubit>().onSelectParentNode(node);
                  }
                },
                tristate: true,
              ),
              Text('${node.title}'),
            ],
          ),
        ),
      ),
    );
  }

  List<TreeNode> getAllChild(TreeNode node) {
    final nodeChild = <TreeNode>[];
    void traverseChildren(TreeNode currentNode) {
      nodeChild.add(currentNode);
      currentNode.children.forEach(traverseChildren);
    }

    traverseChildren(node);
    return nodeChild;
  }
}
