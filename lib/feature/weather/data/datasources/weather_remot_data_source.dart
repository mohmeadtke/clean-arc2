import 'dart:convert';
import 'dart:math';
import 'package:clean_arc2/core/errors/exspshen.dart';
import 'package:clean_arc2/feature/weather/data/model/Weather_model.dart';
import'package:http/http.dart' as http ;
abstract class WeatherRemotDataSource {

  Future<WeatherModel> getWeatherRemoatData();

  Future<WeatherModel> updateWetherRemoatData(String country,String region);
}


class WeatherRemotDataSourceImpl implements WeatherRemotDataSource {
  final http.Client client;

  WeatherRemotDataSourceImpl({required this.client});
  

  @override
  Future<WeatherModel> getWeatherRemoatData() async{
    String getRandomCountry() {
  // List of countries
   List<String> countries = [
    'Iraq',
    'United States',
    'Japan',
    'Brazil',
    'Australia',
    'Germany',
    'Canada',
    'India',
    'Mexico',
    'France',
  ];

  // Generate a random index
  var random = Random();
  int index = random.nextInt(countries.length);

  // Return a random country
  return countries[index];
}

    final response = await client.get(
      Uri.parse("http://api.weatherapi.com/v1/current.json?key=c14e6834322b4e8f9d372148242909&q=${getRandomCountry()}&aqi=no"),
      // headers: {
      //   'Content-Type': 'application/json',  // Specify content type
      // },
    );

    if (response.statusCode == 200) {
      final responseAsWeatherModel = WeatherModel.fromJson(jsonDecode(response.body));
      return responseAsWeatherModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<WeatherModel> updateWetherRemoatData(String country, String region) async {
    final response = await client.get(
      Uri.parse("http://api.weatherapi.com/v1/current.json?key=c14e6834322b4e8f9d372148242909&q=$country/$region&aqi=no"),
      // headers: {
      //   'Content-Type': 'application/json',  // Specify content type
      // },
    );

    if (response.statusCode == 200) {
      final responseAsWeatherModel = WeatherModel.fromJson(jsonDecode(response.body));
      return responseAsWeatherModel;
    } else {
      throw ServerException();
    }
  }
}
