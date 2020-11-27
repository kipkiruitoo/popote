import 'package:http/http.dart' as http;

class PopoteService {
  final String _url = 'https://hudumapopote.sharedwithexpose.com/api';

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;

    // print(fullUrl);
    // await _getToken();
    return await http.get(fullUrl, headers: _setHeaders());
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json'
        // 'Authorization': 'Bearer $token'
      };
}
