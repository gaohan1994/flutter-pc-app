import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pc_app/component/product_tag.dart';
import 'package:pc_app/model/member.dart';
import 'package:pc_app/pages/member/member_content.dart';
import 'package:pc_app/pages/member/member_tab.dart';
import 'package:pc_app/provider/member.dart';
import 'package:pc_app/provider/route.dart';
import 'package:provider/provider.dart';

// 会员详情
class MemberDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var memberDetailIndex = context.watch<RouteProvider>().memberDetailIndex;
    var memberDetail = context.watch<MemberProvider>().memberDetail;

    return Expanded(
        child: Container(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        children: [
          _buildCard(memberDetail),
          Expanded(
              child: Column(
            children: [
              MemberTabbar(),
              Container(
                padding: EdgeInsets.all(13),
                child: _buildContent(memberDetailIndex, memberDetail),
              )
            ],
          )),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: _buildButtons(),
          ),
        ],
      ),
    ));
  }

  Widget _buildCard(memberDetail) {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      height: 160.w,
      padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/-e3-bitmap.png'),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 13),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black12))),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Image(
                      width: 54.w,
                      height: 54.w,
                      image: AssetImage('assets/huiyuan_user.png')),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(memberDetail.username),
                        ProductTag(
                            name: memberDetail.levelName,
                            color: Colors.orange.shade200)
                      ],
                    ),
                    Text(memberDetail.phone)
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Row(
              children: [
                _buildCardItem('积分', '${memberDetail.accumulativePoints}'),
                _buildCardItem('储值余额', '${memberDetail.accumulativeMoney}'),
                _buildCardItem('消费笔数', '${memberDetail.totalTimes}'),
                _buildCardItem('累计消费', '${memberDetail.totalAmount}'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCardItem(title, value) {
    return Expanded(
        flex: 1,
        child: Container(
          decoration: BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1, color: Colors.black12))),
          child: Column(
            children: [Text(title), Text(value)],
          ),
        ));
  }

  Widget _buildButtons() {
    final buttonStyle = OutlinedButton.styleFrom(
        side: const BorderSide(width: 1, color: Colors.blue));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: ScreenUtil().setHeight(30),
          width: ScreenUtil().setWidth(90),
          margin: const EdgeInsets.only(right: 6),
          child: OutlinedButton(
            style: buttonStyle,
            onPressed: () => {},
            child: const Text('编辑'),
          ),
        ),
        Container(
          height: ScreenUtil().setHeight(30),
          width: ScreenUtil().setWidth(90),
          margin: const EdgeInsets.only(right: 6),
          child: ElevatedButton(
            style: buttonStyle,
            onPressed: () => {},
            child: const Text('会员充值'),
          ),
        )
      ],
    );
  }

  Widget _buildContent(int index, MemberDetail memberDetail) {
    return Column(
      children: [
        MemberContent(
          child: Column(
            children: [
              MemberContent.buildSection(items: [
                ContentItem(title: '卡号', value: '${memberDetail.cardNo}'),
                ContentItem(title: '人脸识别', value: '已识别')
              ]),
              MemberContent.buildSection(items: [
                ContentItem(
                    title: '性别',
                    value: '${memberDetail.sex == '0' ? '先生' : '女士'}'),
                ContentItem(
                    title: '开卡卡店', value: '${memberDetail.merchantName}')
              ]),
              MemberContent.buildSection(items: [
                ContentItem(title: '生日', value: '${memberDetail.birthDate}'),
                ContentItem(title: '开卡时间', value: '${memberDetail.createTime}')
              ]),
              MemberContent.buildSection(items: [
                ContentItem(
                    title: '状态',
                    value: '${memberDetail.status == 1 ? '正常' : '注销'}')
              ]),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: MemberContent(
            child: Column(
              children: [
                ContentItem(
                    title: '上次消费时间', value: '${memberDetail.lastPayTime}'),
                ContentItem(
                  title: '消费爱好',
                  child: Row(
                    children: memberDetail.preferenceVo!.map((item) {
                      return ProductTag(
                          name: item.typeName, color: Colors.blue);
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
