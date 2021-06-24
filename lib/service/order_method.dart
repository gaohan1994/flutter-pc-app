import 'package:pc_app/service/service_url.dart';

Future fetchOrderList({dynamic params}) async {
  return requestData('${serviceUrl}/api/order/list',
      data: params, method: 'get');
}

Future fetchOrderDetail({params}) async {
  return requestData('${serviceUrl}/api/order/detail', data: params);
}

Future cashierOrder({params}) async {
  return requestData('${serviceUrl}/api/cashier/order', data: params);
}

Future cashierConfirm({params}) async {
  return requestData('${serviceUrl}/api/cashier/confirm', data: params);
}

Future fetchCashierRefund({params}) async {
  return requestData('${serviceUrl}/api/cashier/refund',
      data: params, method: 'post');
}
