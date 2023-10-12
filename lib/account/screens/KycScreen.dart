import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/account/screens/accountScreen.dart';
import 'package:posterbox/account/services/accountServices.dart';
import 'package:posterbox/common/widgets/textfield.dart';
import 'package:posterbox/utils/globalvariable.dart';
import 'package:provider/provider.dart';
import '../../Providers/user-providers.dart';
import '../../common/widgets/appbar.dart';
import '../../common/widgets/button.dart';
import '../../utils/utils.dart';
import 'package:permission_handler/permission_handler.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({Key? key}) : super(key: key);

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen>  with TickerProviderStateMixin{
  Animation ? animation, delayedAnimation,muchDelayAnimation,animation1,animation2,animation3;
  AnimationController ? animationController;

  @override
  void initState() {

    super.initState();
    requestPermission();
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
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _resController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final AccountServices accountServices = AccountServices();
  File images = File('');
  File image = File('');
  bool isLoading = false;
  void kyc () {
           setState(() {
      isLoading = true;
    });
    accountServices.Kyc(context: context,
        name: _emailController.text,
        dateofbirth: _dobController.text,
        residence: dropdownvalues,
        type: dropdownvalue1,
       image: images, number: _numberController.text,
        profilepic: image).then((value) => setState(() {
      isLoading = false;
    }));
     Timer(Duration(minutes: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }
  String dropdownvalues = 'Select State';
  var items = [
    'Select State',
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
  String dropdownvalue1 = 'Select ID type';
  var items1 = [
    'Select ID type',
    'Driving license',
    'Passport',
    'NIC',
    'Voter Card',
    'Others',
  ];

  void selectImages() async {
    requestPermission();
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }
  void selectImage() async {
    requestPermission();
    var res = await pickImages();
    setState(() {
      image = res;
    });
  }
  void profilepic(){
    accountServices.profilepic(context: context, image: image);
  }
  Future<void> requestPermission() async {
    PermissionStatus status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request();
    }
  }





  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _resController.dispose();
    _typeController.dispose();
    _numberController.dispose();

  }
  @override
  Widget build(BuildContext context) {
    animationController!.forward();
    return AnimatedBuilder(animation: animationController!, builder: (context, child){

      return Scaffold(
      appBar: const customappBar(
        title: 'KYC Verification',
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 8,
            ),
          FadeTransition(
          opacity: animation3 as dynamic,
          child: Transform(
          transform: Matrix4.translationValues(animation!.value * 40, 0, 0),
          child:
            image.isAbsolute?
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              foregroundImage: FileImage(image,),

            )
            :
            InkWell(
              onTap: selectImage,
              child: Stack(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),

                    ),
                    child: Image.asset('assets/pic.png',fit: BoxFit.fill,),
                  ),
                  Positioned(
                    bottom: 3,
                    right: 3,
                    child: Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: Center(child: Icon(Icons.add))  ,
                    ),
                  )
                ]
              ),
            ))),
         FadeTransition(

          opacity: animation2 as dynamic, child: Transform(

          transform: Matrix4.translationValues(delayedAnimation!.value * 40, 0, 0),

           child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 13),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text('Full Name on ID',style: globalvariable.lgtext1,),
                  CustomTextField(controller: _emailController , hintText: ''),
                   SizedBox(height: 5.h,),
                  Text('Date of Birth',style: globalvariable.lgtext1,),
                  CustomTextField(controller: _dobController , hintText: '',keyboard: TextInputType.datetime),
                   SizedBox(height: 5.h,),
                  Text('State of Residence',style: globalvariable.lgtext1,),
                  SizedBox(height: 5.h,),
                  Container(
                    padding: const EdgeInsets.all(9),
                    width: 360.w,
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
                        value: dropdownvalues,
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
                            dropdownvalues = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                   SizedBox(height: 20.h,),
                  Text('ID Type',style: globalvariable.lgtext1,),
                  SizedBox(height: 5.h,),
                  Container(
                    padding: const EdgeInsets.all(9),
                    width: 360.w,
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
                        value: dropdownvalue1,
                        hint: const Text('Country'),
                        alignment: Alignment.center,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items:items1.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue1 = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                   SizedBox(height: 5.h,),
                  Text('ID Number',style: globalvariable.lgtext1,),
                  CustomTextField(controller: _numberController , hintText: '',),
                   SizedBox(height: 5.h,),

                  Text('Image of ID',style: globalvariable.lgtext1,),
                  images.isAbsolute ?
                  Image.file(
                    images,
                    fit: BoxFit.cover,
                    height: 200.h,
                  )
                  :InkWell(
                    onTap: selectImages,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        height: 200.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.black38)
                        ),
                        child: Center(
                          child: Container(
                            height: 30,
                            width: 30.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color.fromARGB(255, 217, 217, 217)
                            ),
                            child: const Icon(Icons.add,color: Colors.black,size: 20,),
                          ),
                        ),
                      ),
                    ),
                  ),
               SizedBox(height: 5.h,),



                ],
              ),
            ))),
      FadeTransition(
      opacity: animation1 as dynamic,
      child: Transform(
      transform: Matrix4.translationValues(0, muchDelayAnimation!.value * 40, 0),
      child: isLoading
                    ?Center(child: CircularProgressIndicator()):CustomButton(text: 'Verify', onTap: (){
              kyc();
              profilepic();
            }))),
          ],
        ),
      ),
    );});
  }
}
