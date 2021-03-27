import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/components/commons/app_loadings.dart';
import 'package:movie_app/components/screens/home_screen.dart';
import 'package:movie_app/components/screens/movies_screen.dart';

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(child: Text(snapshot.error.toString()));
            }
            if (snapshot.connectionState == ConnectionState.done) {
              delayToHome();
              return AppLoading.spinkitDualRingLoading();
            }
            return Center(
              child: AppLoading.spinkitDualRingLoading(),
            );
          },
        ),
      ),
    );
  }

  Future<void> delayToHome() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => HomeScreen()));
    });
  }
}
