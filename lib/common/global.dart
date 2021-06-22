import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pc_app/component/form/form_input.dart';
import 'package:pc_app/model/user.dart';
import 'package:pc_app/provider/cart.dart';
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

  static String formatNum(double num, int postion) {
    if ((num.toString().length - num.toString().lastIndexOf(".") - 1) <
        postion) {
      //小数点后有几位小数
      return num.toStringAsFixed(postion)
          .substring(0, num.toString().lastIndexOf(".") + postion + 1)
          .toString();
    } else {
      return num.toString()
          .substring(0, num.toString().lastIndexOf(".") + postion + 1)
          .toString();
    }
  }

  static Future selectMemberDialog(BuildContext context) async {
    final TextEditingController phone = TextEditingController();

    var option = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              contentPadding: EdgeInsets.all(0),
              titlePadding: EdgeInsets.all(0),
              title: Container(
                padding: EdgeInsets.all(12),
                color: Colors.blue,
                child: const Text(
                  '会员',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              children: [
                Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      GhFormInput(
                        title: '手机号',
                        inputCallBack: (value) => phone.text = value,
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
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: Text('取消')),
                            ),
                            Container(
                              width: ScreenUtil().setWidth(100),
                              height: ScreenUtil().setWidth(30),
                              child: ElevatedButton(
                                  onPressed: () => {
                                        if (phone.text.isEmpty)
                                          {showToast('请输入手机号')}
                                        else
                                          {Navigator.pop(context, 'Submit')}
                                      },
                                  child: Text('确定')),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ]);
        });

    if (option == 'Submit') {
      context.read<CartProvider>().setMember(phone.text);
      // callback!(phone.text);
    }
  }
}
