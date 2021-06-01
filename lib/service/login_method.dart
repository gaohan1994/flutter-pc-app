import 'package:pc_app/service/service_url.dart';

Future oauthToken({params}) async {
  return requestData('${serviceUrl}/oauth/token', data: params);
}
