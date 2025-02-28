class TreeNode<T> {
  T value;
  List<TreeNode<T>> children = [];

  TreeNode(this.value);

  void addChild(TreeNode<T> child) {
    children.add(child);
  }

  void traverse(void Function(T) action) {
    action(value);
    for (var child in children) {
      child.traverse(action);
    }
  }
}
