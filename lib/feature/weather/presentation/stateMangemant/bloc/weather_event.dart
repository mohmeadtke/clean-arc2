part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}


class GetRoandomeWeatherEvent extends WeatherEvent {}

class GetCountryWeatherEvent extends WeatherEvent {
  final String country ;
  final String region ;

  const GetCountryWeatherEvent({required this.country, required this.region});
}