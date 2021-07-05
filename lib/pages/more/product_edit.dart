import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pc_app/component/button.dart';
import 'package:pc_app/component/form/form_input.dart';
import 'package:pc_app/model/product.dart';
import 'package:pc_app/provider/product.dart';
import 'package:pc_app/route/application.dart';
import 'package:pc_app/service/product_method.dart';
import 'package:pc_app/service/service_url.dart';
import 'package:provider/provider.dart';

class ProductEdit extends StatefulWidget {
  ProductEdit({Key? key, this.isEdit = true}) : super(key: key);

  final bool isEdit;

  @override
  createState() => _ProductEdit();
}

class _ProductEdit extends State<ProductEdit> {
  final TextEditingController cName = TextEditingController();
  final TextEditingController cBarcode = TextEditingController();
  final TextEditingController cPrice = TextEditingController();
  final TextEditingController cCost = TextEditingController();
  final TextEditingController cMemberPrice = TextEditingController();
  final TextEditingController cLimitNum = TextEditingController();
  final TextEditingController cStandard = TextEditingController();
  final TextEditingController cUnit = TextEditingController();
  final TextEditingController cBrand = TextEditingController();

  // 上架
  int status = 1;
  // 销售类型 1 称重，0 普通
  int saleType = 0;
  // 供应商id
  int supplierId = 0;

  // 是否显示详细信息
  bool showMore = false;

  @override
  initState() {
    super.initState();
    ProductInfo? productDetail = context.read<ProductProvider>().productDetail;
    List<ProductSupplier> supplierList =
        context.read<ProductProvider>().productSupplierList;

    // 如果是修改则初始化数据
    if (widget.isEdit == true) {
      setState(() {
        cName.text = productDetail?.name ?? '';
        cBarcode.text = productDetail?.barcode ?? '';
        cPrice.text =
            productDetail?.price != null ? '${productDetail?.price}' : '';
        cCost.text =
            productDetail?.cost != null ? '${productDetail?.cost}' : '';
        cMemberPrice.text = productDetail?.memberPrice != null
            ? '${productDetail?.memberPrice}'
            : '';
        cLimitNum.text =
            productDetail?.limitNum != null ? '${productDetail?.limitNum}' : '';
        cStandard.text =
            productDetail?.standard != null ? '${productDetail?.standard}' : '';
        cUnit.text =
            productDetail?.unit != null ? '${productDetail?.unit}' : '';
        cBrand.text =
            productDetail?.brand != null ? '${productDetail?.brand}' : '';
        status = productDetail?.status != null ? productDetail!.status! : 1;
        saleType =
            productDetail?.saleType != null ? productDetail!.saleType! : 1;
        supplierId = productDetail?.supplierId != null
            ? productDetail!.supplierId!
            : supplierList[0].id;
      });
    } else {
      // 新增商品 默认设置一下barcode
      setBarcode();
      setState(() {
        supplierId = supplierList[0].id;
      });
    }
  }

  // 确定
  void onSubmit() async {
    if (cBarcode.text.isEmpty) {
      showToast('请输入条码');
      return;
    }
    if (cName.text.isEmpty) {
      showToast('请输入商品名称');
      return;
    }

    EasyLoading.show(status: '请稍候');

    ProductInfo? productDetail = context.read<ProductProvider>().productDetail;

    // 新增商品的报文
    ProductInfo info = ProductInfo(
        name: cName.text,
        barcode: cBarcode.text,
        price: cPrice.text.isNotEmpty ? double.parse(cPrice.text) : 0,
        status: status,
        supplierId: supplierId,
        saleType: saleType);

    if (cCost.text.isNotEmpty) {
      info.cost = double.parse(cCost.text);
    }
    if (cMemberPrice.text.isNotEmpty) {
      info.memberPrice = double.parse(cMemberPrice.text);
    }
    if (cLimitNum.text.isNotEmpty) {
      info.limitNum = double.parse(cLimitNum.text);
    }
    if (cStandard.text.isNotEmpty) {
      info.standard = cStandard.text;
    }
    if (cUnit.text.isNotEmpty) {
      info.unit = cUnit.text;
    }
    if (cBrand.text.isNotEmpty) {
      info.brand = cBrand.text;
    }

    // 如果是编辑则加入商品id
    if (widget.isEdit == true) {
      info.id = productDetail!.id!;
    }

    dynamic result;

    if (widget.isEdit == true) {
      result = await fetchProductEdit(params: info.toJson());
    } else {
      result = await fetchProductAdd(params: info.toJson());
    }

    var resultMap = json.decode(result.toString());

    EasyLoading.dismiss();
    if (resultMap['code'] == successCode) {
      showToast(widget.isEdit == true ? '修改成功！' : '新增成功!');

      context.read<ProductProvider>().getProducts();
      Application.router?.pop(context);
    }
  }

