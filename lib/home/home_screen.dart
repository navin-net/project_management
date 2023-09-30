import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:test_hello/auth/model/login_response.dart';
import 'package:test_hello/constants/constants.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {

  HomeScreen({super.key });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
      final LocalStorage storage =  LocalStorage(Constants.user_local_key);
        bool _isHidden = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("${storage.getItem(Constants.user_name_key)}",
        style: TextStyle(
          color: Colors.white
        ),),
      ),
      body: Container(
        child: Column(
          children: [
            Text("Login Success"),
            Text("${storage.getItem(Constants.user_name_key)}"),
            // TextField(
            //   obscureText: _isHidden,
            //   decoration: InputDecoration(
            //     border: OutlineInputBorder(),
            //     labelText: 'Password',
            //     suffix: InkWell(
            //       onTap: _togglePasswordView,  /// This is Magical Function
            //       child: Icon(
            //         _isHidden ?         /// CHeck Show & Hide.
            //         Icons.visibility :
            //         Icons.visibility_off,
            //       ),
            //     ),
            //   ),
            // ),

          ],
        ),
      ),
    );
  }
    void _togglePasswordView() {
    setState(() {
        _isHidden = !_isHidden;
    });
}

}