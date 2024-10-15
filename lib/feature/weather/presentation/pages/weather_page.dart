import 'package:clean_arc2/feature/weather/presentation/stateMangemant/bloc/weather_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text("weather App"),
      ),
      body:  Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              return Container(
                height:200,
                width: 200,
                child: Placeholder(),
              );
            },
          )
        ],
      ),
    );
  }
}