import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:movie_app/logic/auth_repository.dart';

class LoginScreen extends StatelessWidget {
  final authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.play_arrow_sharp,
                size: 160.0,
                color: Colors.amberAccent,
              ),
              Text(
                "Hi there,",
                style: TextStyle(
                  fontSize: 36.0,
                ),
              ),
              Text(
                "Please Sign in",
                style: TextStyle(
                  fontSize: 28.0,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              SignInButton(
                Buttons.Google,
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                text: "Sign in with Google",
                onPressed: () {
                  _signInWithGoogle();
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              SignInButton(
                Buttons.Apple,
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                text: "Sign in with Apple",
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signInWithGoogle() async {
    var user = await authRepository.signInWithGoogle();
    if (user != null) {
      print("Sign in success");
    }
  }
}
