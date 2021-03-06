import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DrawerStack extends StatelessWidget {
  final GlobalKey<DrawerControllerState> _drawerKey = GlobalKey<DrawerControllerState>();
  final drawerScrimColor = Color.fromARGB(90, 100, 100, 128);
  final double drawerEdgeDragWidth = null;
  final DragStartBehavior drawerDragStartBehavior = DragStartBehavior.start;

  final Widget body;
  final Drawer drawer;

  DrawerStack({Key key, this.body, this.drawer}) : super(key: key);

  void openDrawer() {
    _drawerKey.currentState?.open();
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      body,
      DrawerController(
        key: _drawerKey,
        alignment: DrawerAlignment.start,
        child: drawer,
        drawerCallback: (_){},
        dragStartBehavior: drawerDragStartBehavior,
        scrimColor: drawerScrimColor,
        edgeDragWidth: drawerEdgeDragWidth,
      ),
    ],
  );
}