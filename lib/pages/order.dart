import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // 主页面 stateful 在这里接入state
    return _OrderPageState();
  }
}

class _OrderPageState extends State<OrderPage> {
  Widget build(BuildContext context) {
    return Container(
      child: Text('Order'),
    );
  }
}
