
import 'package:eat_this/src/data/repositories/repository_impl_frame.dart';
import 'package:eat_this/src/domain/repositories/restaurant_repository.dart';

class RestaurantRepositoryImpl extends RepositoryImplFrame with RestaurantRepository{

  static final RestaurantRepositoryImpl _instance = RestaurantRepositoryImpl._internal();
  RestaurantRepositoryImpl._internal();

  factory RestaurantRepositoryImpl(){
    return _instance;
  }

  @override
  Future getRestaurantsWithinCircle({required double lat, required double lng, required int radius}) async{
    try{
      final response = await restClient.getRestaurantsWithinCircle(lat, lng, radius);
    } catch(error){
      print(error);
    }
  }
}

