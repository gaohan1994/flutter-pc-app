import 'package:pc_app/service/service_url.dart';

Future fetchReportToday({dynamic params}) async {
  return requestData('${serviceUrl}/api/report/getTodayData',
      data: params, method: 'get');
}
