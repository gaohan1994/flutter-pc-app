import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pc_app/model/cart.dart';
import 'package:pc_app/model/member.dart';
import 'package:pc_app/model/product.dart';
import 'package:pc_app/service/member_method.dart';

enum CartType {
  Home,
  Refund,
}

class CartProvider extends ChangeNotifier {
  // 下单选中的会员
  MemberDetail? selectedMember;

  List<ProductInfo> cart = [];

  List<ProductInfo> refundCart = [];

  List<CartDelay> delayList = [];

  // 获取传入商品计算时的售价
  double getCurrentProductPrice(ProductInfo product, MemberDetail? member) {
    // 当前商品的售价
    double _currentSellPrice = product.price;

    // 如果选择了会员则使用会员价
    if (member != null) {
      _currentSellPrice = product.memberPrice ?? product.price;
    }

    // 如果改了价则使用改价，改价优先级大于会员价
    if (product.unitPrice != null) {
      _currentSellPrice = product.unitPrice!;
    }

    return _currentSellPrice;
  }

  // 传入手机号 设置选中的会员
  Future setMember(String phone) async {
    if (phone.isEmpty) {
      showToast('请输入会员手机号');
      return;
    }
    var result = await memberDetailByPreciseInfo(identity: phone);
    var resultMap = json.decode(result.toString());
    print('resultMap: ${resultMap}');
    var _selectedMember = MemberDetail.fromJson(resultMap['data']);
    print('_selectedMember: ${_selectedMember}');
    selectedMember = _selectedMember;
    notifyListeners();
  }

  // 添加商品到购物车
  void addProduct(
      {CartType type = CartType.Home,
      required ProductInfo product,
      double? sellNum,
      String? remark,
      double? unitPrice}) {
    // 获取当前购物车
    List<ProductInfo> _currentCart = [];

    switch (type) {
      case CartType.Home:
        _currentCart = cart;
        break;
      case CartType.Refund:
        _currentCart = refundCart;
        break;
    }

    // 找到购物车里的index
    int index =
        _currentCart.indexWhere((_cartItem) => _cartItem.id == product.id);

    if (index == -1) {
      // 购物车中没有该商品则插入
      _currentCart.add(product
        ..sellNum = sellNum ?? 1
        ..remark = remark ?? ''
        ..unitPrice = unitPrice);
    } else {
      // 购物车中的商品
      ProductInfo _currentProduct = _currentCart[index];
      _currentCart[index].sellNum = sellNum ?? _currentProduct.sellNum! + 1;
      if (unitPrice != null) {
        _currentCart[index].unitPrice = unitPrice;
      }
    }

    switch (type) {
      case CartType.Home:
        cart = _currentCart;
        break;
      case CartType.Refund:
        refundCart = _currentCart;
        break;
    }

    notifyListeners();
  }

  // 从购物车减少商品
  void reduceProduct({
    CartType type = CartType.Home,
    required ProductInfo product,
  }) {
    // 获取当前购物车
    List<ProductInfo> _currentCart = [];

    switch (type) {
      case CartType.Home:
        _currentCart = cart;
        break;
      case CartType.Refund:
        _currentCart = refundCart;
        break;
    }

    // 找到购物车里的index
    int index =
        _currentCart.indexWhere((_cartItem) => _cartItem.id == product.id);

    if (index == -1) {
      // 购物车中没有该商品则报错
      showToast('没有找到该商品');
    } else {
      // 购物车中的商品
      ProductInfo _currentProduct = _currentCart[index];

      if (_currentProduct.sellNum! <= 1) {
        // 如果少于等于1个则删除
        _currentCart.removeAt(index);
      } else {
        // 如果大于1 则减1
        _currentCart[index].sellNum = _currentProduct.sellNum! - 1;
      }
    }

    switch (type) {
      case CartType.Home:
        cart = _currentCart;
        break;
      case CartType.Refund:
        refundCart = _currentCart;
        break;
    }

    notifyListeners();
  }

  // 清空购物车
  void emptyCart({CartType type = CartType.Home}) {
    // 清空商品
    if (type == CartType.Home) {
      cart = [];
    } else if (type == CartType.Refund) {
      refundCart = [];
    }

    // 清空会员
    selectedMember = null;

    notifyListeners();
  }

  // 加入挂单 把当前购物车的东西加入到挂单中，并清空购物车
  addDelay() {
    try {
      if (cart.isEmpty) {
        throw Exception('请选择要挂单的商品');
      }
      String _time = '${DateTime.now().microsecondsSinceEpoch}';
      print('_time: ${_time}');

      // 创建挂单
      CartDelay cartDelay =
          CartDelay(list: cart, time: _time, member: selectedMember);

      cart = [];
      selectedMember = null;

      delayList.add(cartDelay);
      notifyListeners();
    } catch (e) {
      showToast(e.toString());
    }
  }

  // 选择挂单到购物车传入挂单的时间戳
  choiceDelay(int index) {
    if (index != -1) {
      // 说明找到了 把参数设置到购物车中
      cart = delayList[index].list;
      selectedMember = delayList[index].member;

      // 删掉该挂单
      delayList.removeAt(index);
    }

    notifyListeners();
  }

  // 传入要清空的挂单，不穿则全部清空
  removeDelay({int? index}) {
    if (index == null) {
      delayList = [];
    } else {
      delayList.removeAt(index);
    }
    notifyListeners();
  }
}
