import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tree_view_flutter/models/permission_model.dart';
import 'package:tree_view_flutter/models/tree_node.dart';

part 'permission_state.dart';

class PermissionCubit extends Cubit<PermissionState> {
  PermissionCubit() : super(PermissionState.init());

  Future<void> getPermissions() async {
    emit(state.copyWith(status: NetworkProcess.loading));
    await Future<void>.delayed(const Duration(milliseconds: 1500));
    final listPermission = PermissionModel.fakeData();

    final data = mapToTreeNodes(listPermission);

    emit(state.copyWith(status: NetworkProcess.success, rootNodes: data));
  }

  Map<String, List<PermissionModel>> groupPermissionsByPath(
    List<PermissionModel> permissions,
  ) {
    final groupedPermissions = <String, List<PermissionModel>>{};

    for (final permission in permissions) {
      final hierarchy = permission.path?.split(r'\\');
      for (var i = 0; i < (hierarchy?.length ?? 0); i++) {
        final pathKey = permission.path?.split(r'\\')[i].trim();
        if (pathKey != null && pathKey.isNotEmpty) {
          groupedPermissions.putIfAbsent(pathKey, () => []).add(permission);
        }
      }
    }

    return groupedPermissions;
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
}
