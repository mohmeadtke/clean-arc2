import 'dart:convert';
import 'package:clean_arc2/core/errors/exspshen.dart';
import 'package:clean_arc2/feature/weather/data/model/Weather_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class WeatherLocalDataSources {

Future<WeatherModel> getWeather();

Future<void> cashTheWeather(WeatherModel weathermodle);

}

const String key = "key" ;
class WeatherLocalDataSourcesImpl implements WeatherLocalDataSources{
  

final SharedPreferences sharedPreferences ;

  WeatherLocalDataSourcesImpl({required this.sharedPreferences});

  @override
  Future<void> cashTheWeather(WeatherModel weathermodle) async{

    final jsonWeatherDataThatWillBeSave= json.encode(weathermodle.toJson());

    sharedPreferences.setString(key, jsonWeatherDataThatWillBeSave) ;

  
  }

  @override
  Future<WeatherModel> getWeather() async{
      
      final dataFromTheCash = sharedPreferences.getString(key); 
      if (dataFromTheCash != null) {
         
        final weathermodle = WeatherModel.fromJsonn(jsonDecode(dataFromTheCash));
        return weathermodle ;    
          
      } else {
        print("nononononono");
        throw OfflineException();
      }
    
  }
  
}