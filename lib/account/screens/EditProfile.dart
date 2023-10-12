import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/account/screens/accountScreen.dart';
import 'package:posterbox/common/widgets/appbar.dart';
import 'package:posterbox/home/services/homeService.dart';
import 'package:posterbox/utils/globalvariable.dart';
import '../../common/widgets/button.dart';
import '../../common/widgets/textfield.dart';
import '../services/accountServices.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> with TickerProviderStateMixin{
  Animation ? animation, delayedAnimation,muchDelayAnimation,animation1,animation2,animation3;
  AnimationController ? animationController;

  @override
  void initState() {

    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) => AlertDialog(
    //       title: Text("Your one time token"),
    //       content: Text(widget.token),
    //       actions: [
    //         TextButton(
    //           onPressed: () => Navigator.pop(context),
    //           child: Text('OK'),
    //         ),
    //       ],
    //     ),
    //   );
    // });
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
  final TextEditingController _emailController = TextEditingController();
  final AccountServices homeService = AccountServices();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _checkPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _checkPasswordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();

  }
  void editUser() {
       setState(() {
      isLoading = true;
    });
    homeService.editUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
    ).then((value) => setState(() {
      isLoading = false;
    }));
    Timer(Duration(minutes: 1), () {
      setState(() {
      isLoading = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    animationController!.forward();
    return AnimatedBuilder(animation: animationController!, builder: (context, child){

      return Scaffold(
      appBar: customappBar(
        title: 'Edit Profile',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 13),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeTransition(
                  opacity: animation3 as dynamic,
                  child: Transform(
                    transform: Matrix4.translationValues(animation!.value * 40, 0, 0),
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Full Name',style: globalvariable.lgtext1,),
                    CustomTextField(controller: _nameController , hintText: ''),
                    SizedBox(height: 5.h,),
                    Text('Email',style: globalvariable.lgtext1,),
                    CustomTextField(controller: _emailController , hintText: ''),
                  ],
                ))),
                FadeTransition(
                  opacity: animation3 as dynamic,
                  child: Transform(
                    transform: Matrix4.translationValues(animation!.value * 40, 0, 0),
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                    SizedBox(height: 5.h,),
                    Text('Old Password',style: globalvariable.lgtext1,),
                    CustomTextField(controller: _passwordController , hintText: '',suffixIconData: Icons.remove_red_eye,),
                    SizedBox(height: 5.h,),
                    Text('New Password',style: globalvariable.lgtext1,),
                    CustomTextField(controller: _checkPasswordController , hintText: '',suffixIconData: Icons.remove_red_eye,),
                    SizedBox(height: 20.h,),
                  ],
                ))),



              ],
            ),
          ),
      FadeTransition(
      opacity: animation1 as dynamic,
      child: Transform(
      transform: Matrix4.translationValues(0, muchDelayAnimation!.value * 40, 0),
      child:isLoading
             ?
                    Center(child: CircularProgressIndicator()):CustomButton(text: 'Confirm', onTap: () {
            editUser();
          }))),
        ],
      ),
    );});
  }
}
