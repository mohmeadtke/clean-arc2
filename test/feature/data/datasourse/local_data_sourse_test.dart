import 'dart:convert';

import 'package:clean_arc2/feature/weather/data/datasources/weather_local_data_sources.dart';
import 'package:clean_arc2/feature/weather/data/model/Weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/fixture/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}


void main(){

late MockSharedPreferences mockSharedPreferences ;
late WeatherLocalDataSourcesImpl weatherLocalDataSourcesImpl ;

setUp((){

  mockSharedPreferences = MockSharedPreferences();
  weatherLocalDataSourcesImpl =WeatherLocalDataSourcesImpl(sharedPreferences: mockSharedPreferences);

});
  
  final weatherModel = WeatherModel.fromJson(json.decode(fixture("test.json")));

  test('shuold retreav the data from the local data sourse', () async{
    
    when(mockSharedPreferences.getString("key")).thenReturn(fixture("test.json"));

    final resualt =await weatherLocalDataSourcesImpl.getWeather();

    verify(mockSharedPreferences.getString("key"));

    expect(resualt, equals(weatherModel));

  });

}