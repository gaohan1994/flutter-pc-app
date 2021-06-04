import 'package:flutter/material.dart';
import 'package:pc_app/model/user.dart';
import 'package:pc_app/provider/global.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Global {
  static Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  static UserModel? user;

  static Future init(BuildContext ctx) async {
    SharedPreferences _prefs = await prefs;
    var _user = _prefs.getString('user');

    if (_user != null) {
      user = UserModel.fromJson(jsonDecode(_user));
      ctx.read<ProfileChangeNotifier>().user = user;
    }

    return user;
  }

  // 持久化Profile信息
  static saveProfile() async {
    if (user != null) {
      SharedPreferences _prefs = await prefs;
      _prefs.setString("user", json.encode(user!.toJson()));
    }
  }
}
