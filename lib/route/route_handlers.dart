import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:pc_app/pages/more/product.dart';
import '../pages/order.dart';
import '../pages/sign/login.dart';
import '../pages/index.dart';

// 主页面Handler
Handler rootHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return IndexPage();
});

// 订单主页面Handler
Handler orderHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
  return OrderPage();
});

Handler loginHandler = Handler(handlerFunc:
    ((BuildContext? context, Map<String, List<String>> parameters) {
  return LoginPage();
}));

Handler handlerProduct = Handler(handlerFunc:
    ((BuildContext? context, Map<String, List<String>> parameters) {
  return ProductPage();
}));
