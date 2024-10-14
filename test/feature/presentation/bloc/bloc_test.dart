

import 'package:clean_arc2/core/errors/Failure.dart';
import 'package:clean_arc2/feature/weather/domain/entites/weather.dart';
import 'package:clean_arc2/feature/weather/domain/usecase/Update_Weather.dart';
import 'package:clean_arc2/feature/weather/domain/usecase/get_weather_usecase.dart';
import 'package:clean_arc2/feature/weather/presentation/stateMangemant/bloc/weather_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUpdateWeather extends Mock implements UpdateWeather {}

class MockGetWeatherUsecase extends Mock implements GetWeatherUsecase {}


void main(){

 late WeatherBloc weatherBloc ;
 late MockUpdateWeather mockUpdateWeather ; 
 late MockGetWeatherUsecase mockGetWeatherUsecase ;

  setUp((){
      mockUpdateWeather = MockUpdateWeather() ;  
      mockGetWeatherUsecase =MockGetWeatherUsecase() ;
      weatherBloc = WeatherBloc(updateWeather :mockUpdateWeather,getWeatherUsecase:mockGetWeatherUsecase) ;
  });

  group('testing bloc', () {

    const weather = Weather(country: "country", region: "region", temp_c: 2.5, wind_kph: 2.5, uv: 2.5, humidity: 5) ;

    test('Shuld get the Weather for  UpdateWeatherUsecase', () async{
      //
      when(()=> mockUpdateWeather.call("country", "region"))
      .thenAnswer((_)async=>const Right(weather)) ;

      final expected =[
        LodingState(),
       const LodedState(weather: weather)
      ] ;
      //
      expectLater(weatherBloc.stream,emitsInOrder(expected) );
      //
      weatherBloc.add(const GetCountryWeatherEvent(country: "country", region: "region")) ;
    });
    

    test('should get OfflineFailer from the update weather usecase', () {
      //
      when(() => mockUpdateWeather("country","region")).thenAnswer((_)async=> Left(OfflineFailer()));
      //

          final expected =[
        LodingState(),
        const  ErorrState(massge: "lala")
      ] ;

      expectLater(weatherBloc.stream, emitsInOrder(expected));
      //
      weatherBloc.add(const GetCountryWeatherEvent(country: "country", region: "region")) ;

      
    });




  });

}