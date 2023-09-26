import 'package:flutter/material.dart';
import 'package:test_hello/auth/model/login_response.dart';

class HomeScreen extends StatefulWidget {
  LoginResponse loginResponse;
  HomeScreen({super.key , required this.loginResponse});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Container(
        child: Column(
          children: [
            Text("Login Success"),
            Text("${widget.loginResponse.username!.toUpperCase()}")
          ],
        ),
      ),
    );
  }
}