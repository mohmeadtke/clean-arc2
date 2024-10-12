import 'dart:convert';
import 'package:clean_arc2/core/errors/exspshen.dart';
import 'package:clean_arc2/feature/weather/data/datasources/weather_local_data_sources.dart';
import 'package:clean_arc2/feature/weather/data/model/Weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/fixture/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {

}


void main(){

late MockSharedPreferences mockSharedPreferences ;
late WeatherLocalDataSourcesImpl weatherLocalDataSourcesImpl ;

setUp((){

  mockSharedPreferences = MockSharedPreferences();
  weatherLocalDataSourcesImpl =WeatherLocalDataSourcesImpl(sharedPreferences: mockSharedPreferences);

});
  
 group('check weather locl data sourse ', () {

   final weatherModel = WeatherModel.fromJson(json.decode(fixture("test.json")));

  test('shuold retreav the data from the local data sourse', () async{
    
    when(mockSharedPreferences.getString(key)).thenReturn(fixture("test.json"));

    final resualt =await weatherLocalDataSourcesImpl.getWeather();

    verify(mockSharedPreferences.getString(key));

    expect(resualt, equals(weatherModel));

  });


   test('shuold retreav a expachean from the local data sourse if ther is no data', () {
    
    when(mockSharedPreferences.getString(key)).thenReturn(null);

    final resualt = weatherLocalDataSourcesImpl.getWeather;

    expect(resualt, throwsA(const TypeMatcher<OfflineException>()));

  });
  const weatherModle = WeatherModel(
  country: "Iraq",
   region: "Baghdad",
    temp_c: 34.5,
     wind_kph: 9.4,
      uv: 4.0,
       humidity:  9);

 test('should cache the data in shared preferences without mocks', () async {
    // Arrange
    // Initialize mock values for SharedPreferences
    SharedPreferences.setMockInitialValues({});

    // Create an actual instance of SharedPreferences
    final sharedPreferences = await SharedPreferences.getInstance();

    // Create an instance of WeatherLocalDataSourcesImpl with real SharedPreferences
    final weatherLocalDataSourcesImpl = WeatherLocalDataSourcesImpl(
      sharedPreferences: sharedPreferences,
    );

    // Act
    await weatherLocalDataSourcesImpl.cashTheWeather(weatherModle);

    // Assert
    // Retrieve the data from SharedPreferences and verify it matches the expected JSON
    final cachedData = sharedPreferences.getString(key);
    final expectedJsonString = json.encode(weatherModle.toJson());

    expect(cachedData, equals(expectedJsonString));
  });
   
 });

}