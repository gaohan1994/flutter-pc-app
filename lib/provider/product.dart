import 'package:flutter/material.dart';
import 'package:pc_app/model/member.dart';
import 'package:pc_app/model/product.dart';
import 'package:pc_app/service/member_method.dart';
import 'package:pc_app/service/product_method.dart';
import 'dart:convert';

import 'package:pc_app/service/service_url.dart';

class ProductProvider extends ChangeNotifier {
  // 页数
  int page = 1;
  // 页码
  int pageSize = 20;
  // 商品列表
  List<ProductInfo> productList = [];
  // 搜索的值
  String searchValue = '';
  // 商品详情
  ProductInfo? productDetail;
  // 供应商列表
  List<ProductSupplier> productSupplierList = [];
  // 筛选选中的分类
  List<ProductType> selectedFilterType = [];

  // 排序方式
  String filterWay = 'amount';
  void setFilterWay(way) {
    filterWay = way;
    getProducts();
    notifyListeners();
  }

  // 排序规则
  String filterBy = 'desc';
  void setFilterBy(by) {
    filterBy = by;
    getProducts();
    notifyListeners();
  }

  void resetSelectedFilterType() {
    selectedFilterType = [];
    notifyListeners();
  }

  void changeSelectedFilterType(ProductType type) {
    selectedFilterType = [type];
    notifyListeners();
  }

  // 请求列表，过程很繁琐 用心感受
  Future<void> getProducts() async {
    dynamic params = {
      "pageNum": 1,
      "pageSize": '$pageSize',
      // "orderByColumn": "$filterWay $filterBy",
    };

    if (searchValue.isNotEmpty) {
      params['words'] = searchValue;
    }

    var result = await productInfoList(params: params);
    var resultMap = json.decode(result.toString());

    var productRows = ProductList.fromJson(resultMap['data']).rows;
    productList = productRows;

    if (productRows.isNotEmpty) {
      getProductDetail(productRows[0].id!);
    }

    page = 1;
    notifyListeners();
  }

  // 加载更多商品
  Future loadMoreProducts() async {
    dynamic params = {
      "pageNum": page + 1,
      "pageSize": '$pageSize',
      // "orderByColumn": "$filterWay $filterBy",
    };

    if (searchValue.isNotEmpty) {
      params['words'] = searchValue;
    }

    var result = await productInfoList(params: params);
    var resultMap = json.decode(result.toString());

    var newList = ProductList.fromJson(resultMap['data']).rows;
    productList.addAll(newList);
    page++;
    notifyListeners();
  }

  // 获取商品详情
  Future getProductDetail(int id) async {
    var result = await fetchProductDetail(id: id);
    var resultMap = json.decode(result.toString());
    var detail = ProductInfo.fromJson(resultMap['data']);
    productDetail = detail;
    notifyListeners();
  }

  Future getProductSupplier() async {
    var result = await fetchSupplier();
    var resultMap = json.decode(result.toString());

    if (resultMap['code'] == successCode) {
      List<ProductSupplier> data = ProductSupplierList.fromJson(resultMap).data;
      productSupplierList = data;
      notifyListeners();
    }
  }
}
