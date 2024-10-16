import 'package:clean_arc2/feature/weather/domain/entites/weather.dart';

class WeatherModel  extends Weather{
 const WeatherModel({
  required super.country,
   required super.region,
    required super.temp_c,
     required super.wind_kph,
      required super.uv,
       required super.humidity});
  
 factory WeatherModel.fromJson(Map<String,dynamic> json){

  return WeatherModel(
    country: json["location"]["country"],
     region: json["location"]["region"],
      temp_c: json["current"]["temp_c"],
       wind_kph: json["current"]["wind_kph"],
        uv: json["current"]["uv"],
         humidity: json["current"]["humidity"]
         );

 }

  factory WeatherModel.fromJsonn(Map<String,dynamic> json){

  return WeatherModel(
    country: json["country"],
     region: json["region"],
      temp_c: json["temp_c"],
       wind_kph: json["wind_kph"],
        uv: json["uv"],
         humidity: json["humidity"]
         );

 }


   Map<String,dynamic> toJson() {

    return {

    'country':country ,
     'region': region,
      'temp_c':temp_c ,
       'wind_kph':wind_kph ,
        'uv': uv,
         'humidity':humidity 

    };


  }


}