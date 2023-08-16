import 'dart:convert';

import 'package:http/http.dart' as http;

class MealApi {
  var url = 'https://itmajor.cafe24.com/kiosk_api/rate.php';
  //평가 저장
  Future<String> insert(String eval_date, double rating, String comment) async {
    var header = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'mode': 'insert',
      'eval_date': eval_date,
      'rating': rating,
      'comment': comment,
    });
    var response = await http.post(
      Uri.parse(url),
      headers: header,
      body: body,
    );
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body) as Map<String, dynamic>;
      return result['result'];
    } else {
      return 'false';
    }
  }
}
