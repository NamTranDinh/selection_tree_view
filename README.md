# Selection Tree View


[![Pub Version](https://img.shields.io/pub/v/selection_tree_view?color=blue&logo=dart)](https://pub.dev/packages/selection_tree_view)
[![Pub Points](https://img.shields.io/pub/points/selection_tree_view?color=blue&logo=dart)](https://pub.dev/packages/selection_tree_view)
<!--[![License](https://img.shields.io/github/license/monkeyWie/flutter_treeview)](https://github.com/NamTranDinh/selection_tree_view/blob/main/LICENSE)-->

A Flutter package providing a customizable and interactive tree view with selection capabilities.

## Screenshots

![](lib/screenshots/example_web.mov)
![](lib/screenshots/example_mobile.mov)

## Features

- Hierarchical data display
- Expandable/collapsible buttons
- Customizable button appearance

## Getting Started

To use the `SelectionTreeView` widget in your Flutter project, follow these steps:

```
flutter pub add selection_tree_view
```

## Usage

Here's a basic example of how to use the `SelectionTreeView` widget:

```dart
import 'package:flutter/material.dart';
import 'package:selection_tree_view/models/mock_data_model.dart';
import 'package:selection_tree_view/screens/selection_tree_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Selection Tree View',
      home: Scaffold(
        appBar: AppBar(title: Text('Selection Tree View')),
        body: SelectionTreeView(
          rootNodes: MockDataModel.mockTreeData(),
          onSelectNode: (rootNodes, nodeSelected) {},
          treeRowDecoration: (node, index) {
            return BoxDecoration(
              color: index % 2 == 0 ? Colors.grey.shade100 : Colors.white,
            );
          },
          // prefixIconBuilder: (node) {
          //   return node.children.isEmpty
          //       ? SizedBox()
          //       : Icon(Icons.arrow_drop_up);
          // },
          // treeConfiguration: TreeConfiguration(
          //   showCheckbox: true,
          //   animatePrefixIcon: false,
          // ),
          // titleBuilder: (title) {
          //   return Text(
          //     title,
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontWeight: FontWeight.bold,
          //       fontSize: 12,
          //     ),
          //     maxLines: 1,
          //     overflow: TextOverflow.ellipsis,
          //   );
          // },
        ),
      ),
    );
  }
}

```

## Customization

The `SelectionTreeView` widget offers various customization options:


* **`treeConfiguration` (TreeConfiguration):**
    * `titleStyle` (TextStyle): Node title style.
    * `nodeHeight` (double): Row height.
    * `prefixIcon` (Widget): Default prefix icon.
    * `animatedDuration` (Duration): Animation speed.
    * `showCheckbox` (bool): Show checkboxes.
    * `animatePrefixIcon` (bool): Animate prefix icon.
* **`titleBuilder` (Widget Function(String title)):** Custom title widget.
* **`prefixIconBuilder` (Widget Function(TreeNode node)):** Custom prefix icon widget.
* **`treeRowDecoration` (BoxDecoration Function(TreeNode node, int index)):** Row decoration.

For more advanced customization, refer to the API documentation.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/NamTranDinh/selection_tree_view/blob/main/LICENSE) file for details.