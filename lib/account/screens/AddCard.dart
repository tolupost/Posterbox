import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/account/services/accountServices.dart';
import 'package:posterbox/common/widgets/appbar.dart';
import '../../common/widgets/button.dart';
import '../../common/widgets/textfield.dart';
import 'package:posterbox/utils/globalvariable.dart';

class AddCard extends StatefulWidget {
  const AddCard({Key? key}) : super(key: key);

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> with TickerProviderStateMixin{
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  // Initial Selected Value
  String dropdownvalue = 'Item 1';
  final AccountServices accountService = AccountServices();
  bool isLoading = false;



  void addcard(){
            setState(() {
      isLoading = true;
    });
    accountService.addCard(context: context,
        cardholdername: _nameController.text,
        cardnumber: _numberController.text,
        expiry: _expiryController.text,
        cvv: _cvvController.text).then((value) => setState(() {
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
    _nameController.dispose();
    _numberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    animationController!.forward();
    return AnimatedBuilder(animation: animationController!, builder: (context, child){

      return Scaffold(
      appBar: customappBar(
        title: 'Receivers Details',
      ),
      body:Column(
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
                    child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Card Holder Name',style: globalvariable.lgtext1),
                    CustomTextField(controller: _nameController , hintText: ''),
                    SizedBox(height: 5.h,),
                    Text('Card Number',style: globalvariable.lgtext1,),
                    CustomTextField(controller: _numberController , hintText: ''),
                  ],
                ))),
                SizedBox(height: 5.h,),
                FadeTransition(
                  opacity: animation2 as dynamic,
                  child: Transform(
                    transform: Matrix4.translationValues(delayedAnimation!.value * 40, 0, 0),
                    child:Row(
                  children: [
                    Text('State',style: globalvariable.lgtext1,),
                    SizedBox(width: 170.w,),
                    Text('City/LGA',style: globalvariable.lgtext1,),
                  ],
                ))),
              SizedBox(height: 5.h,),
                FadeTransition(
                  opacity: animation1 as dynamic,
                  child: Transform(
                    transform: Matrix4.translationValues(0, muchDelayAnimation!.value * 40, 0),
                    child:Row(
                  children: [

                    SizedBox( width: 150.w,child: CustomTextField(controller: _expiryController , hintText: 'MM/YYYY')),
                    SizedBox(width: 30.w,),

                    SizedBox(width: 150.w,child: CustomTextField(controller: _cvvController , hintText: '')),
                    SizedBox(height: 20.h,),
                  ],
                ),))



              ],
            ),
          ),
          isLoading
              ?Center(child: CircularProgressIndicator()):CustomButton(text: 'Add card', onTap: () {
            addcard();
           }),
        ],
      ),
    );});
  }
}
