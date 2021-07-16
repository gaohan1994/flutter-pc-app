import 'package:flutter/material.dart';

class SummaryDetail extends StatefulWidget {
  const SummaryDetail({Key? key}) : super(key: key);

  @override
  createState() => SummaryDetailState();
}

class SummaryDetailState extends State<SummaryDetail> {
  @override
  Widget build(BuildContext context) {
    // 交接班详情页面
    // 本页面要适配撑满屏幕
    return Expanded(
        child: Column(
      children: [
        Row(
          children: [
            Text('班次：2020-01-12   09:23 —— 2020-01-14  12:00'),
            Text('收银员：着先生')
          ],
        ),
        Divider(),
        Row(
          children: [],
        )
      ],
    ));
  }
}
