import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/common/widgets/appbar.dart';
import 'package:posterbox/common/widgets/button.dart';
import 'package:posterbox/common/widgets/textfield.dart';
import 'package:posterbox/models/getquote.dart';
import 'package:posterbox/utils/globalvariable.dart';


import '../../sendPackage/widget/SizeItems.dart';
import '../services/getquoteservices.dart';

class GetQuote extends StatefulWidget {
  const GetQuote({Key? key}) : super(key: key);

  @override
  State<GetQuote> createState() => _GetQuoteState();
}

class _GetQuoteState extends State<GetQuote> with TickerProviderStateMixin{
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
  Getquote? getquote;
  bool isLoading = false;
  bool _hasFocus = false;
  final List<String> options = [
    'Abia',
    'Abuja',
    'Adamawa',
    'Akwa Ibom',
    'Anambra',
    'Bauchi',
    'Bayelsa',
    'Benue',
    'Borno',
    'Cross River',
    'Delta',
    'Ebonyi',
    'Edo',
    'Ekiti',
    'Enugu',
    'Gombe',
    'Imo',
    'Jigawa',
    'Kaduna',
    'Kano',
    'Katsina',
    'Kebbi',
    'Kogi',
    'Kwara',
    'Lagos',
    'Nasarawa',
    'Niger',
    'Ogun',
    'Ondo',
    'Osun',
    'Oyo',
    'Plateau',
    'Rivers',
    'Sokoto',
    'Taraba',
    'Yobe',
    'Zamfara',
  ];
  final GetQuoteServices getQuoteService = GetQuoteServices();

