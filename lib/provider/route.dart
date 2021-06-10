/* index页面 存储当前index
 * @Author: centerm.gaohan 
 * @Date: 2021-05-26 14:44:55 
 * @Last Modified by: centerm.gaohan
 * @Last Modified time: 2021-05-26 15:19:44
 */

import 'package:flutter/material.dart';

class RouteProvider extends ChangeNotifier {
  int _index = 2;

  int get index => _index;

  // 会员tab页的index
  int memberDetailIndex = 0;

  void changeIndex(value) {
    _index = value;
    notifyListeners();
  }

  void changeMemberDetailIndex(int value) {
    memberDetailIndex = value;
    notifyListeners();
  }
}
