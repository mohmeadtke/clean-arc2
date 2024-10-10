// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class Weather extends Equatable {

  final String country ;
  final String region ;
  final double temp_c ;
  final double wind_kph ;
  final double uv ;
  final int humidity;

  const Weather({
  required this.country,
   required this.region,
    required this.temp_c,
     required this.wind_kph,
      required this.uv,
       required this.humidity });



  @override
 
  List<Object?> get props =>  [country,region,temp_c,wind_kph,uv,humidity] ;

}