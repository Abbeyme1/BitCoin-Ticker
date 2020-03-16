import 'dart:convert';
import 'package:http/http.dart';

const URL = 'https://blockchain.info/ticker';

Future<dynamic> getPickerData() async {
  try {
    Response response = await get(URL);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  } catch (e) {
    print(e);
  }
}
