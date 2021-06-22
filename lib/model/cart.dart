// import 'package:json_annotation/json_annotation.dart';
import 'package:pc_app/model/member.dart';
import 'package:pc_app/model/product.dart';
// part 'cart.g.dart';

// @JsonSerializable()
class CartDelay {
  // 挂单
  CartDelay({required this.time, required this.list, this.member});

  // 时间戳
  String time;

  List<ProductInfo> list;

  MemberDetail? member;
}
