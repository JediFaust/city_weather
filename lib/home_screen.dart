import 'package:city_weather/weather/repo/icon_service.dart';
import 'package:city_weather/weather/view_models/weather_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:city_weather/components/gradient_back.dart';
import 'package:city_weather/utils/capitalize_extension.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WeatherViewModel weatherViewModel = context.watch<WeatherViewModel>();

    return Container(
      decoration: gradientDecoration,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 0,
          //title: Text(),
          //centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: _ui(weatherViewModel),
      ),
    );
  }

  _ui(WeatherViewModel weatherViewModel) {
    if (weatherViewModel.loading) {
      return const Center(
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 150,
        ),
      );
    }
    if (weatherViewModel.weatherError != null) {
      return const Center(
        child: Text('Something went wrong!'),
      );
    }
    var weather = weatherViewModel.cityWeather;

    String cityTitle = '${weather.name}, ${weather.sys!.country}';
    String temperature = ((weather.main!.temp! - 273.15).toInt()).toString();
    String description = weather.weather![0].description!.capitalize();

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd MMMM y').format(now);
    String formattedDayNTime = DateFormat('EEEE | kk:mm').format(now);

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 100,
                  height: 100,
                  child: IconService.getIcon(weather.weather![0].icon ?? '')),
              Text(cityTitle)
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(temperature, style: const TextStyle(fontSize: 150)),
                  const Text('o', style: TextStyle(fontSize: 50)),
                ],
              ),
              Text(description),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formattedDate,
                style: const TextStyle(fontSize: 24),
              ),
              Text(
                formattedDayNTime,
                style: const TextStyle(fontSize: 24),
              ),
            ],
          )
        ],
      ),
    );
  }
}
