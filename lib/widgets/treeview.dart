import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mtreeview/model/tree_node.dart';

import 'helper.dart';

typedef NodeWidgetBuilder = Widget Function(TreeNode node);

class Treeview extends StatefulWidget {
  final List<TreeNode> treeNodes;
  final NodeWidgetBuilder nodeBuilder;
  final double dragWidth;
  final double paddingNode;
  final double dragOpacity;
  final bool showNodeConnectionLine;
  final double heightNodeConnectionLine;
  final double paddingLeftNodeConnectionLine;
  final double paddingTopNodeConnectionLine;
  final Color colorNodeConnectionLine;
  final bool showDragIndicator;
  final Color colorDragIndicator;

  const Treeview({
    super.key,
    required this.treeNodes,
    required this.nodeBuilder,
    this.dragWidth = 300,
    this.paddingNode = 38,
    this.dragOpacity = 0.9,
    this.showNodeConnectionLine = false,
    this.paddingLeftNodeConnectionLine = 13.0,
    this.paddingTopNodeConnectionLine = 50.0,
    this.heightNodeConnectionLine = 50.0,
    this.colorNodeConnectionLine = const Color(0xFFE4E4E7),
    this.showDragIndicator = true,
    this.colorDragIndicator = Colors.blue,
  });

  @override
  State<Treeview> createState() => _TreeviewState();
}

class _TreeviewState extends State<Treeview> {
  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      proxyDecorator: (Widget child, int index, Animation<double> animation) {
        return Material(
          color: Colors.transparent,
          child: child,
        );
      },
      buildDefaultDragHandles: false,
      onReorder: _handleReorder,
      children: widget.treeNodes
          .asMap()
          .entries
          .map((entry) => _buildReorderWidget(entry.value, entry.key))
          .toList(),
    );
  }

  void _handleReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    final movedNode = widget.treeNodes.removeAt(oldIndex);
    widget.treeNodes.insert(newIndex, movedNode);
    setState(() {});
  }

  Widget _buildReorderWidget(TreeNode node, int index, [int depth = 0]) {
    final double paddingLeft = depth > 0 ? widget.paddingNode : 0;

    return DragTarget<TreeNode>(
      key: ValueKey(index),
      onAcceptWithDetails: (details) {
        final droppedNode = details.data;
        _handleNodeDrop(node, droppedNode);
      },
      builder: (context, candidateData, rejectedData) {
        final isBeingDraggedOver = candidateData.isNotEmpty;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDragWidget(node, index,depth),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: node.isExpanded ? Padding(
                      padding: EdgeInsets.only(left: paddingLeft),
                      child: _buildChildNodes(node, depth),
                    ) : Container(),
                  ),
              ],
            ),
            if (isBeingDraggedOver && widget.showDragIndicator)
              _buildDragIndicator(),
          ],
        );
      },
    );
  }

  Widget _buildDragWidget(TreeNode node, int index,int depth) {
    if (node.isRoot) {
      return ReorderableDragStartListener(
        index: index,
        child: widget.nodeBuilder(node),
      );
    } else {
      return Draggable<TreeNode>(
        data: node,
        feedback: Material(
          color: Colors.transparent,
          child: SizedBox(
            width: widget.dragWidth,
            child: Opacity(
              opacity: widget.dragOpacity,
              child: _buildReorderWidget(node,node.children.indexOf(node),depth + 1,),
            ),
          ),
        ),
        childWhenDragging: widget.nodeBuilder(node),
        child: widget.nodeBuilder(node),
      );
    }
  }

  Widget _buildChildNodes(TreeNode node, int depth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: node.children.map((child) {
        return Stack(
          children: [
            _buildReorderWidget(child, node.children.indexOf(child), depth + 1),
            if (!child.isRoot && child.children.isNotEmpty && widget.showNodeConnectionLine)
              Padding(
                padding: EdgeInsets.only(top: widget.paddingTopNodeConnectionLine, left: widget.paddingLeftNodeConnectionLine),
                child: Container(
                  width: 1,
                  height: widget.heightNodeConnectionLine,
                  color: widget.colorNodeConnectionLine,
                ),
              ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildDragIndicator() {
    return Positioned(
      bottom: -5,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Container(
          height: 2,
          color: widget.colorDragIndicator,
        ),
      ),
    );
  }

  void _handleNodeDrop(TreeNode targetNode, TreeNode droppedNode) {
    if (droppedNode != targetNode && !droppedNode.isRoot) {
      setState(() {
        removeNode(widget.treeNodes, droppedNode);
        targetNode.children.add(droppedNode);
        targetNode.isExpanded = true;
      });
    }
  }
}