  // 设置条码
  void setBarcode() async {
    var result = await genBarcode();
    var resultMap = json.decode(result.toString());
    if (resultMap['code'] == successCode) {
      setState(() {
        cBarcode.text = resultMap['data'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 960.w,
            height: 40.w,
            color: Colors.blue,
            alignment: Alignment.center,
            child: Text(
              '${widget.isEdit == true ? '编辑' : '新增'}商品',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(16), color: Colors.white),
            ),
          ),
          _buildBody(),
          Container(
            height: ScreenUtil().setHeight(30),
            width: ScreenUtil().setWidth(90),
            margin: const EdgeInsets.only(bottom: 12),
            child: ElevatedButton(
              onPressed: () => onSubmit(),
              child: const Text('确定'),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBody() {
    List<ProductSupplier> supplierList =
        context.read<ProductProvider>().productSupplierList;
    if (showMore == false) {
      return Expanded(
          child: Container(
        margin: EdgeInsets.only(top: 20.w),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    GhFormInput(
                      width: 350.w,
                      title: '条码',
                      controller: cBarcode,
                      hintText: '请输入条码',
                      rightWidget: GhButton(
                        title: '重新生成',
                        onPressed: () {
                          setBarcode();
                        },
                        width: 85,
                        height: 30,
                      ),
                    ),
                    GhFormInput(
                      width: 350.w,
                      title: '名称',
                      controller: cName,
                      hintText: '请输入名称',
                    ),
                    _buildMore(),
                  ],
                )),
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    GhFormInput(
                      width: 350.w,
                      title: '售价￥',
                      hintText: '请输入售价',
                      controller: cPrice,
                    ),
                    GhFormInput(
                      width: 350.w,
                      title: '进价￥',
                      hintText: '请输入进价',
                      controller: cCost,
                    ),
                    GhFormInput(
                      width: 350.w,
                      title: '会员价￥',
                      hintText: '请输入会员价',
                      controller: cMemberPrice,
                    ),
                  ],
                )),
          ],
        ),
      ));
    } else {
      return Expanded(
          child: Container(
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    _buildMore(),
                    GhFormInput(
                      width: 350.w,
                      title: '库存预警',
                      controller: cLimitNum,
                      hintText: '请输入名称',
                    ),
                    GhFormInput(
                      width: 350.w,
                      title: '规格',
                      controller: cStandard,
                      hintText: '请输入规格',
                    ),
                    GhFormInput(
                      width: 350.w,
                      title: '单位',
                      controller: cUnit,
                      hintText: '请输入单位',
                    ),
                  ],
                )),
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                      height: 30.w,
                    ),
                    GhFormInput(
                      width: 350.w,
                      title: '品牌',
                      controller: cBrand,
                      hintText: '请输入品牌',
                    ),
                    GhFormInput(
                      width: 350.w,
                      hiddenLine: true,
                      title: '销售状态',
                      mainWidget: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(right: 8.w),
                                child: _option(0, '按件售卖', saleType, (value) {
                                  setState(() {
                                    saleType = value;
                                  });
                                }),
                              )),
                          Expanded(
                            flex: 1,
                            child: _option(1, '称重商品', saleType, (value) {
                              setState(() {
                                saleType = value;
                              });
                            }),
                          )
                        ],
                      ),
                    ),
                    GhFormInput(
                      width: 350.w,
                      hiddenLine: true,
                      title: '商品状态',
                      mainWidget: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(right: 8.w),
                                child: _option(1, '正常', status, (value) {
                                  setState(() {
                                    status = value;
                                  });
                                }),
                              )),
                          Expanded(
                            flex: 1,
                            child: _option(0, '下架', status, (value) {
                              setState(() {
                                status = value;
                              });
                            }),
                          )
                        ],
                      ),
                    ),
                    GhFormInput(
                      width: 350.w,
                      title: '供应商',
                      mainWidget: DropdownButton(
                        underline: Container(height: 0),
                        isExpanded: true,
                        value: supplierId,
                        items: supplierList
                            .map((item) => DropdownMenuItem(
                                value: item.id, child: Text(item.name)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            supplierId = value as int;
                          });
                        },
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ));
    }
  }

  Widget _title(title) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        width: 350.w,
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            border: Border(left: BorderSide(width: 3, color: Colors.blue))),
        child: Text(title,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(12), color: Colors.blue)),
      ),
    );
  }

  Widget _buildMore() {
    return InkWell(
      onTap: () {
        setState(() {
          showMore = !showMore;
        });
      },
      child: Container(
        padding: EdgeInsets.only(left: 80.w, top: 10.w, bottom: 10.w),
        child: Row(
          children: [
            Text(
              '更多信息',
              style: TextStyle(fontSize: 12, color: Colors.blue),
            ),
            Container(
              margin: EdgeInsets.only(left: 4.w),
              child: Image(
                  width: 12.w,
                  height: 12.w,
                  image: showMore == true
                      ? const AssetImage('assets/icon_zhankai.png')
                      : const AssetImage('assets/icon_suo.png')),
            )
          ],
        ),
      ),
    );
  }

  Widget _option(value, title, selectedValue, onPressed) {
    final bool _selected = value == selectedValue;
    return InkWell(
      onTap: () {
        onPressed(value);
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: _selected ? Colors.blue[100] : Colors.transparent,
            border: Border.all(
                width: 1,
                color: _selected ? Colors.blue.shade100 : Colors.black12)),
        height: 30.w,
        child: Text(title,
            style: TextStyle(color: _selected ? Colors.blue : Colors.black)),
      ),
    );
  }
}
