import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/utils/globalvariable.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color = globalvariable.primarycolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 5.h),
      child: ElevatedButton(

        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          side: BorderSide(
              color:globalvariable.primarycolor,width: 1,
              style: BorderStyle.solid
          ),
          minimumSize:  Size(double.infinity, 50.h),
          backgroundColor: color,

         maximumSize:  Size(double.infinity, 50.h),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.h,
            color: color == globalvariable.primarycolor ? Colors.white : globalvariable.primarycolor,
          ),
        ),
      ),
    );
  }
}