import 'package:test_hello/auth/model/login_request.dart';
import 'package:test_hello/auth/model/login_response.dart';
import 'package:test_hello/models/http_base_response.dart';

abstract interface class HttpRepository{
    Future<HttpBaseResponse<LoginResponse>> Login(LoginRequest req);


}