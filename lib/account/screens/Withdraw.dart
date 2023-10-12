import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:posterbox/common/widgets/appbar.dart';
import 'package:posterbox/utils/globalvariable.dart';
import '../../common/widgets/button.dart';
import '../../common/widgets/textfield.dart';
import '../services/accountServices.dart';


class Withdraw extends StatefulWidget {
  const Withdraw({Key? key}) : super(key: key);

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> with TickerProviderStateMixin{
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
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  final AccountServices accountService = AccountServices();
  bool isLoading = false;

  void withdraw(){
               setState(() {
      isLoading = true;
    });
    accountService.withdraw(context: context,
      account: _accountController.text,
      amount: int.parse(_amountController.text),
      name: _emailController.text,
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
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _amountController.dispose();
    _accountController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    animationController!.forward();
    return AnimatedBuilder(animation: animationController!, builder: (context, child){

      return Scaffold(
      appBar: customappBar(
        title: 'Withdraw',
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
                    Text('Bank Name',style: globalvariable.lgtext1,),
                    CustomTextField(controller: _emailController , hintText: 'UBA'),
                    SizedBox(height: 5.h,),
                    Text('Account Number',style: globalvariable.lgtext1,),
                  ],
                ))),
                FadeTransition(
                  opacity: animation2 as dynamic,
                  child: Transform(
                    transform: Matrix4.translationValues(delayedAnimation!.value * 40, 0, 0),
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    CustomTextField(controller: _accountController , hintText: '2021039274',),
                    SizedBox(height: 5.h,),
                    Text('Amount',style: globalvariable.lgtext1,),
                    CustomTextField(controller: _amountController , hintText: ''),
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
                    ?Center(child: CircularProgressIndicator()):CustomButton(text: 'Withdraw', onTap: (){
            withdraw();
          }))),
        ],
      ),
    );});
  }
}
