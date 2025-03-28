import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selection_tree_view/models/permission_model.dart';
import 'package:selection_tree_view/models/tree_decoration.dart';
import 'package:selection_tree_view/models/tree_node.dart';

part 'tree_view_state.dart';

class TreeViewCubit extends Cubit<TreeViewState> {
  TreeViewCubit() : super(TreeViewState.init());

  Future<void> initRootNodes({
    List<TreeNode>? rootNodes,
    TreeDecoration? decoration,
  }) async {
    // fake data for demo
    if (rootNodes == null) {
      final listPermission = PermissionModel.fakeData();
      final data = mapToTreeNodes(listPermission);
      // init decoration for fake data
      if (decoration != null) setDecoration(decoration, data);

      emit(state.copyWith(rootNodes: data));
    } else {
      if (decoration != null) setDecoration(decoration, rootNodes);
      emit(
        state.copyWith(
          rootNodes: rootNodes,
        ),
      );
    }
  }

  void setDecoration(TreeDecoration decoration, List<TreeNode> rootNodes) {
    for (final e in rootNodes) {
      e.decoration = e.decoration.copyWith(
        nodeHeight: decoration.nodeHeight,
        // status: decoration.status,
        // isShowChild: decoration.isShowChild,
        titleStyle: decoration.titleStyle,
        prefixIcon: decoration.prefixIcon,
        animatedDuration: decoration.animatedDuration,
      );
      setDecoration(decoration, e.children);
    }
  }

  List<TreeNode> mapToTreeNodes(List<PermissionModel> permissions) {
    final nodesMap = <String, TreeNode>{};
    final rootNodes = <TreeNode>[];

    for (final item in permissions) {
      final paths = item.path?.trim().split(r'\\');
      TreeNode? currentParent;

      for (var i = 0; i < (paths?.length ?? 0); i++) {
        final path = paths![i];

        final hierarchyLevel = i;

        final currentNode = nodesMap.putIfAbsent(path, () {
          final newNode = TreeNode(
            title: path,
            code: path,
            children: [],
            hierarchy: hierarchyLevel,
            parent: currentParent,
          );

          if (currentParent != null) {
            currentParent.children.add(newNode);
          } else {
            rootNodes.add(newNode);
          }

          return newNode;
        });

        currentParent = currentNode;
      }

      final permissionNode = TreeNode(
        title: item.name,
        code: item.code,
        parent: currentParent,
        hierarchy: (currentParent?.hierarchy ?? 0) + 1,
        children: [],
      );

      currentParent?.children.add(permissionNode);
    }

    return rootNodes;
  }

  void onSelectNodeChildren(TreeNode node) {
    if (node.children.isEmpty) {
      node.isCheck = !(node.isCheck ?? false);
    }

    if (node.children.isNotEmpty && node.parent != null) {
      final allSelected = node.children.every((e) {
        return e.isCheck == true;
      });
      if (allSelected) {
        node.isCheck = true;
      } else {
        if (node.children.every((e) => e.isCheck == false)) {
          node.isCheck = false;
        } else {
          node.isCheck = null;
        }
      }
    }

    if (node.parent != null) {
      onSelectNodeChildren(node.parent!);
    } else {
      final allSelected = node.children.every((e) {
        return e.isCheck == true;
      });
      if (allSelected) {
        node.isCheck = true;
      } else {
        if (node.children.every((e) => e.isCheck == false)) {
          node.isCheck = false;
        } else {
          node.isCheck = null;
        }
      }
    }
    emit(state.copyWith(rootNodes: state.rootNodes));
  }

  void onSelectParentNode(TreeNode node, {bool? parentStatus}) {
    node.isCheck = parentStatus ?? !(node.isCheck ?? false);

    if (node.children.isNotEmpty) {
      for (final child in node.children) {
        onSelectParentNode(child, parentStatus: node.isCheck);
      }
    }

    if (node.parent != null) {
      onSelectNodeChildren(node.parent!);
    }

    emit(state.copyWith(rootNodes: state.rootNodes));
  }

  void toggleNode(TreeNode node) {
    final status = node.decoration.status = !node.decoration.status;
    findChildren(node, status);
    emit(state.copyWith(rootNodes: state.rootNodes));
  }

  void findChildren(TreeNode node, bool status) {
    for (final child in node.children) {
      child.decoration.isShowChild = status;
      child.decoration.status = status;
      findChildren(child, status);
    }
  }
}
