class TreeNode {
  final String title;
  final List<TreeNode> children;
  bool isExpanded;
  bool isRoot;

  TreeNode({
    this.isRoot = false,
    required this.title,
    List<TreeNode>? children,
    this.isExpanded = false,
  }) : children = children ?? [];
}