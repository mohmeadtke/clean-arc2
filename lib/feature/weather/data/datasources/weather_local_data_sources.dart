import 'package:clean_arc2/feature/weather/data/model/Weather_model.dart';

abstract class WeatherLocalDataSources {

Future<WeatherModel> getWeather();

Future<void> cashTheWeather(WeatherModel weathermodle);

}