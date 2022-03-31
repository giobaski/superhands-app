import 'package:http/http.dart' as http;

class ApiService {
  static var client = http.Client();

  static Future<String> getMyIP() async {
    var response = await client.get(Uri.parse("http://whatismyip.akamai.com/"),
        headers: <String, String>{
          "Content-type": "text/html",
        });

    // print("##### Response body: " + response.body);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Fail");
    }
  }
}
