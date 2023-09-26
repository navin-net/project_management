import 'package:test_hello/repository/http_repository.dart';
import 'package:test_hello/repository/http_repository_impl.dart';

class HttpServiceInjection{
  static final HttpServiceInjection _singleton =
  HttpServiceInjection._injection();

  factory HttpServiceInjection(){
    return _singleton;

  }
  HttpServiceInjection._injection();

  HttpRepository get httpRepository => HttpRepositoryImpl();

}