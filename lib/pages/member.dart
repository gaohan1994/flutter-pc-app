import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pc_app/component/color_item.dart';
import 'package:pc_app/component/empty_view.dart';
import 'package:pc_app/component/list_item.dart';
import 'package:pc_app/component/search.dart';
import 'package:pc_app/pages/component.dart';
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
      // 获取会员等级列表
      context.read<MemberProvider>().getMemberLevel();
    });
  }

  void onFilterClick(value) {
    var filterWay = context.read<MemberProvider>().filterWay;
    var filterBy = context.read<MemberProvider>().filterBy;
    // print('value: ${value}');
    // print('filterWay: ${filterWay}');
    // print('value == filterWay: ${value == filterWay}');
    if (value == filterWay) {
      // 如果已经是当前选中的分类则翻转排序方式
      context
          .read<MemberProvider>()
          .setFilterBy(filterBy == 'desc' ? 'asc' : 'desc');
    } else {
      // 如果不是选中状态则选中
      context.read<MemberProvider>().setFilterWay(value);
      context.read<MemberProvider>().setFilterBy('desc');
    }
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
                            context.read<MemberProvider>().searchValue = '';
                            context.read<MemberProvider>().getMemberList();
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.w),
                        child: _buildFilter(),
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
      return EasyRefresh(
          onLoad: () async {
            await context.read<MemberProvider>().loadMemberList();
          },
          footer: ClassicalFooter(
              bgColor: Colors.white,
              textColor: Colors.black38,
              noMoreText: '加载完成',
              loadReadyText: '上拉加载',
              loadText: '上拉加载更多',
              loadingText: '加载中...',
              loadedText: '加载成功',
              showInfo: false),
          child: ListView.builder(
              itemCount: memberList.length,
              itemBuilder: (BuildContext context, index) {
                return MemberItem(item: memberList[index]);
              }));
    } else {
      return EmptyView(emptyText: '暂无数据');
    }
  }

  Widget _buildFilter() {
    var filterWay = context.watch<MemberProvider>().filterWay;
    var filterBy = context.watch<MemberProvider>().filterBy;
    return Row(
      children: [
        FilterItem(
            title: '累计消费',
            value: 'totalAmount',
            onPressed: (value) {
              onFilterClick(value);
            },
            direction:
                filterBy == 'desc' ? FilterDirection.down : FilterDirection.up,
            selected: filterWay == 'totalAmount'),
        FilterItem(
            title: '上次消费时间',
            value: 'lastPayTime',
            onPressed: (value) {
              onFilterClick(value);
            },
            direction:
                filterBy == 'desc' ? FilterDirection.down : FilterDirection.up,
            selected: filterWay == 'lastPayTime'),
        FilterItem(
            title: '注册时间',
            value: 'createTime',
            onPressed: (value) {
              onFilterClick(value);
            },
            direction:
                filterBy == 'desc' ? FilterDirection.down : FilterDirection.up,
            selected: filterWay == 'createTime'),
      ],
    );
  }
}
