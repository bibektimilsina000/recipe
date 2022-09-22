import 'package:http/http.dart' as http;
import 'dart:convert';
import 'meal.dart';

class Services {
  static const String url =
      'https://run.mocky.io/v3/ec015ddb-4e42-4c27-9760-541169420d21';

  static Future<List<Meal>> getData() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<Meal> meal = parseMeal(response.body);
        return meal;
      } else {
        throw Exception('error');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<Meal> parseMeal(String reponseBody) {
    final parsed = json.decode(reponseBody).cast<Map<String, dynamic>>();
    return parsed.map<Meal>((json) => Meal.fromJson(json));
  }
}
