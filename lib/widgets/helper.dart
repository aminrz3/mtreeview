import 'package:flutter/material.dart';
import 'package:mtreeview/model/tree_node.dart';

void addChild(TreeNode parentNode, TreeNode newNode) {
  parentNode.children.add(newNode);
  parentNode.isExpanded = true;
}

void removeNode(List<TreeNode> nodeList, TreeNode nodeToRemove) {
  nodeList.removeWhere((node) {
    if (node == nodeToRemove) {
      return true;
    } else if (node.children.isNotEmpty) {
      removeNode(node.children, nodeToRemove);
    }
    return false;
  });
}