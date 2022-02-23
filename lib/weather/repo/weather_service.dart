import 'dart:io';
import 'package:city_weather/utils/constants.dart';
import 'package:city_weather/weather/models/city_model.dart';
import 'package:city_weather/weather/repo/api_status.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static Future<Object> getWeather(latitude, longitude) async {
    try {
      var url = Uri.parse(
          'http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$API_KEY');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return Success(response: cityFromJson(response.body));
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: 'Invalid Response');
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: 'No Internet');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown Error');
    }
  }
}
