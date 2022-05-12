

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'http://eat-this-dev-1952923402.ap-northeast-2.elb.amazonaws.com')
abstract class RestClient {

  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/api/v1/locations/circe?lat={lat}&lng={lng}&radius={radius}')
  Future<dynamic> getRestaurants(@Path() double lat, @Path() double lng, @Path() int radius);
}