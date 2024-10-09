import 'package:clean_arc2/core/errors/Failure.dart';
import 'package:clean_arc2/feature/weather/domain/entites/weather.dart';
import 'package:clean_arc2/feature/weather/domain/repo/weathe_repo.dart';
import 'package:dartz/dartz.dart';

class GetWeatherUsecase {
  final WeatherRepo weatherRepo ;
  
  GetWeatherUsecase( this.weatherRepo);

  Future<Either<Failure,Weather>> call()async{
    return await weatherRepo.getWeatherRepo() ;
  }

}