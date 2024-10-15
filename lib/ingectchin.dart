import 'package:clean_arc2/core/network/network_info.dart';
import 'package:clean_arc2/feature/weather/data/datasources/weather_local_data_sources.dart';
import 'package:clean_arc2/feature/weather/data/datasources/weather_remot_data_source.dart';
import 'package:clean_arc2/feature/weather/data/repoimpl/weather_repoImpl.dart';
import 'package:clean_arc2/feature/weather/domain/repo/weathe_repo.dart';
import 'package:clean_arc2/feature/weather/domain/usecase/Update_Weather.dart';
import 'package:clean_arc2/feature/weather/domain/usecase/get_weather_usecase.dart';
import 'package:clean_arc2/feature/weather/presentation/stateMangemant/bloc/weather_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:http/http.dart' as http ;
import 'package:shared_preferences/shared_preferences.dart';


final sl = GetIt.instance ;

Future<void> init()async {

  
  //! Feature
    // bloc
    sl.registerFactory(()=>
    WeatherBloc(
        updateWeather: sl(),
         getWeatherUsecase: sl()));

    //usecase
    sl.registerLazySingleton(()=>
    GetWeatherUsecase(sl()) );
    
    sl.registerLazySingleton(()=>
    UpdateWeather(weatherRepo: sl()) );

    //repo
    sl.registerLazySingleton<WeatherRepo>(()=>
    WeatherRepoimpl(networkInfo: sl(),
     weatherRemotDataSource: sl(),
      weatherLocalDataSources: sl()));
    //data
    sl.registerLazySingleton<WeatherRemotDataSource>(()=>
    WeatherRemotDataSourceImpl(client: sl()));
    
    sl.registerLazySingleton<WeatherLocalDataSources>(()=>
    WeatherLocalDataSourcesImpl(sharedPreferences: sl()));
  //! Core 
  sl.registerLazySingleton<NetworkInfo>(()=>
  NetworkInfoImpl(connectionChecker: sl()));

  //! Extrenal
  
  final sharedPreferences =  await SharedPreferences.getInstance(); 

  sl.registerLazySingleton(()=>sharedPreferences);
  sl.registerLazySingleton(()=>InternetConnection());
  sl.registerLazySingleton(()=>http.Client());

}