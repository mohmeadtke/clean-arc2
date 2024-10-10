import 'package:clean_arc2/core/errors/Failure.dart';
import 'package:clean_arc2/feature/weather/domain/entites/weather.dart';
import 'package:clean_arc2/feature/weather/domain/repo/weathe_repo.dart';
import 'package:clean_arc2/feature/weather/domain/usecase/get_weather_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

// A fake repository for testing
class FakeWeatherRepo implements WeatherRepo {
    final weather = const Weather(
    country: "country",
    region: "region",
    temp_c: 2.5,
    wind_kph: 2.5,
    uv: 2.5,
    humidity: 2,
  );
  @override
  Future<Either<Failure, Weather>> getWeatherRepo() async {
    return  Right(weather);
  }
  
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late FakeWeatherRepo fakeWeatherRepo;
  late GetWeatherUsecase getWeatherUsecase;

  const weather = Weather(
    country: "country",
    region: "region",
    temp_c: 2.5,
    wind_kph: 2.5,
    uv: 2.5,
    humidity: 2,
  );

  setUp(() {
    fakeWeatherRepo = FakeWeatherRepo();
    getWeatherUsecase = GetWeatherUsecase(fakeWeatherRepo);
  });

  test('should get weather data from the repository', () async {
    // Act
    final result = await getWeatherUsecase(); // Call the usecase which internally calls the fake repo

    // Assert
    expect(result, const Right(weather));  // Check if the returned result is Right(weather)
  });
}
