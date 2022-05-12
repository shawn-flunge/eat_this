

abstract class RestaurantRepository{

  Future<dynamic> getRestaurantsWithinCircle({required double lat, required double lng, required int radius});
}