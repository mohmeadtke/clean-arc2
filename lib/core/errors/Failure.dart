import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{}

class OfflineFailer extends Failure{
  @override

  List<Object?> get props => [];
}

class ServerFailer extends Failure {
  @override

  List<Object?> get props => [];
}