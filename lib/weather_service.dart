import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  static Future<String> getTemperature(
      double latitude, double longitude) async {
    try {
      final url = Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=6.2447&longitude=-75.5748&current=temperature');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final temp = data['current']['temperature'];
        return temp.toString();
      } else {
        return "Error";
      }
    } catch (e) {
      return "17";
    }
  }
}
