import 'package:flutter/material.dart';
import 'package:test_hello/auth/model/login_request.dart';
import 'package:test_hello/auth/model/login_response.dart';
import 'package:test_hello/auth/prestenter/login_prestenter.dart';
import 'package:test_hello/auth/view/login_view.dart';
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


  @override
  void initState() {
    super.initState();
    presenter = LoginPresenter(this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: _username,
                  decoration: InputDecoration(
                    label: Text("username"),
                    prefixIcon: Icon(Icons.supervised_user_circle_outlined)
                  ),
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
                  decoration: InputDecoration(
                    label: Text("password"),
                    prefixIcon: Icon(Icons.lock)
                  ),
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
          print("username ${_username.text}");
          print("password ${_password.text}");
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
    _showMyDialog(message);
  }

  @override
  void onGetLoginSuccess(LoginResponse loginResponse) {
  // _showMyDialog(loginResponse.username!);
  Navigator.push(context, MaterialPageRoute(builder: (context) =>
  HomeScreen(loginResponse: loginResponse)));
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
}