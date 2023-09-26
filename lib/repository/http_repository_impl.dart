import 'dart:convert';

import 'package:test_hello/auth/model/login_request.dart';
import 'package:test_hello/auth/model/login_response.dart';
import 'package:test_hello/models/http_base_response.dart';
import 'package:test_hello/repository/http_repository.dart';
import 'package:test_hello/service/api.dart';
import 'package:http/http.dart' as http;

class HttpRepositoryImpl extends Api implements HttpRepository{
  @override
  Future<HttpBaseResponse<LoginResponse>> Login(LoginRequest req) async {
    try{
    var url = Uri.parse(loginUrl);
    var response = await http.post(
      url,
      // headers: {
      //   "Content-Type":"application/json"
      // },
      body: req.toJson()
    );
    final Map map = jsonDecode(response.body);
    if (response.statusCode==200) {

      return HttpBaseResponse(
        code: 200,
        isSuccess: true,
        message: "",
        data: LoginResponse.fromJson(map),
      );

    }else{

      return HttpBaseResponse(
        code: 400,
        isSuccess: false,
        message: "",
        data: map["message"]
      );
    }
  }catch(e){
    return HttpBaseResponse(
        code: 500,
        isSuccess: false,
        message: e.toString(),
        data: null,
      );
  }
  }
}