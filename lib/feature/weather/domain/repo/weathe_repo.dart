import 'package:clean_arc2/feature/weather/domain/entites/weather.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/Failure.dart';

abstract class WeatherRepo  {
  
  Future<Either<Failure,Weather>> getWeatherRepo() ;
  Future<Either<Failure,Weather>> updateWetherRepo(String country,String region);


}