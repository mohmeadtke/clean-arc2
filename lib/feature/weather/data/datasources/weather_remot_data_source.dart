import 'package:clean_arc2/feature/weather/data/model/Weather_model.dart';

abstract class WeatherRemotDataSource {

  Future<WeatherModel> getWeatherRemoatData();

  Future<WeatherModel> updateWetherRemoatData(String country,String region);
}