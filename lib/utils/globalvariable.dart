
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


// String uri = 'https://posterbox-backend-cyiq.onrender.com';
//String uri = 'http://192.168.43.158:3000';

 String uri = 'https://posterbox.onrender.com';
String backendUrl = 'https://posterbox.onrender.com';
// Set this to a public key that matches the secret key you supplied while creating the heroku instance
String paystackPublicKey = 'pk_live_d254ce078eef15fa96134776d06a11b54dd4b0fa';

class globalvariable{
  static const primarycolor = Color.fromARGB(255,245, 134, 52);
  static const backgroundcolor = Color.fromARGB(255,254, 254, 254);
  static const backgroundcard = Color.fromARGB(255, 144, 37, 37);

  static  TextStyle lgtext= TextStyle(fontFamily: 'Inter',fontWeight: FontWeight.w500, fontSize: 18.sp,);
  static TextStyle lgtext1= TextStyle(fontFamily: 'Inter',fontWeight: FontWeight.w400, fontSize: 14.sp, textBaseline: TextBaseline.alphabetic,);
  static TextStyle lgtext2= TextStyle(fontFamily: 'Inter',fontWeight: FontWeight.w600, fontSize: 17.sp, fontStyle: FontStyle.italic,color: Colors.white);
  static TextStyle lgtext3= TextStyle(fontFamily: 'Inter',fontWeight: FontWeight.w500, fontSize: 14.sp,);
  static TextStyle lgtext4= TextStyle(fontFamily: 'Inter',fontWeight: FontWeight.w400, fontSize: 12.sp,color: Color.fromARGB(255, 120, 120, 120));
  static TextStyle lgtext5= TextStyle(fontFamily: 'Inter',fontWeight: FontWeight.w500, fontSize: 14.sp,color: Color.fromARGB(255, 120, 120, 120));
  static TextStyle lgtext6= TextStyle(fontFamily: 'Inter',fontWeight: FontWeight.w400, fontSize: 12.sp,);
  static TextStyle lgtext7= TextStyle(fontFamily: 'Inter',fontWeight: FontWeight.w600, fontSize: 20.sp,);
  static TextStyle lgtext8= TextStyle(fontFamily: 'Inter',fontWeight: FontWeight.w500, fontSize: 10.sp,color: Colors.black12);
  static TextStyle lgtext9= TextStyle(fontFamily: 'Inter',fontWeight: FontWeight.w500, fontSize: 14.sp,color: Colors.red,);
}