  void GetQuote() {
    setState(() {
      isLoading = true;
    });
    getQuoteService.GetQuote(
      context: context,
      state1: _state1Controller.text,
      state2: _state2Controller.text,
      quantity: _emailController.text,
      weight: weight.toString(),

    ).then((value) => setState(() {
      isLoading = false;
    }));
    Timer(Duration(minutes: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  String childString = 'Large';
  String weightString = '4.0 - 10kg';
  int weight = 3;
  bool Large = true;
  bool Medium = false;
  bool Small = false;
  final TextEditingController _emailController = TextEditingController();
 TextEditingController _state1Controller = TextEditingController();
 TextEditingController _state2Controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _state1Controller.dispose();
    _state2Controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    animationController!.forward();
    return AnimatedBuilder(animation: animationController!, builder: (context, child){

      return Scaffold(
      appBar: customappBar(
        title: 'Get Quote',
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          FadeTransition(
          opacity: animation3 as dynamic,
          child: Transform(
            transform: Matrix4.translationValues(animation!.value * 40, 0, 0),
            child:Column(            crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Check Delivery Rate',style: globalvariable.lgtext,),

                    SizedBox(height: 10.h,),


                    Row(
                      children: [
                        SizedBox(width: 4.w,),
                        Container(
                          height: 10.h,
                          width: 10.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(width: 2.w,color: globalvariable.primarycolor)
                          ),
                        ),
                        SizedBox(width: 14.w,),
                        Autocomplete<String>(
                          optionsBuilder: (TextEditingValue textEditingValue) {
                            if (textEditingValue.text.isEmpty) {
                              return const Iterable<String>.empty();
                            }
                            return options.where((option) =>
                                option.toLowerCase().startsWith(textEditingValue.text.toLowerCase()));
                          },
                          onSelected: (String selection) {
                            setState(() {
                              _state1Controller.text = selection;
                            });
                          },
                          fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                            _state1Controller = textEditingController;
                            return
                              SizedBox(
                                  width:320.w,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: Container(
                                      height: 50.h,
                                      child: Focus(
                                        onFocusChange: (hasFocus) {
                                          _hasFocus = hasFocus;
                                        },
                                        child: TextField(

                                          focusNode: focusNode,
                                          controller: _state1Controller,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(top: 10.h, left: 10.w),
                                            hintText: _hasFocus ? '' : 'Sending from',
                                            hintStyle: const TextStyle(color: Colors.black12),
                                            errorBorder: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.black38,
                                              ),
                                            ),
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.black38,
                                              ),
                                            ),
                                            enabledBorder: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.black38,
                                              ),
                                            ),
                                          ),
                                          onSubmitted: (_) => onFieldSubmitted(),
                                        ),
                                      ),
                                    ),
                                  ));
                            //   TextField(
                            //   controller:_toController,
                            //   focusNode: focusNode,
                            //   decoration: InputDecoration(
                            //     labelText: 'Fruit',
                            //   ),
                            //   onSubmitted: (_) => onFieldSubmitted(),
                            // );
                          },
                          optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                elevation: 4.0,
                                child: SizedBox(
                                  height: 200.h,
                                  child: ListView(
                                    padding: EdgeInsets.all(8.0),
                                    children: options
                                        .map((option) => GestureDetector(
                                      onTap: () {
                                        onSelected(option);
                                      },
                                      child: ListTile(
                                        title: Text(option),
                                      ),
                                    ))
                                        .toList(),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),


                      ],
                    ),
                  ],
            ))),
                SizedBox(height: 5.h,),
        FadeTransition(
          opacity: animation2 as dynamic,
          child: Transform(
            transform: Matrix4.translationValues(delayedAnimation!.value * 40, 0, 0),
            child:Row(
                  children: [
                   const Icon(Icons.location_pin,color: globalvariable.primarycolor,size: 20,),
                    SizedBox(width: 10.w,),
                    Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return const Iterable<String>.empty();
                        }
                        return options.where((option) =>
                            option.toLowerCase().startsWith(textEditingValue.text.toLowerCase()));
                      },
                      onSelected: (String selection) {
                        setState(() {
                          _state2Controller.text = selection;
                        });
                      },
                      fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                        _state2Controller = textEditingController;
                        return
                          SizedBox(
                              width:320.w,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Container(
                                  height: 50.h,
                                  child: Focus(
                                    onFocusChange: (hasFocus) {
                                      _hasFocus = hasFocus;
                                    },
                                    child: TextField(

                                      focusNode: focusNode,
                                      controller: _state2Controller,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(top: 10.h, left: 10.w),
                                        hintText: _hasFocus ? '' : 'Sending To',
                                        hintStyle: const TextStyle(color: Colors.black12),
                                        errorBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black38,
                                          ),
                                        ),
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black38,
                                          ),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black38,
                                          ),
                                        ),
                                      ),
                                      onSubmitted: (_) => onFieldSubmitted(),
                                    ),
                                  ),
                                ),
                              ));
                        //   TextField(
                        //   controller:_toController,
                        //   focusNode: focusNode,
                        //   decoration: InputDecoration(
                        //     labelText: 'Fruit',
                        //   ),
                        //   onSubmitted: (_) => onFieldSubmitted(),
                        // );
                      },
                      optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4.0,
                            child: SizedBox(
                              height: 200.h,
                              child: ListView(
                                padding: EdgeInsets.all(8.0),
                                children: options
                                    .map((option) => GestureDetector(
                                  onTap: () {
                                    onSelected(option);
                                  },
                                  child: ListTile(
                                    title: Text(option),
                                  ),
                                ))
                                    .toList(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                  ],
                ))),
        FadeTransition(
             opacity: animation2 as dynamic,
          child: Transform(
            transform: Matrix4.translationValues(delayedAnimation!.value * 40, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5.h,),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Colors.black12,width: 1.w))
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('Quantity',style: globalvariable.lgtext1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox( width:230.w,
                            child: CustomTextField(controller: _emailController , hintText: 'Choose Quantity')),
                        SizedBox(width: 10.w,),
                        InkWell(
                          onTap: () {
                            int currentValue = int.tryParse(_emailController.text) ?? 0;
                            if (  int.parse(_emailController.text) > 0){
                              _emailController.text = (currentValue - 1).toString();
                            }

                          },
                          child: Container(
                            width: 50.w,
                            height: 50.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(color: Colors.black,width: 1.w)
                            ),
                            child: const Icon(
                              Icons.remove,
                              size: 40,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w,),
                        InkWell(
                          onTap: () {
                            int currentValue = int.tryParse(_emailController.text) ?? 0;
                            _emailController.text = (currentValue + 1).toString();
                          },
                          child: Container(
                            width: 50.w,
                            height: 50.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: globalvariable.primarycolor,
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text('Parcel weight',style: globalvariable.lgtext1,),
                    SizedBox(height: 5.h,),
                  ],
            ))),
        FadeTransition(
          opacity: animation1 as dynamic,
          child: Transform(
            transform: Matrix4.translationValues(0, muchDelayAnimation!.value * 40, 0),
            child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    InkWell( onTap:(){
                      setState(() {
                        childString = "Small";
                        weight= 1;
                        Large = false;
                        Medium = false;
                        Small = true;
                        weightString = '0.1 - 1.0kg';

                      });
                    } ,
                        child: sizeItems(size: 'Small', weight: '0.1 - 1.0kg', height: 10, width: 10.w,shadow: Small ? globalvariable.primarycolor : Colors.white,)),
                    InkWell(onTap:(){
                      setState(() {
                        childString = "Medium";
                        weight=2;
                        Large = false;
                        Medium = true;
                        Small = false;
                        weightString = '1.0 - 4.0kg';
                      });
                    },child: sizeItems(size: 'Medium', weight: '1.0 - 4.0kg', height: 20.h, width: 20.w,shadow: Medium ? globalvariable.primarycolor : Colors.white,)),
                    InkWell(onTap:(){
                      setState(() {
                        childString = "Large";
                        weight = 3;
                        Large = true;
                        Medium = false;
                        Small = false;
                        weightString = '4.0 - 10kg';
                      });
                    },child: sizeItems(size: 'Large', weight: '4.0 - 10kg', height: 30, width: 30.w,shadow: Large ? globalvariable.primarycolor : Colors.white,)),
                  ],))),
                SizedBox(height: 15.h,),
              ],
            ),
      FadeTransition(
      opacity: animation1 as dynamic,
      child: Transform(
      transform: Matrix4.translationValues(0, muchDelayAnimation!.value * 40, 0),
      child:isLoading
                ?Center(child: CircularProgressIndicator()):CustomButton(text: 'Get Quote', onTap: (){
              GetQuote();

            })))
          ],
        ),
      ),
    );});
  }
}
