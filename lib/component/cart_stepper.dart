import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pc_app/model/product.dart';
import 'package:pc_app/provider/cart.dart';
import 'package:provider/provider.dart';

class CartStepper extends StatefulWidget {
  CartStepper(
      {@required this.value,
      this.onRemove,
      this.onAdd,
      this.type,
      this.product});

  final double? value;

  CartType? type;

  // 减少数量
  Function? onRemove;

  // 增加数量
  Function? onAdd;

  ProductInfo? product;

  @override
  _StepperState createState() => _StepperState();
}

class _StepperState extends State<CartStepper> {
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
      onTap: () => {
        if (widget.onRemove != null)
          {widget.onRemove!()}
        else if (widget.type != null)
          {
            context
                .read<CartProvider>()
                .reduceProduct(type: widget.type!, product: widget.product!)
          }
      },
      child: Padding(
        padding: EdgeInsets.only(right: 12),
        child: Image(
            width: 18.w, height: 18.w, image: AssetImage('assets/bt_cut.png')),
      ),
    );
  }

  Widget _buildRightButton() {
    return InkWell(
      onTap: () => {
        if (widget.onRemove != null)
          {widget.onRemove!()}
        else if (widget.type != null)
          {
            context
                .read<CartProvider>()
                .addProduct(type: widget.type!, product: widget.product!)
          }
      },
      child: Padding(
        padding: EdgeInsets.only(left: 12),
        child: Image(
            width: 18.w,
            height: 18.w,
            image: AssetImage('assets/bt_increase.png')),
      ),
    );
  }
}
