import 'package:bloc/bloc.dart';
import 'package:clean_arc2/core/errors/Failure.dart';
import 'package:clean_arc2/feature/weather/domain/entites/weather.dart';
import 'package:clean_arc2/feature/weather/domain/usecase/Update_Weather.dart';
import 'package:clean_arc2/feature/weather/domain/usecase/get_weather_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  final UpdateWeather updateWeather ;  
  final GetWeatherUsecase getWeatherUsecase ;

  WeatherBloc({required this.updateWeather,required this.getWeatherUsecase}) : super(WeatherInitial()) {

      String _mapToMassgeFaliuer(Failure failure){
      if(failure is ServerFailer) {
        return "server failure " ;
      }
      else if(failure is OfflineFailer){
        return "offline failure";
      }
      else {
        return "an expacted failure ";
      }

    }


 
    on<WeatherEvent>((event, emit)async {

      if (event is GetCountryWeatherEvent){

        emit(LodingState());
        final fialuerOrWeather =await updateWeather(event.country,event.region);
        emit(
           fialuerOrWeather.fold(
          (failure)=>  ErorrState(massge: _mapToMassgeFaliuer(failure)) ,
           (weather)=> LodedState(weather: weather)) 
        );
      }else if(event is GetRoandomeWeatherEvent){
          emit(LodingState());
          final fialuerOrWeatherr =await getWeatherUsecase();

          emit(
            fialuerOrWeatherr.fold(
              (fialure)=> ErorrState(massge: _mapToMassgeFaliuer(fialure)),
               (weather)=>LodedState(weather: weather) )
          );

      }


    });

  
  }
}
