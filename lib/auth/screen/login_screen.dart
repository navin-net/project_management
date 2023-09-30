import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:test_hello/auth/model/login_request.dart';
import 'package:test_hello/auth/model/login_response.dart';
import 'package:test_hello/auth/prestenter/login_prestenter.dart';
import 'package:test_hello/auth/view/login_view.dart';
import 'package:test_hello/constants/constants.dart';
import 'package:test_hello/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginView {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();
  late LoginPresenter presenter;
  bool loading = false;
          bool _isHidden = true;




  @override
  void initState() {
    super.initState();
    presenter = LoginPresenter(this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.indigo,
        // title: Text('Login'),
      ),
      // body: Form(
      //   key: _formKey,
      //   child: Container(
      //     padding: EdgeInsets.all(20),
      //     child: ListView(
      //       children: [
        body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 200,
                child: Center(
                  child: Text(
                    'Build Bright University',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _username,
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'username',
                  ),
                  // decoration: const InputDecoration(
                  // border: OutlineInputBorder(),
                  // prefixIcon: Icon(Icons.mail),
                  // hintText: 'Enter E-mail'),
                  // decoration: InputDecoration(
                  //   label: Text("username"),
                  //   prefixIcon: Icon(Icons.supervised_user_circle_outlined)
                  // ),
                      validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter username";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _password,
                  obscureText: _isHidden,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    suffix: InkWell(
                  onTap: _togglePasswordView,  /// This is Magical Function
                  child: Icon(
                     _isHidden ?         /// CHeck Show & Hide.
                    Icons.visibility :
                    Icons.visibility_off,
                  ),
                ),
                  ),
                  // decoration: const InputDecoration(
                  // border: OutlineInputBorder(),
                  // prefixIcon: Icon(Icons.lock),
                  // hintText: 'Enter Password'),
                  // decoration: InputDecoration(
                  //   label: Text("password"),
                  //   prefixIcon: Icon(Icons.lock)
                  // ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter password";
                    }
                    return null;
                  },
                ),
              ),
              loading == true ?  Container(
                height: 60,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.indigo,
                  ),
                ),
              ) : Container()
            ],
          ),
        ),
      ),
    bottomNavigationBar: InkWell(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          // print("username ${_username.text}");
          // print("password ${_password.text}");
          LoginRequest req = LoginRequest();
          req.username =_username.text;
          req.password =_password.text;
          presenter.login(req);

        }
      },
      child: Container(
        height: 50,
        margin: EdgeInsets.all(20),
        color: Colors.indigo,
        child: Center(
          child: Text("login"),
        ),
      ),
    ),
    );
  }

  @override
  void onError(String message) {
    _showMyDialog('Login Unsuccess');
  }

  @override
  void onGetLoginSuccess(LoginResponse loginResponse) {
  // _showMyDialog(loginResponse.username!);
  // Navigator.push(context, MaterialPageRoute(builder: (context) =>
  // HomeScreen(loginResponse: loginResponse)));
  final LocalStorage storage = new LocalStorage(Constants.user_local_key);
  // storage.setItem(Constants.user_key, loginResponse.toJson());
  //   storage.setItem(Constants.user_name_key, loginResponse.username);
  //   storage.setItem(Constants.user_email_key, loginResponse.email);
  //   storage.setItem(Constants.token_key, loginResponse.token);
  //   storage.setItem(Constants.image_key, loginResponse.image);
  // Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
    storage.setItem(Constants.user_name_key, loginResponse.username);
    Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
  }

  @override
  void onHiding() {
    setState(() {
      loading = false;
    });
  }

  @override
  void onLoading() {
    setState(() {
      loading = true;
    });
  }


  Future<void> _showMyDialog(String message) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Message'),
        content:  SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('${message}'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Okey'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


  void _togglePasswordView() {
    setState(() {
        _isHidden = !_isHidden;
    });
  }
}
