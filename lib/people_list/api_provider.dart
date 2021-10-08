import 'package:http/http.dart' as http;
import 'package:map_example/people_list/http_exception.dart';

class ApiProvider {
  static const String _BASE_URL = 'https://api.json-generator.com/';
  static const String _API_KEY =
      'v3srs6i1veetv3b2dolta9shrmttl72vnfzm220z'; // avoid API keys in the code
  static const String _END_POINT_GET_PEOPLE_LIST =
      'templates/Xp8zvwDP14dJ/data';

  Future<String> getPeopleList() async {
    final headers = {'Authorization': 'Bearer $_API_KEY'};
    final url = _BASE_URL + _END_POINT_GET_PEOPLE_LIST;
    return http.get(url, headers: headers).then((resp) {
      if (resp.statusCode == 200) {
        return resp.body;
      } else {
        throw HttpException(
            resp.statusCode, 'Unable to fetch the data.\n\n${resp.body}');
      }
    });
  }
}
