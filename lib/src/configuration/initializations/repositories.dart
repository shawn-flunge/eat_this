
import 'package:dio/dio.dart';
import 'package:eat_this/src/data/data_sources/rest_client.dart';
import 'package:eat_this/src/data/repositories/restaurant_repository_impl.dart';

void repositoriesInjection(){
  Dio dio = Dio();
  RestClient restClient = RestClient(dio);

  RestaurantRepositoryImpl().init(restClientParam: restClient);
}