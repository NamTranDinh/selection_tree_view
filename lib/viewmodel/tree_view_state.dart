part of 'tree_view_cubit.dart';

enum NetworkProcess { init, loading, success, failure }

class TreeViewState {
  const TreeViewState({
    this.rootNodes,
    this.status,
  });

  factory TreeViewState.init() {
    return const TreeViewState();
  }

  final List<TreeNode>? rootNodes;
  final NetworkProcess? status;

  TreeViewState copyWith({
    List<TreeNode>? rootNodes,
    NetworkProcess? status,
  }) {
    return TreeViewState(
      rootNodes: rootNodes ?? this.rootNodes,
      status: status ?? this.status,
    );
  }
}
