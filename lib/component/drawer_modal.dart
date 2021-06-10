import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerButton {
  final String title;
  final Color color = Colors.blue;

  DrawerButton(this.title);
}

class DrawerModal extends StatelessWidget {
  final double elevation;
  final Widget child;
  final String title;
  final List<DrawerButton> buttons;

  DrawerModal(
      {required this.child,
      this.elevation = 16,
      this.title = '',
      this.buttons = const []});

  @override
  Widget build(BuildContext context) {
    double _drawerWidth = ScreenUtil().setWidth(540);

    // Drawer

    return Semantics(
      scopesRoute: true,
      namesRoute: true,
      explicitChildNodes: true,
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(width: _drawerWidth),
        child: Material(
          elevation: elevation,
          child: Column(
            children: [_buildTitle(), Expanded(child: child), _buildButton()],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    if (title.isNotEmpty) {
      return Container(
          width: 540.w,
          height: 38.w,
          color: Colors.blue,
          child: Center(
              child: Text(title,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(16), color: Colors.white))));
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _buildButton() {
    if (buttons.isNotEmpty) {
      return Container(
          width: 540.w,
          child: Row(
              children: buttons.map((button) {
            return Expanded(
                flex: 1,
                child: ElevatedButton(
                    onPressed: () => {},
                    child: Container(
                      height: 38.w,
                      child: Center(
                        child: Text(button.title),
                      ),
                    )));
          }).toList()));
    } else {
      return SizedBox.shrink();
    }
  }
}
