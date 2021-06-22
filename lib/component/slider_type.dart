import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pc_app/model/product.dart';
import 'package:provider/provider.dart';

class SliderType extends StatelessWidget {
  final int selectedTypeId;
  final List<ProductType> items;
  final onPressed;
  SliderType(
      {required this.selectedTypeId, required this.items, this.onPressed});

  // Provider
  @override
  Widget build(BuildContext context) {
    if (items.length > 0) {
      return Align(
        alignment: Alignment.topRight,
        child: Container(
            width: ScreenUtil().setWidth(90),
            height: ScreenUtil().setHeight(502),
            decoration: const BoxDecoration(
                border: Border(
                    left: BorderSide(
              color: Colors.black12,
              width: 1.0,
            ))),
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, i) {
                  return _buildCategoryItem(items[i]);
                })),
      );
    } else {
      return Text('加载中');
    }
  }

  Widget _buildCategoryItem(ProductType item) {
    final alreadySelected = item.id == selectedTypeId;
    return InkWell(
      onTap: () => {
        if (onPressed != null) {onPressed(item.id)}
      },
      child: Container(
        decoration: BoxDecoration(
            color: alreadySelected ? Colors.blue[50] : Colors.white,
            border: alreadySelected
                ? const Border(left: BorderSide(width: 5, color: Colors.blue))
                : null),
        height: ScreenUtil().setHeight(35),
        width: ScreenUtil().setWidth(90),
        child: Center(
          child: Text(item.name,
              style: TextStyle(
                  color: alreadySelected ? Colors.blue : Colors.black,
                  fontSize: ScreenUtil().setSp(11))),
        ),
      ),
    );
  }
}
