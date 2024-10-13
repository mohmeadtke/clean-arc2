part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();
  
  @override
  List<Object> get props => [];
}

final class WeatherInitial extends WeatherState {}

class LodingState extends WeatherState {}

class LodedState extends WeatherState {

  final Weather weather ;

  const LodedState({required this.weather});

}

class ErorrState extends WeatherState {

  final String massge ;

  const ErorrState({required this.massge});

}
