
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/common/widgets/appbar.dart';
import 'package:posterbox/common/widgets/dropdownMenu.dart';
import 'package:posterbox/sendPackage/screens/requestDetails.dart';
import 'package:posterbox/sendPackage/widget/SizeItems.dart';
import 'package:intl/intl.dart';
import '../../GetQuote/services/getquoteservices.dart';
import '../../auth/screens/verification.dart';
import '../../common/widgets/button.dart';
import '../../common/widgets/textfield.dart';
import 'package:posterbox/utils/globalvariable.dart';

import '../../models/getquote.dart';

class sendPackagescreen3 extends StatefulWidget {

  final String  senderaddress,sendername,sendernumber,recevieraddress,receviername,receviernumber,state1,state2;
  const sendPackagescreen3({Key? key,
    required this.senderaddress,
    required this.sendername,
    required this.sendernumber,
    required this.recevieraddress,
    required this.receviername,
    required this.receviernumber, required this.state1, required this.state2}) : super(key: key);

  @override
  State<sendPackagescreen3> createState() => _sendPackagescreen3State();
}

class _sendPackagescreen3State extends State<sendPackagescreen3> with TickerProviderStateMixin{
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
  final TextEditingController _emController = TextEditingController();
  bool isLoading = false;
  Getquote? getquote;

  final GetQuoteServices getQuoteService = GetQuoteServices();

  void GetQuote() {
    setState(() {
      isLoading = true;
    });
    getQuoteService.GetQuotes(
      context: context,
      state1: widget.state1,
      state2: widget.state2,
      quantity: _emailController.text,
      weight: weight.toString(),
      senderaddress: widget.senderaddress,
      sendername: widget.sendername,
      sendernumber: widget.sendernumber,
      recevieraddress: widget.recevieraddress,
      receviername: widget.receviername,
      receviernumber: widget.receviernumber,
      deliverytimeline: _dateTime1.difference(_dateTime).inDays.toString(),
      deliveryinstructions: _emailController.text,
      deliveryweight: childString,
      deliverydate: '${_dateTime.day.toString()}-${_dateTime1.day.toString()}/${_dateTime1.month.toString()}/${_dateTime1.year.toString()}',
      start: dateToDays(_dateTime.year,_dateTime.month, _dateTime.day),
      end: dateToDays(_dateTime1.year,_dateTime1.month, _dateTime1.day),



    ).then((value) => setState(() {
      isLoading = false;
    }));
  }

  DateTime _dateTime = DateTime.now();
  DateTime _dateTime1 = DateTime.now();

