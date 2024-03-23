import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/common/widgets/appbar.dart';
import 'package:posterbox/common/widgets/button.dart';
import 'package:posterbox/common/widgets/textfield.dart';
import 'package:posterbox/utils/globalvariable.dart';

import '../../common/widgets/dropdownMenu.dart';
import '../../sendPackage/widget/SizeItems.dart';
import '../services/scheduleservices.dart';

class Delivery extends StatefulWidget {
  const Delivery({Key? key}) : super(key: key);

  @override
  State<Delivery> createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> with TickerProviderStateMixin{
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
  TextEditingController _toController = TextEditingController();
  TextEditingController _fromController = TextEditingController();
  final ScheduleServices scheduleService = ScheduleServices();
  bool isLoading = false;
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

  DateTime _dateTime = DateTime.now();

  // Initial Selected Value
  void _showDatePicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),

    ).then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }
  int dateToDays(int year,int month, int day) {
    DateTime date = DateTime.utc(year, month, day);
    DateTime startOfYear = DateTime.utc(2020, 1, 1);
    return date.difference(startOfYear).inDays + 1;
  }
  bool _hasFocus = false;

  void addSchedule() {
    setState(() {
      isLoading = true;
    });
    scheduleService.addSchedule(
      context: context,
      to: _toController.text,
      from: _fromController.text,
      time: '${_dateTime.day.toString()}/${_dateTime.month.toString()}/${_dateTime.year.toString()}',
      date: dateToDays(_dateTime.year,_dateTime.month, _dateTime.day),



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
    _toController.dispose();
    _fromController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    animationController!.forward();
    return AnimatedBuilder(animation: animationController!, builder: (context, child){
      return Scaffold(
      appBar: customappBar(
        title: 'Do Delivery',
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

          FadeTransition(
          opacity: animation3 as dynamic,
          child: Transform(
            transform: Matrix4.translationValues(animation!.value * 40, 0, 0),
            child:Column(        crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Scheduled day to do delivery?',style: globalvariable.lgtext,),

                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(width: 4.w,),
                        Container(
                          height: 10,
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
                              _fromController.text = selection;
                            });
                          },
                          fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                            _fromController = textEditingController;
                            return
                              SizedBox(
                                  width:300.w,
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
                                          controller: _fromController,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(top: 10.h, left: 10.w),
                                            hintText: _hasFocus ? '' : 'Travelling from',
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
                    SizedBox(height: 5.h,),
                    Row(
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
                              _toController.text = selection;
                            });
                          },
                          fieldViewBuilder: (BuildContext context, TextEditingController textEditingController, FocusNode focusNode, VoidCallback onFieldSubmitted) {
                            _toController = textEditingController;
                            return
                              SizedBox(
                                  width:300.w,
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
                                          controller: _toController,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(top: 10.h, left: 10.w),
                                            hintText: _hasFocus ? '' : 'Travelling to',
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
                    SizedBox(height: 15.h,),
                    Text('Select Date of Depature',style: globalvariable.lgtext1),
                    SizedBox(height: 10,),
                    Text('Date',style: globalvariable.lgtext1),
                    SizedBox(height: 10,),

                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            foregroundColor: globalvariable.backgroundcolor,
                            backgroundColor: globalvariable.backgroundcolor,
                            elevation: 0,
                            side: BorderSide(color: Colors.black38,width: 0.5.w)
                        ),
                        onPressed:
                        _showDatePicker,

                        child:  Container(

                            width: 150.w,
                            height: 60.h,

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${_dateTime.day.toString()}/${_dateTime.month.toString()}/${_dateTime.year.toString()}',style: TextStyle(color: Colors.black38,fontWeight: FontWeight.w400,fontSize: 18,fontFamily: 'inter'),),
                                Icon(Icons.arrow_drop_down_rounded,color: Colors.black38,)
                              ],
                            ))),
                  ],
                ))),
              ],
            ),
      FadeTransition(
      opacity: animation1 as dynamic,
      child: Transform(
      transform: Matrix4.translationValues(0, muchDelayAnimation!.value * 40, 0),
      child:isLoading
                ?Center(child: CircularProgressIndicator()):CustomButton(text: 'Confirm', onTap: (){
              addSchedule();
            })))
          ],
        ),
      ),
    );});
  }
}
