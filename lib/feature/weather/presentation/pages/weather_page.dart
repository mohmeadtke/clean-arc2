import 'package:clean_arc2/feature/weather/presentation/stateMangemant/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text("weather App",style: TextStyle(color: Colors.black),),
      ),
      body:  Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
            
              if (state is LodingState) {
                return const Center(
                  child:  CircularProgressIndicator(),
                );
              } else if(state is LodedState){
                return Center(
                  child: Column(
                  children: [
                    Text("country:${state.weather.country}"),
                    Text("region:${state.weather.region}"),
                    Text("temp:${state.weather.temp_c} C"),
                    Text("wind:${state.weather.wind_kph} Kph"),
                    Text("humidity:${state.weather.humidity}"),
                    Text("uv:${state.weather.uv}"),
                  ],
                ),
                );
              }else if(state is ErorrState){
                return Center(
                  child: Text("hi ${state.massge}"),
                );
              }
              else{
                return Text("data");
              }
            

             }
            
          ),
          ElevatedButton(onPressed: (){BlocProvider.of<WeatherBloc>(context).add(GetRoandomeWeatherEvent());},
           child: Text("data"))
        ],
      ),
    );
  }
}