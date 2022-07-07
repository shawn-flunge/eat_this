

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

// @RestApi(baseUrl: 'http://eat-this-dev-1952923402.ap-northeast-2.elb.amazonaws.com')
@RestApi(baseUrl: 'http://ec2-43-200-24-172.ap-northeast-2.compute.amazonaws.com:8080')
abstract class RestClient {

  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/locations/circle?lat={lat}&lng={lng}&radius={radius}')
  Future<dynamic> getRestaurantsWithinCircle(@Path() double lat, @Path() double lng, @Path() int radius);

  @GET('/locations/circle/category?lat={lat}&lng={lng}&radius={radius}')
  Future<dynamic> getRestaurantsSortedByCategory(@Path() double lat, @Path() double lng, @Path() int radius);
}