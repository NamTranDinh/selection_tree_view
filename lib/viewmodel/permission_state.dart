part of 'permission_cubit.dart';

enum NetworkProcess { init, loading, success, failure }

class PermissionState {
  const PermissionState({
    this.rootNodes,
    this.status,
  });

  factory PermissionState.init() {
    return const PermissionState(status: NetworkProcess.init);
  }

  final List<TreeNode>? rootNodes;
  final NetworkProcess? status;

  PermissionState copyWith({
    List<TreeNode>? rootNodes,
    NetworkProcess? status,
  }) {
    return PermissionState(
      rootNodes: rootNodes ?? this.rootNodes,
      status: status ?? this.status,
    );
  }
}
