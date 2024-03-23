import 'dart:async';

import 'package:flutter/material.dart';
import 'package:posterbox/auth/screens/unboardingScreen.dart';
import 'package:posterbox/utils/globalvariable.dart';

class splashpage extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const splashpage({Key? key}) : super(key: key);

  @override
  State<splashpage> createState() => _splashpageState();
}

class _splashpageState extends State<splashpage> {
  late Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer(
        Duration(seconds: 3),
            () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>  onboardingScreen(),
            )));

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globalvariable.primarycolor,
      body: Center(
        child: Image.asset('assets/logo.jpg'),
      ),
    );
  }
}
