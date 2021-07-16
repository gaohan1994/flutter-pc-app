// 交接班
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pc_app/pages/more/summary_detail.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  createState() => SummaryPageState();
}

class SummaryPageState extends State<SummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('交接班'),
      ),
      body: Row(
        children: [
          Container(
            width: 330.w,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black12))),
                  child: ListTile(
                    title: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 16.w),
                          child: Image(
                            image: AssetImage('assets/icon_more_shift.png'),
                            width: 17.w,
                            height: 17.w,
                          ),
                        ),
                        Text(
                          '交接班',
                          style: TextStyle(color: Colors.black45),
                        )
                      ],
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black12))),
                  child: ListTile(
                    title: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 16.w),
                          child: Image(
                            image:
                                AssetImage('assets/icon_more_shift_record.png'),
                            width: 17.w,
                            height: 17.w,
                          ),
                        ),
                        Text(
                          '交接班记录',
                          style: TextStyle(color: Colors.black45),
                        )
                      ],
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                    ),
                  ),
                )
              ],
            ),
          ),
          VerticalDivider(),
          SummaryDetail()
        ],
      ),
    );
  }
}
