import 'package:pc_app/service/service_url.dart';

Future fetchOrderList({dynamic params}) async {
  return requestData('${serviceUrl}/api/order/list',
      data: params, method: 'get');
}

Future fetchOrderDetail({params}) async {
  return requestData('${serviceUrl}/api/order/detail', data: params);
}
