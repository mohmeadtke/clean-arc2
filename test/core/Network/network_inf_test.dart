import 'package:clean_arc2/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mocktail/mocktail.dart';

class MockInternetConnectionChecker extends Mock implements InternetConnection  {}

void main(){

 late MockInternetConnectionChecker mockInternetConnectionChecker ;
 late NetworkInfoImpl networkInfoImpl ;
    setUp((){
      mockInternetConnectionChecker=MockInternetConnectionChecker();
      networkInfoImpl=NetworkInfoImpl(connectionChecker:mockInternetConnectionChecker);
    });

   

    group('InternetConnectionChecker', () {

       test('check the InternetConnectionChecker is online', () async{

        when(()=>mockInternetConnectionChecker.hasInternetAccess).thenAnswer((_)async=> true);

      final resualt =await networkInfoImpl.isConnected ;

      verify(()=>mockInternetConnectionChecker.hasInternetAccess);
      expect (resualt, true);
      
      });

       test('check the InternetConnectionChecker is offline', () async{

        when(()=>mockInternetConnectionChecker.hasInternetAccess).thenAnswer((_)async=> false);

      final resualt =await networkInfoImpl.isConnected ;

      verify(()=>mockInternetConnectionChecker.hasInternetAccess);
      expect (resualt, false);
      
      });

      
    });

}