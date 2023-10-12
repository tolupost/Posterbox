import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/common/widgets/appbar.dart';
import 'package:posterbox/common/widgets/dropdownMenu.dart';
import 'package:posterbox/sendPackage/screens/sendPackagescreen2.dart';

import '../../auth/screens/verification.dart';
import '../../common/widgets/button.dart';
import '../../common/widgets/textfield.dart';
import 'package:posterbox/utils/globalvariable.dart';

class sendPackagescreen1 extends StatefulWidget {

  const sendPackagescreen1({Key? key, }) : super(key: key);

  @override
  State<sendPackagescreen1> createState() => _sendPackagescreen1State();
}

class _sendPackagescreen1State extends State<sendPackagescreen1>  with TickerProviderStateMixin{
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
  }
  String childString = '';

  String dropdownvalue = 'Abuja';

// List of items in our dropdown menu
  var items = [
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




  @override
  Widget build(BuildContext context) {
    animationController!.forward();
    return AnimatedBuilder(animation: animationController!, builder: (context, child){

      return Scaffold(
      appBar: const customappBar(
        title: 'Senders Details',
      ),
      body: Column(
        children: [
      FadeTransition(
      opacity: animation3 as dynamic,
      child: Transform(
      transform: Matrix4.translationValues(animation!.value * 40, 0, 0),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: globalvariable.primarycolor
                ),
                child: const Center(child: Text('1',style: TextStyle(color: Colors.white))),
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
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.black,)
                ),

              ),
            ],
          ))),
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
                 Text('Where are you Sending from?',style: globalvariable.lgtext,),
                     SizedBox(height: 15.h,),
                     Text('Full Name',style: globalvariable.lgtext1),
                    CustomTextField(controller: _nameController , hintText: ''),
                     SizedBox(height: 5.h,),
                     Text('Mobile Number',style: globalvariable.lgtext1,),
                    CustomTextField(controller: _phoneController , hintText: '',keyboard: TextInputType.number),
                     SizedBox(height: 5.h,),
                     Text('House Address',style: globalvariable.lgtext1,),
                    CustomTextField(controller: _emailController , hintText: ''),
                     SizedBox(height: 5.h,),
                     Text('State',style: globalvariable.lgtext1,),
                  ],
                ))),
                 SizedBox(height: 5.h,),
                FadeTransition(
      opacity: animation1 as dynamic,
      child: Transform(
      transform: Matrix4.translationValues(0, muchDelayAnimation!.value * 40, 0),
      child: Row(
                  children: [

                    Container(
                      padding: const EdgeInsets.all(9),
                      width: 170.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.black,width: 0.5.w)
                      ),
                      child: Center(
                        child: DropdownButton(
                          elevation: 0,
                          underline: Container(
                            decoration: BoxDecoration(

                                border: Border.all(color: Colors.white,width: 0.5.w)
                            ),
                          ),
                          isDense: true,
                          isExpanded: true,

                          style:globalvariable.lgtext4 ,
                          // Initial Value
                          value: dropdownvalue,
                          hint: const Text('Country'),
                          alignment: Alignment.center,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items:items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                 SizedBox(width: 30.w,),


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
      child: CustomButton(text: 'Continue', onTap: () {

            Navigator.push(context,  MaterialPageRoute(
            builder: (context) =>   sendPackagescreen2(senderaddress: _emailController.text,
              sendername: '${ _nameController.text}.${dropdownvalue}',
              sendernumber: _phoneController.text, state1: dropdownvalue,),
          ));}))),
        ],
      ),
    );});
  }
}
