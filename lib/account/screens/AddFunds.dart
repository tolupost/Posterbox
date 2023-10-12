import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/account/services/accountServices.dart';
import 'package:posterbox/common/widgets/appbar.dart';
import 'package:posterbox/utils/globalvariable.dart';
import '../../common/widgets/button.dart';
import '../../common/widgets/paystack.dart';
import '../../common/widgets/textfield.dart';
import '../../utils/utils.dart';
import 'WalletScreen.dart';

class Addfund extends StatefulWidget {
  const Addfund({Key? key}) : super(key: key);

  @override
  State<Addfund> createState() => _AddfundState();
}

class _AddfundState extends State<Addfund> with TickerProviderStateMixin{
  Animation ? animation, delayedAnimation,muchDelayAnimation,animation1,animation2,animation3;
  AnimationController ? animationController;

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
  final AccountServices accountservices = AccountServices();
  final TextEditingController _emailController = TextEditingController();
 bool isLoading = false;
  void addfund(){
        setState(() {
      isLoading = true;
    });

        showDialog(
          context: context,
          builder: (context) => paystack(
            fee: _emailController.text,
            callback: (bool success) {
              setState(() {
                isLoading = false;
              });
              if (success) {
                // Payment successful
                // Continue with the code execution
                accountservices.addFund(

                    context: context,
                    amount: int.parse(_emailController.text)).then((value) => setState(() {
                  isLoading = false;
                }));
                Timer(Duration(minutes: 1), () {
                  setState(() {
                    isLoading = false;
                  });
                });
              } else {
                // Payment not successful
                showSnackBar(context, 'Payment not successful');
              }
            },
          ),
        );

  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    animationController!.forward();
    return AnimatedBuilder(animation: animationController!, builder: (context, child){
    return Scaffold(
      appBar: customappBar(
        title: 'Add funds',
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
                    child:Text('Enter Amount(e.g 1000)',style: globalvariable.lgtext1,))),
                FadeTransition(
                  opacity: animation2 as dynamic,
                  child: Transform(
                    transform: Matrix4.translationValues(delayedAnimation!.value * 40, 0, 0),
                    child:CustomTextField(controller: _emailController , hintText: '',keyboard: TextInputType.number ))),
                SizedBox(height: 5.h,),
                FadeTransition(
                  opacity: animation1 as dynamic,
                  child: Transform(
                    transform: Matrix4.translationValues(0, muchDelayAnimation!.value * 40, 0),
                    child: Container(

                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black12,),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Payment Method',style: globalvariable.lgtext3,),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Image.asset('assets/Group5.png'),
                          SizedBox(width: 5.w,),
                          Text('****1234'),
                        ],

                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Image.asset('assets/Group6.png'),
                          SizedBox(width: 5.w,),
                          Text('Pay with Bank'),
                        ],

                      ),
                    ],
                  ),
                )))



              ],
            ),
          ),
             isLoading
             ?  Center(child: CircularProgressIndicator()):CustomButton(text: 'Add funds', onTap: (){
            addfund();
          }),
        ],
      ),
    );});
  }
}
