import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pc_app/model/product.dart';

enum CartProductDialogMethod {
  Cancel,
  Submit,
}

class Product extends StatefulWidget {
  Product({required this.item});

  ProductInfo item;

  @override
  State<StatefulWidget> createState() {
    return _ProductState();
  }
}

class _ProductState extends State<Product> {
  // 收银台 dialog 表单 key
  final cartProductDialogFormKey = GlobalKey<FormState>();

  // 数量
  String _count = '';

  // 价格
  String _price = '';

  // 折扣
  String _discount = '';

  // 备注
  String _remark = '';

  void onProductClick() {
    openCartProductDialog(widget.item.name);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onProductClick,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3.0),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade50,
                offset: Offset(0, 3),
                blurRadius: 20,
                spreadRadius: 2,
              )
            ]),
        width: ScreenUtil().setWidth(100),
        margin: const EdgeInsets.only(bottom: 4, right: 7),
        child: Column(
          children: [
            widget.item.pic != null && widget.item.pic != ""
                ? Image.network(
                    widget.item.pic ?? '',
                    fit: BoxFit.cover,
                    width: ScreenUtil().setWidth(100),
                    height: ScreenUtil().setHeight(90),
                  )
                : Image(
                    image: const AssetImage('assets/img_default_image.png'),
                    fit: BoxFit.cover,
                    width: ScreenUtil().setWidth(100),
                    height: ScreenUtil().setHeight(90),
                  ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                children: [
                  Container(
                    width: 90.w,
                    height: 22.h,
                    child: Text(
                      widget.item.name,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: ScreenUtil().setSp(9)),
                    ),
                  ),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('￥',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: ScreenUtil().setSp(9))),
                        Text(
                          widget.item.price.toString(),
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: ScreenUtil().setSp(12)),
                        ),
                        Text(
                            ' /${widget.item.unit != null ? widget.item.unit : '个'}',
                            style: TextStyle(fontSize: ScreenUtil().setSp(9))),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future openCartProductDialog(item) async {
    final option = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.all(0),
            titlePadding: EdgeInsets.all(0),
            title: Container(
              padding: EdgeInsets.all(12),
              color: Colors.blue,
              child: const Text(
                '蒙牛特仑苏新西兰纯牛奶',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                child: Form(
                    key: cartProductDialogFormKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          onSaved: (val) {
                            if (val != null) {
                              _count = val;
                            }
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '请输入数量';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: '请输入数量', labelText: '数量'),
                        ),
                        TextFormField(
                          onSaved: (val) {
                            if (val != null) {
                              _price = val;
                            }
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '请输入价格';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: '请输入价格',
                              labelText: '价格',
                              prefixText: '￥'),
                        ),
                        TextFormField(
                          onSaved: (val) {
                            if (val != null) {
                              _discount = val;
                            }
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return '请输入折扣';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: '请输入折扣',
                              labelText: '折扣',
                              suffixText: '%'),
                        ),
                        TextFormField(
                          onSaved: (val) {
                            if (val != null) {
                              _remark = val;
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: '备注',
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: ScreenUtil().setWidth(100),
                                height: ScreenUtil().setWidth(30),
                                child: OutlinedButton(
                                    onPressed: () => Navigator.pop(context,
                                        CartProductDialogMethod.Cancel),
                                    child: Text('取消')),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(100),
                                height: ScreenUtil().setWidth(30),
                                child: ElevatedButton(
                                    onPressed: () => {
                                          if (cartProductDialogFormKey
                                              .currentState!
                                              .validate())
                                            {
                                              Navigator.pop(
                                                  context,
                                                  CartProductDialogMethod
                                                      .Submit)
                                            }
                                        },
                                    child: Text('确定')),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              )
            ],
          );
        });
    switch (option) {
      case CartProductDialogMethod.Submit:
        final formState = cartProductDialogFormKey.currentState;

        if (formState!.validate()) {
          formState.save();

          print('_count: ${_count}');
          print('_price: ${_price}');
          print('_discount: ${_discount}');
          print('_remark: ${_remark}');
        }
        break;
    }
  }
}