  int dateToDays(int year,int month, int day) {
    DateTime date = DateTime.utc(year, month, day);
    DateTime startOfYear = DateTime.utc(2020, 1, 1);
    return date.difference(startOfYear).inDays + 1;
  }

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
  void _showDatePicker1(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),

    ).then((value) {
      setState(() {
        _dateTime1 = value!;
      });
    });
  }


  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _emController.dispose();
  }
  String childString = 'Large';
  int weight = 3;
  bool Large = true;
  bool Medium = false;
  bool Small = false;

  @override
  Widget build(BuildContext context) {
    animationController!.forward();
    return AnimatedBuilder(animation: animationController!, builder: (context, child){

      return Scaffold(
      appBar: customappBar(
        title: 'Package Details',
      ),
      body: ListView(
        children: [


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.black,)
                ),

              ),


              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  width: 24.w,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration:  BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black,width: 1.5.w),
                    ),
                  ),
                ),
              ),
              Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.black,)
                ),

              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  width: 20.w,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration:  BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black,width: 1.5.w),
                    ),
                  ),
                ),
              ),
              Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: globalvariable.primarycolor
                ),
                child: const Center(child: Text('3',style: TextStyle(color: Colors.white),)),
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 13),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
      FadeTransition(
      opacity: animation2 as dynamic,
      child: Transform(
      transform: Matrix4.translationValues(delayedAnimation!.value * 40, 0, 0),
      child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text('What are you sending?',style: globalvariable.lgtext),
                    SizedBox(height: 15.h,),
                    Text('Quantity',style: globalvariable.lgtext1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox( width:250,
                            child: CustomTextField(controller: _emController , hintText: 'Choose Quantity',keyboard: TextInputType.number)),
                        SizedBox(width: 10,),
                        InkWell(
                          onTap: () {
                            int currentValue = int.tryParse(_emController.text) ?? 0;
                            if (  int.parse(_emController.text) > 0){
                              _emController.text = (currentValue - 1).toString();
                            }
                          },
                          child: Container(
                            width: 50,
                            height: 50.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(color: Colors.black,width: 1)
                            ),
                            child: const Icon(
                              Icons.remove,
                              size: 40,
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        InkWell(
                          onTap: () {
                            int currentValue = int.tryParse(_emController.text) ?? 0;
                            _emController.text = (currentValue + 1).toString();
                          },
                          child: Container(
                            width: 50,
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
                  ],
                ))),
      FadeTransition(
      opacity: animation3 as dynamic,
      child: Transform(
      transform: Matrix4.translationValues(animation!.value * 40, 0, 0),
      child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    SizedBox(height: 5.h,),
                    Text('Parcel weight',style: globalvariable.lgtext1,),
                    SizedBox(height: 5.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                      InkWell( onTap:(){
                        setState(() {
                          childString = "Small";
                          Large = false;
                          Medium = false;
                          Small = true;
                          weight= 1;

                        });
                           } ,
                          child: sizeItems(size: 'Small', weight: '0.1 - 1.0kg', height: 10, width: 10, shadow: Small ? globalvariable.primarycolor : Colors.white,)),
                      InkWell(onTap:(){
                        setState(() {
                          childString = "Medium";
                          Large = false;
                          Medium = true;
                          Small = false;
                          weight= 2;
                        });
                      },child: sizeItems(size: 'Medium', weight: '1.0 - 4.0kg', height: 20.h, width: 20, shadow: Medium ? globalvariable.primarycolor : Colors.white,)),
                      InkWell(onTap:(){
                        setState(() {
                          childString = "Large";
                          Large = true;
                          Medium = false;
                          Small = false;
                          weight= 3;
                        });
                        },child: sizeItems(size: 'Large', weight: '4.0 - 10kg', height: 30, width: 30.w, shadow: Large ? globalvariable.primarycolor : Colors.white,)),
                    ],),
                    SizedBox(height: 15.h,),
                    Text('Instructions (optional)',style: globalvariable.lgtext1,),
                    CustomTextField(controller: _emailController , hintText: ''),
                    SizedBox(height: 5.h,),
                  ],
                ))),

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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Delivery Timeline',style: globalvariable.lgtext1,),
                      SizedBox(height: 15.h,),
                      Row(

                        children: [
                          Text('From:',style: globalvariable.lgtext1,),
                          SizedBox(width: 157,),
                          Text('To:',style: globalvariable.lgtext1,),


                        ],
                      ),
                      SizedBox(height:  10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         ElevatedButton(
                             style: ElevatedButton.styleFrom(
                                 foregroundColor: globalvariable.backgroundcolor,
                               backgroundColor: globalvariable.backgroundcolor,
                               elevation: 0,
                               side: BorderSide(color: Colors.black38,width: 0.5)
                             ),
                             onPressed:
                               _showDatePicker,

                             child:  Container(

                                 width: 100,

                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text('${_dateTime.day.toString()}/${_dateTime.month.toString()}/${_dateTime.year.toString()}',style: TextStyle(color: Colors.black38,fontWeight: FontWeight.w400,fontSize: 14,fontFamily: 'inter'),),
                                     Icon(Icons.arrow_drop_down_rounded,color: Colors.black38,)
                                   ],
                                 ))),


                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: globalvariable.backgroundcolor,
                                  backgroundColor: globalvariable.backgroundcolor,
                                  elevation: 0,
                                  side: BorderSide(color: Colors.black38,width: 0.5)
                              ),
                              onPressed:
                                _showDatePicker1,
                              child: Container(

                                  width: 100,

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${_dateTime1.day.toString()}/${_dateTime1.month.toString()}/${_dateTime1.year.toString()}',style: TextStyle(color: Colors.black38,fontWeight: FontWeight.w400,fontSize: 14,fontFamily: 'inter'),),
                                      Icon(Icons.arrow_drop_down_rounded,color: Colors.black38,)
                                    ],
                                  ))),
                          SizedBox(height: 20.h,),

                        ],
                      ),
                    ],
                  ),
                ))),



              ],
            ),
          ),
          
           isLoading
                    ?Center(child: CircularProgressIndicator()):CustomButton(text: 'Continue', onTap: (){
            GetQuote();

           }),
        ],
      ),
    );});
  }
}
