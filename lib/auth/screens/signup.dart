import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/auth/screens/verification.dart';
import 'package:posterbox/utils/globalvariable.dart';

import '../../common/widgets/appbar.dart';
import '../../common/widgets/button.dart';
import '../../common/widgets/textfield.dart';
import '../service/authservice.dart';

class SignUp extends StatefulWidget {

  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin{

  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _checkPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Animation ? animation, delayedAnimation,muchDelayAnimation,animation1,animation2,animation3;
  AnimationController ? animationController;

  @override
  void initState() {

    super.initState();
    myFocusNode = FocusNode();
    myFocusNode.requestFocus();
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
  bool isPhoneValid(phone) => phone.length == 10;
  static bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }
  bool isEmail(String s) => hasMatch(s,
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  bool isLoading = false;

  void generateOtp(){
    setState(() {
      isLoading = true;
    });
    authService.generateOtp(context: context,
      phone: _phoneController.text,
      email: _emailController.text,
      name: _nameController.text,
      password: _passwordController.text,).then((value) => setState(() {
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
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _checkPasswordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    myFocusNode.dispose();
  }
  String mobileNo = '';

  late FocusNode myFocusNode;
  bool isObscure = true;









  @override
  Widget build(BuildContext context) {
    animationController!.forward();
    return AnimatedBuilder(animation: animationController!, builder: (context, child){
    return Scaffold(
      appBar: customappBar(
        title: 'Sign up',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 13),
            child: Form(
              key: profileKey,
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                FadeTransition(
                opacity: animation3 as dynamic,
                child: Transform(
                  transform: Matrix4.translationValues(animation!.value * 40, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Full Name',style: globalvariable.lgtext1,),
                      CustomTextField(controller: _nameController, hintText: '',  validate: (_nameController ) {
                        if (_nameController!.isEmpty) {
                          return 'This field is required';
                        }
                      },),
                      SizedBox(height: 5.h,),
                      Text('Mobile Number',style: globalvariable.lgtext1,),
                      CustomTextField(controller: _phoneController , hintText: '9056445579',keyboard: TextInputType.number,
                        validate: (_phoneController ) {
                        if (_phoneController!.isEmpty) {
                        return ('A phone number is required to proceed');
                        }
                        if (isPhoneValid(_phoneController)) {
                        return null;
                        } else {
                        return ('incorrect format');
                        }
                        },),
                      SizedBox(height: 5.h,),
                      Text('Email',style: globalvariable.lgtext1,),
                      CustomTextField(controller: _emailController , hintText: '', validate: (_emailController ) {
                      if (_emailController!.isEmpty) {
                      return 'Please enter your email address';
                      }
                      if (isEmail(_emailController)) {
                      return null;
                      } else {
                      return 'Invalid email address';
                      }
                      },),
                    ],
                  ))),
              FadeTransition(
                opacity: animation2 as dynamic,
                child: Transform(
                  transform: Matrix4.translationValues(delayedAnimation!.value * 40, 0, 0),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 5.h,),
                      Text('Password',style: globalvariable.lgtext1,),
                      CustomTextField(controller: _passwordController, hintText: '',isObscure: isObscure,suffixIconData:  isObscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,onTap: (){
                        setState(() {
                          isObscure = !isObscure;
                        });
                      }, validate:  (_passwordController) {
                        if (_passwordController!.isEmpty) {
                          return 'This field is required';
                        }
                        if (_passwordController.length < 6) {
                          return 'password lenght should be greater than 6 characters';
                        }
                      },


                      ),
                      SizedBox(height: 5.h,),
                      Text('Confirm Password',style: globalvariable.lgtext1,),
                      CustomTextField(controller: _checkPasswordController , hintText: '',isObscure: isObscure,suffixIconData:  isObscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,onTap: (){
                        setState(() {
                          isObscure = !isObscure;
                        });
                      }, validate:(_checkPasswordController) {
                        if (_checkPasswordController!.isEmpty) {
                          return 'You havent confirmed your password';
                        }

                        if (_checkPasswordController != _passwordController.text) {
                          return 'Passwords do not match';
                        } else {
                          return null;
                        }
                      },


                          ),
                      SizedBox(height: 20.h,),
                    ],
                  )) ),



                ],
              ),
            ),
          ),
            FadeTransition(
            opacity: animation1 as dynamic,
            child: Transform(
            transform: Matrix4.translationValues(0, muchDelayAnimation!.value * 40, 0),
            child: isLoading
              ?Center(child: CircularProgressIndicator()):Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: CustomButton(text: 'Next', onTap: (){
            if (validateProfileAndSave()) {
                      generateOtp();
                }

                // AuthService.otpLogin(mobileNo).then((res) async{
                //
                //   if(res.data != null){
                //
                //     Navigator.push(context,MaterialPageRoute (builder :(context) => Verification(
                //
                //       email: _emailController.text,
                //       name: _nameController.text,
                //       password: _passwordController.text,
                //     )),);
                //   }
                // });




          }),
              ),))
        ],
      ),
    );});
  }
}
