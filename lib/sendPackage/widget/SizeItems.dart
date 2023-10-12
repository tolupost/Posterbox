import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/utils/globalvariable.dart';

class sizeItems extends StatelessWidget {
  final String size;
  final String weight;
  final double height;
  final double width;
  final Color shadow;
  const sizeItems({Key? key, required this.size, required this.weight, required this.height, required this.width, required this.shadow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10),

      shadowColor: shadow,
      child: Container(
        height: 141.h,
        width: 114.w,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: shadow,width: 3)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          SizedBox(
            height: height,
              width: width,
              child: Image.asset('assets/Group.png')),
        SizedBox(height:5.h,),
          Text(size,style: globalvariable.lgtext3,),
          SizedBox(height: 5.h,),
          Text(weight)
        ],),
      ),
    );
  }
}
