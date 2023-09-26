import 'package:test_hello/auth/model/login_request.dart';
import 'package:test_hello/repository/http_repository.dart';
import 'package:test_hello/service/http_service_injection.dart';
import 'package:test_hello/auth/view/login_view.dart';

class LoginPresenter{
  late LoginView view;
  late HttpRepository httpRepository;

  LoginPresenter(this.view){
    httpRepository = HttpServiceInjection().httpRepository;
  }

  void login(LoginRequest req){
    view.onLoading();
    httpRepository.Login(req).then((value){
      view.onHiding();
      if (value.isSuccess == true) {
        view.onGetLoginSuccess(value.data!);
      } else {
        view.onError(value.message!);
      }

    });
  }
}