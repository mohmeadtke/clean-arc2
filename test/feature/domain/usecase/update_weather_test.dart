import 'package:clean_arc2/core/errors/Failure.dart';
import 'package:clean_arc2/feature/weather/domain/entites/weather.dart';
import 'package:clean_arc2/feature/weather/domain/repo/weathe_repo.dart';
import 'package:clean_arc2/feature/weather/domain/usecase/Update_Weather.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeUpdateWeather implements WeatherRepo{
   final weather =const Weather(
    country: "country",
     region: "region",
      temp_c: 2.5,
       wind_kph: 2.5,
        uv: 2.5,
         humidity: 2);

  @override
  Future<Either<Failure, Weather>> updateWetherRepo(String country, String region)async {
 
    return  Right(weather);
        
    
  }
  

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}


void main(){
 late  FakeUpdateWeather fakeUpdateWeather ;
 late UpdateWeather updateWeather ;

  setUp((){
    fakeUpdateWeather =FakeUpdateWeather() ;
    updateWeather = UpdateWeather(weatherRepo: fakeUpdateWeather);
  });

  String country = "country" ;
   String  region= "region" ;
      const weather = Weather(
    country: "country",
     region: "region",
      temp_c: 2.5,
       wind_kph: 2.5,
        uv: 2.5,
         humidity: 2);

  test('shuold update the Weather ',
   () async {

    // Act
    final resualt =await updateWeather(country,region);
    //Assert
    expect(resualt,const Right(weather) );
  });


}