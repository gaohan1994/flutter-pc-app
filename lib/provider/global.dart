import 'package:flutter/material.dart';
import 'package:pc_app/common/global.dart';
import 'package:pc_app/model/user.dart';

class ProfileChangeNotifier extends ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  @override
  void notifyListeners() {
    //保存Profile变更
    Global.saveProfile();
    //通知依赖的Widget更新
    super.notifyListeners();
  }

  set user(UserModel? value) {
    Global.user = value;
    _user = value;
    notifyListeners();
  }
}
