import 'dart:io';
import 'package:city_weather/utils/constants.dart';
import 'package:city_weather/weather/models/coordinates_model.dart';
import 'package:city_weather/weather/repo/api_status.dart';
import 'package:http/http.dart' as http;

class CityCoordinatesService {
  static Future<Object> getCoordinates(city) async {
    try {
      var url = Uri.parse(
          'http://api.openweathermap.org/geo/1.0/direct?q=$city&limit=1&appid=$API_KEY');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return Success(response: coordinatesFromJson(response.body));
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
