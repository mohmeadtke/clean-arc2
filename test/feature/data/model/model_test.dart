

import 'dart:convert';

import 'package:clean_arc2/feature/weather/data/model/Weather_model.dart';
import 'package:clean_arc2/feature/weather/domain/entites/weather.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../core/fixture_reader.dart';

void main() {


const weatherModle = WeatherModel(
  country: "Iraq",
   region: "Baghdad",
    temp_c: 34.5,
     wind_kph: 9.4,
      uv: 4.0,
       humidity:  9);


test('the model shuold be the same as entites',
 () {
  
  expect(weatherModle,isA<Weather>() );

});


group("json stuff", (){

  test('from json ', () {
    //    
    final Map<String,dynamic> jsonMap= jsonDecode(fixture("body.json"));
    //
    final result = WeatherModel.fromJson(jsonMap);
    //
    expect(result, weatherModle);
  });

  test('to json', () {
    
    //
    Map<String,dynamic> theMap = {
  "country": "Iraq",
   "region": "Baghdad",
    "temp_c": 34.5,
     "wind_kph": 9.4,
      "uv": 4.0,
       "humidity":  9
    };
    //
    final resualt = weatherModle.toJson();
    //
    expect(resualt, theMap) ;
  });

});


}


