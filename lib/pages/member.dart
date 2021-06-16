import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pc_app/component/color_item.dart';
import 'package:pc_app/component/empty_view.dart';
import 'package:pc_app/component/list_item.dart';
import 'package:pc_app/component/search.dart';
import 'package:pc_app/pages/member/member_edit.dart';
import 'package:pc_app/pages/member_detail.dart';
import 'package:pc_app/provider/member.dart';
import 'package:provider/provider.dart';

class MemberPage extends StatefulWidget {
  @override
  createState() => _MemberPage();
}

class _MemberPage extends State<MemberPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      // 初始化列表
      context.read<MemberProvider>().getMemberList();
      // 获取会员统计数据
      context.read<MemberProvider>().getMemberStatic();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 330.w,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
                  child: Column(
                    children: [
                      _buildMemberCount(),
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: SearchCompoennt(
                          hintText: '请输入会员卡或手机号',
                          inputCallback: (value) {
                            context.read<MemberProvider>().searchValue = value;
                            context.read<MemberProvider>().getMemberList();
                          },
                          onCancel: (value) {
                            // scrollController.jumpTo(0);
                            context.read<MemberProvider>().searchValue = '';
                            context.read<MemberProvider>().getMemberList();
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(child: _buildList()),
                Container(
                  height: 40.w,
                  width: 330.w,
                  child: ElevatedButton(
                    onPressed: () => {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return MemberEdit(isEdit: false);
                          })
                    },
                    child: Text('新增会员'),
                  ),
                )
              ],
            ),
          ),
          const VerticalDivider(),
          MemberDetailPage(),
        ],
      ),
    );
  }

  Widget _buildMemberCount() {
    var memberStatic = context.watch<MemberProvider>().memberStatic;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ColorItem(
            title: '新增会员数',
            detail: '${memberStatic.addMemberNum}',
            color: Colors.orange),
        ColorItem(
            title: '总会员数',
            detail: '${memberStatic.totalMemberNum}',
            color: Colors.red),
      ],
    );
  }

  Widget _buildList() {
    var memberList = context.watch<MemberProvider>().memberList;

    if (memberList.isNotEmpty) {
      return ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, index) {
            return MemberItem(item: memberList[index]);
          });
    } else {
      return EmptyView(emptyText: '暂无数据');
    }
  }
}
