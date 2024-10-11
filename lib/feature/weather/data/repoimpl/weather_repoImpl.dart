import 'package:clean_arc2/core/errors/Failure.dart';
import 'package:clean_arc2/core/network/network_info.dart';
import 'package:clean_arc2/feature/weather/data/datasources/weather_local_data_sources.dart';
import 'package:clean_arc2/feature/weather/data/datasources/weather_remot_data_source.dart';
import 'package:clean_arc2/feature/weather/domain/entites/weather.dart';
import 'package:clean_arc2/feature/weather/domain/repo/weathe_repo.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/exspshen.dart';

class WeatherRepoimpl implements WeatherRepo {

  final NetworkInfo networkInfo ;
  final WeatherRemotDataSource weatherRemotDataSource ;
  final WeatherLocalDataSources weatherLocalDataSources ;

  WeatherRepoimpl({
    required this.networkInfo,
     required this.weatherRemotDataSource,
      required this.weatherLocalDataSources});



  @override
  Future<Either<Failure, Weather>> getWeatherRepo() {
    
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Weather>> updateWetherRepo(String country, String region)async {
    if (await networkInfo.isConnected) {
       try {
         final weatherData = await weatherRemotDataSource.updateWetherRemoatData(country, region);
         weatherLocalDataSources.cashTheWeather(weatherData);
         return Right(weatherData) ;
       } on ServerException {
        return Left(ServerFailer());
       }
    }else{
      
      try {
        final cashData =await weatherLocalDataSources.getWeather();

        return Right(cashData);

      }on OfflineException {
        return  Left(OfflineFailer());
      }

    }
  }

  }
  
