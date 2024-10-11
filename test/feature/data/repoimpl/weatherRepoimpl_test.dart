import 'package:clean_arc2/core/network/network_info.dart';
import 'package:clean_arc2/feature/weather/data/datasources/weather_local_data_sources.dart';
import 'package:clean_arc2/feature/weather/data/datasources/weather_remot_data_source.dart';
import 'package:clean_arc2/feature/weather/data/model/Weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:clean_arc2/feature/weather/data/repoimpl/weather_repoImpl.dart';

class MockNewtorkInfo extends Mock implements NetworkInfo {

  
}

class MockWeatherLocalDataSources extends Mock implements  WeatherLocalDataSources {
 @override
  Future<void> cashTheWeather(WeatherModel weathermodle) async{
     
    return  ;
  }

  @override
  Future<WeatherModel> getWeather() async{
     const weathermodle = WeatherModel(
          country: "country", region: "region", temp_c: 2.5, wind_kph: 2.5, uv: 2.5, humidity: 2);

    return weathermodle;
  }

}

class MockWeatherRemotDataSource extends Mock implements WeatherRemotDataSource {
     @override
  Future<WeatherModel> updateWetherRemoatData(String country, String region) async{
    const weatherModel = WeatherModel(country: "country", region: "region", temp_c: 2.5, wind_kph: 2.5, uv: 2.5, humidity: 2);

    return weatherModel ;
  }
}


void main(){


final MockNewtorkInfo mockNewtorkInfo =MockNewtorkInfo() ;
final MockWeatherLocalDataSources  mockWeatherLocalDataSources=MockWeatherLocalDataSources() ;
final MockWeatherRemotDataSource mockWeatherRemotDataSource=MockWeatherRemotDataSource() ;
final WeatherRepoimpl weatherRepoimpl=WeatherRepoimpl(
  networkInfo: mockNewtorkInfo,
   weatherRemotDataSource: mockWeatherRemotDataSource,
    weatherLocalDataSources: mockWeatherLocalDataSources) ;

// setUp((){

//     mockNewtorkInfo =MockNewtorkInfo() ;
//     mockWeatherLocalDataSources = MockWeatherLocalDataSources();
//     mockWeatherRemotDataSource = MockWeatherRemotDataSource();
//     weatherRepoimpl =WeatherRepoimpl(
//       networkInfo: mockNewtorkInfo,
//        weatherRemotDataSource: mockWeatherRemotDataSource,
//         weatherLocalDataSources: mockWeatherLocalDataSources  );
//   });


group('cheking Weather repo impl  ',
 () {


      test('online', () async{
        
      //
      when(()=>mockNewtorkInfo.isConnected).thenAnswer((_) async=>true);
  

      //
      await weatherRepoimpl.updateWetherRepo("d","d");

      // 
      verify(()=>mockNewtorkInfo.isConnected);
      verifyNoMoreInteractions(mockWeatherRemotDataSource);
      
      });

     
     test('offline',
      () async{
          //
          when(()=>mockNewtorkInfo.isConnected).thenAnswer((_) async=> false);
          //
          await weatherRepoimpl.updateWetherRepo("","");
          //
          verify(()=>mockNewtorkInfo.isConnected);


     });


 } );


}





