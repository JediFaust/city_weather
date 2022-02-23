import 'package:city_weather/weather/models/city_model.dart';
import 'package:city_weather/weather/models/coordinates_model.dart';
import 'package:city_weather/weather/models/weather_error.dart';
import 'package:city_weather/weather/repo/api_status.dart';
import 'package:city_weather/weather/repo/city_coordinates_service.dart';
import 'package:city_weather/weather/repo/current_location_service.dart';
import 'package:city_weather/weather/repo/weather_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class WeatherViewModel extends ChangeNotifier {
  bool _loading = false;
  City? _cityWeather;
  Object? _cityCoordinates;
  WeatherError? _weatherError;

  bool get loading => _loading;
  City get cityWeather => _cityWeather as City;
  Object get cityCoordinates => _cityCoordinates ?? '';
  WeatherError? get weatherError => _weatherError;

  WeatherViewModel() {
    getWeather();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setCityWeather(Object cityWeather) {
    _cityWeather = cityWeather as City;
  }

  setCityCoordinates(Object cityCoordinates) {
    _cityCoordinates = cityCoordinates;
  }

  setWeatherError(WeatherError weatherError) {
    _weatherError = weatherError;
  }

  getWeather({city}) async {
    Coordinates coord;
    setLoading(true);
    if (city == null) {
      Position position = await CurrentLocationService.getGeolocation();
      coord = Coordinates(
          name: '',
          lat: position.latitude,
          lon: position.longitude,
          country: '');
    } else {
      coord = await CityCoordinatesService.getCoordinates(city) as Coordinates;
    }
    var response = await WeatherService.getWeather(coord.lat, coord.lon);

    if (response is Success) {
      setCityWeather(response.response as City);
    }
    if (response is Failure) {
      //setCityWeather('error');
      WeatherError weatherError = WeatherError(
          code: response.code, message: response.errorResponse as String);
      setWeatherError(weatherError);
    }
    setLoading(false);
  }
}
