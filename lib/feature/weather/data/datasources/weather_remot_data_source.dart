import 'package:clean_arc2/feature/weather/data/model/Weather_model.dart';

abstract class WeatherRemotDataSource {

  Future<WeatherModel> getWeatherRepo();

  Future<WeatherModel> updateWetherRepo(String country,String region);
}