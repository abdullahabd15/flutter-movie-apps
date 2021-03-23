import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:movie_app/resources/dimens/dimens.dart';

class LoginScreen extends StatelessWidget {
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
                "Hi there",
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
                text: "Sign in with Google",
                onPressed: () {},
              ),
              SizedBox(
                height: Dimens.default_vertical_padding,
              ),
              SignInButton(
                Buttons.Apple,
                text: "Sign in with Apple",
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
