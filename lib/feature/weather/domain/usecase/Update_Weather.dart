import 'package:clean_arc2/core/errors/Failure.dart';
import 'package:clean_arc2/feature/weather/domain/entites/weather.dart';
import 'package:clean_arc2/feature/weather/domain/repo/weathe_repo.dart';
import 'package:dartz/dartz.dart';

class UpdateWeather {
  final WeatherRepo weatherRepo ;

  UpdateWeather({required this.weatherRepo});

  Future<Either<Failure,Weather>> call(String country,String region ){

    return weatherRepo.updateWetherRepo(country, region);

  }

}