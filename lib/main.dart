import 'package:clean_arc2/feature/weather/presentation/stateMangemant/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature/weather/presentation/pages/weather_page.dart';
import 'ingectchin.dart' as di;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init() ;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: BlocProvider(
        create: (context) => di.sl<WeatherBloc>(),
        child: WeatherPage(),
      )
    );
  }
}

