import 'package:pc_app/service/service_url.dart';

Future fetchMemberInfoStatic() async {
  return requestData('${serviceUrl}/api/memberInfo/statistic', method: 'get');
}

Future fetchMemberList({dynamic params}) async {
  return requestData('${serviceUrl}/api/memberInfo/list',
      data: params, method: 'get');
}

Future fetchMemberDetail({required int id}) async {
  return requestData('${serviceUrl}/api/memberInfo/detail/${id}',
      method: 'get');
}

Future memberInfoEdit({dynamic params}) async {
  return requestData('${serviceUrl}/api/memberInfo/edit',
      method: 'post', data: params);
}

Future fetchMemberInfoAdd({dynamic params}) async {
  return requestData('${serviceUrl}/api/memberInfo/add',
      method: 'post', data: params);
}

Future getRandomCaroNo() async {
  return requestData('${serviceUrl}/api/memberInfo/getRandomCaroNo',
      method: 'get');
}

Future memberDetailByPreciseInfo({dynamic identity}) async {
  return requestData(
      '${serviceUrl}/api/memberInfo/detailByPreciseInfo/$identity',
      method: 'get');
}

Future fetchMemberLevel() async {
  return requestData('${serviceUrl}/api/memberLevel/list', method: 'get');
}
