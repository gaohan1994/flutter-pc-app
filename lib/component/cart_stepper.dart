import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartStepper extends StatefulWidget {
  CartStepper(
      {@required this.value, @required this.onRemove, @required this.onAdd});

  final int? value;

  // 减少数量
  final void onRemove;

  // 增加数量
  final void onAdd;

  @override
  _StepperState createState() => _StepperState();
}

class _StepperState extends State<CartStepper> {
  final fontStyle = TextStyle(
      // fontSize: ScreenUtil().setSp(12),
      );

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildLeftButton(),
        _buildValue(),
        _buildRightButton(),
      ],
    );
  }

  Widget _buildValue() {
    return Text('${widget.value}',
        style: TextStyle(fontSize: ScreenUtil().setSp(14)));
  }

  Widget _buildLeftButton() {
    return InkWell(
      onTap: () => {},
      child: const Padding(
        padding: EdgeInsets.only(right: 12),
        child: Icon(
          Icons.remove_circle_outline,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildRightButton() {
    return InkWell(
      onTap: () => {},
      child: const Padding(
        padding: EdgeInsets.only(left: 12),
        child: Icon(
          Icons.control_point,
          color: Colors.blue,
        ),
      ),
    );
  }
}
