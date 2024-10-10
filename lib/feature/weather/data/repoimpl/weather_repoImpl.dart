import 'package:clean_arc2/core/errors/Failure.dart';
import 'package:clean_arc2/feature/weather/domain/entites/weather.dart';
import 'package:clean_arc2/feature/weather/domain/repo/weathe_repo.dart';
import 'package:dartz/dartz.dart';

class WeatherRepoimpl implements WeatherRepo {
  @override
  Future<Either<Failure, Weather>> getWeatherRepo() {
    
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Weather>> updateWetherRepo(String country, String region) {
   
    throw UnimplementedError();
  }
  
}