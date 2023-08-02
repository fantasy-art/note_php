import 'package:http/http.dart' as http;
import 'dart:convert';

class Crud {
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        // ignore: avoid_print
        print('Error ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error Catch');
    }
  }

  postRequest(String url, Map data) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        // ignore: avoid_print
        print('Error ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error Catch $e');
    }
  }
}
