import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/auth/screens/signup.dart';
import 'package:posterbox/auth/screens/verification.dart';
import 'package:posterbox/home/screens/home.dart';
import 'package:posterbox/utils/globalvariable.dart';

import '../../common/widgets/appbar.dart';
import '../../common/widgets/bottombar.dart';
import '../../common/widgets/button.dart';
import '../../common/widgets/textfield.dart';
import '../service/authservice.dart';

class Login extends StatefulWidget {

  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin{
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Animation ? animation, delayedAnimation,muchDelayAnimation,animation1,animation2,animation3;
  AnimationController ? animationController;
  bool isLoading = false;
  bool isObscure = true;
  static bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }
  bool isEmail(String s) => hasMatch(s,
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  @override
  void initState() {

    super.initState();

    animationController = AnimationController(duration: const Duration(seconds: 1),vsync: this);

    animation = Tween(begin: -0.5,end: 0.0).animate(CurvedAnimation(parent: animationController!, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: -0.5,end: 0.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0.1, 1,curve: Curves.fastOutSlowIn)));

    muchDelayAnimation = Tween(begin: -0.5,end: 0.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: const Interval(0.3, 1,curve: Curves.fastOutSlowIn)));
    animation1 = CurvedAnimation(parent: animationController!,   curve: const Interval(0.2, 1,curve: Curves.fastOutSlowIn));
    animation2 = CurvedAnimation(parent: animationController!,   curve: const Interval(0.1, 1,curve: Curves.fastOutSlowIn));
    animation3 = CurvedAnimation(parent: animationController!,   curve: const Interval(0.1, 1,curve: Curves.fastOutSlowIn));

  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();

  }

  void signInUser() {
    setState(() {
      isLoading = true;
    });
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    ).then((value) => setState(() {
      isLoading = false;
    }));
    Timer(Duration(minutes: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }
  var profileKey = GlobalKey<FormState>();
  bool validateProfileAndSave() {
    final form = profileKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const customappBar(
        title: 'Login',
      ),
      body: Form(
        key: profileKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 13),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text('Email',style: globalvariable.lgtext1,),
                  CustomTextField(controller: _emailController , hintText: '',validate: (_emailController ) {
                    if (_emailController!.isEmpty) {
                    return 'Please enter your email address';
                    }
                    if (isEmail(_emailController)) {
                    return null;
                    } else {
                    return 'Invalid email address';
                    }
                    },),
                   SizedBox(height: 5.h,),
                   Text('Password',style: globalvariable.lgtext1,),
                  CustomTextField(controller: _passwordController , hintText: '', isObscure: isObscure,suffixIconData:  isObscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,onTap: (){
                               setState(() {
                                              isObscure = !isObscure;
                                                });
                                              },
                       validate:  (_passwordController) {
                                        if (_passwordController!.isEmpty) {
                                    return 'This field is required';
                                    }
                                    if (_passwordController.length < 6) {
                                    return 'password lenght should be greater than 6 characters';
                                    }
                                    },


                    ),
                   SizedBox(height: 5.h,),
                  const Align(
                      alignment: Alignment.bottomRight,
                      child: Text('Forgot password?',style: TextStyle(color: globalvariable.primarycolor),)),
                   SizedBox(height: 5.h,),
                  Row(
                    children: [
                      Text('If you dont have an account,', style: globalvariable.lgtext1,),
                      GestureDetector(
                        onTap: ()=> Navigator.push(context,  MaterialPageRoute(
                           builder: (context) =>  const SignUp(),
                       )),
                          child: Text('Sign Up', style: TextStyle(color: globalvariable.primarycolor),)),
                    ],
                  )


                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),

                 child: isLoading
                      ?Center(child: CircularProgressIndicator()): CustomButton(text: 'Next', onTap: () {
                   if (validateProfileAndSave()) {
                     signInUser();
                   }

                  })



            ),

          ],
        ),
      ),
    );
  }
}
