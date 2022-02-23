import 'package:city_weather/home_screen.dart';
import 'package:city_weather/weather/view_models/weather_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WeatherViewModel(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            //case '/clima':
            //return MaterialPageRoute(builder: (context) => const Clima());
            case '/':
              return MaterialPageRoute(builder: (context) => const Home());
          }
        },
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.white70),
          textTheme: const TextTheme(
            bodyText2: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
            bodyText1: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const Home(),
      ),
    );
  }
}
