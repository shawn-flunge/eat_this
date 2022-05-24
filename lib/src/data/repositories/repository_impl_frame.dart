
import 'package:eat_this/src/data/data_sources/rest_client.dart';

abstract class RepositoryImplFrame{
  late RestClient restClient;

  init({required RestClient restClientParam}){
    restClient = restClientParam;
  }
}