import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Google Login"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: size.height * 0.2,
            bottom: size.height * 0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Olá, \nClique no ícone para realizar login",
                style: TextStyle(fontSize: 20, fontFamily: 'Arial')),
            GestureDetector(
                onTap: () {
                  AuthService().signInWithGoogle();
                },
                child: const Image(
                    width: 100, image: AssetImage('assets/google.png'))),
          ],
        ),
      ),
    );
  }
}
