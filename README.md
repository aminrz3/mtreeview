# Momentum Tree View
The MTreeview widget provides an interactive, hierarchical, and draggable tree structure for Flutter applications. This widget is highly customizable and supports reordering and nesting of tree nodes with smooth animations.
The widget is based on the Flutter’s familiar APIs of [ReorderListView](https://api.flutter.dev/flutter/material/ReorderableListView-class.html) and [Draggable](https://api.flutter.dev/flutter/widgets/Draggable-class.html). All the mobile, web and desktop platforms are fully supported.
![Momentum Tree View Demo](https://media.giphy.com/media/y3zFTCr4PI4oJUWuF2/giphy.gif)

## Features

* Drag-and-drop functionality for reordering tree nodes.
* Hierarchical node structure with expandable/collapsible child nodes.
* Customizable node widgets through a builder function.
* Support for connection lines between parent and child nodes.
* Optional drag indicators for improved UX.
* Smooth animations for expanding/collapsing nodes.

## Installation

Add the following to your pubspec.yaml:
```yaml
    dependencies:
      mtreeview: latest_version
```
Then, run:
```yaml
    flutter pub get
```

## Usage

### Import the Library
```dart
    import 'package:mtreeview/treeview.dart';
```

### Basic Example
```dart
    import 'package:flutter/material.dart';
    import 'package:mtreeview/treeview.dart';
    import 'package:mtreeview/model/tree_node.dart';
    
    void main() => runApp(MyApp());
    
    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(title: Text('Treeview Example')),
            body: Treeview(
              treeNodes: _buildTreeNodes(),
              nodeBuilder: (node) => ListTile(
                title: Text(node.label),
              ),
            ),
          ),
        );
      }
    
      List<TreeNode> _buildTreeNodes() {
        return [
          TreeNode(isRoot: true, label: 'Root 1', children: [
            TreeNode(label: 'Child 1'),
            TreeNode(label: 'Child 2'),
          ]),
          TreeNode(isRoot: true, label: 'Root 2', children: [
            TreeNode(label: 'Child 3'),
          ]),
        ];
      }
    }
```

## Customizing the Widget

The `MTreeview` widget provides several customization options via its constructor:

### Constructor Parameters
| Parameter                         | Description                                                   | Default Value       |
|-----------------------------------|---------------------------------------------------------------|---------------------|
| treeNodes                         | A list of TreeNode objects representing the tree structure.   | Required            |
| nodeBuilder                       | A function to build custom widgets for each tree node.        | Required            |
| dragWidth                         | Width of the node being dragged.                              | 300                 |
| paddingNode                       | Left padding for child nodes.                                 | 38                  |
| dragOpacity                       | Opacity of the node while being dragged.                      | 0.9                 |
| showNodeConnectionLine            | Whether to show lines connecting parent and child nodes.      | false               |
| paddingLeftNodeConnectionLine     | Horizontal padding for the connection lines.                  | 13.0                |
| paddingTopNodeConnectionLine      | Vertical padding for the connection lines.                    | 50.0                |
| colorNodeConnectionLine           | Color of the connection lines.                                | Color(0xFFE4E4E7)   |
| showDragIndicator                 | Whether to show a drag indicator when dragging a node.        | true                |
| colorDragIndicator                | Color of the drag indicator.                                  | Colors.blue         |

## TreeNode Model
The `TreeNode` class represents individual nodes in the tree structure:
### TreeNode Properties:
| Property   | Description                                   |
|------------|-----------------------------------------------|
| label      | The label of the node.                        |
| children   | List of child nodes.                          |
| isRoot     | Indicates if the node is a root node.         |
| isExpanded | Indicates if the node's children are visible. |

### Example:
```dart
    TreeNode node = TreeNode(
      isRoot:true,
      label: 'Parent',
      children: [
        TreeNode(label: 'Child 1'),
        TreeNode(label: 'Child 2'),
      ],
    );
```

## Advanced Usage:

### Customizing Node Widgets
You can use the `nodeBuilder` to define custom widgets for each node:
```dart
    Treeview(
      treeNodes: _buildTreeNodes(),
      nodeBuilder: (node) => Row(
        children: [
          Icon(node.isExpanded ? Icons.expand_more : Icons.chevron_right),
          Text(node.label),
        ],
      ),
    );
```

### Reordering Logic
The `onReorder` method allows custom logic for handling node reordering. This is managed internally by the `MTreeview` widget.

## Contributions
Contributions are welcome! Feel free to open issues or submit pull requests on the ![GitHub repository]()

## License
This library is licensed under the MIT License. See the LICENSE file for details.

