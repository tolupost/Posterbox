import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/utils/globalvariable.dart';

class GridViewitems extends StatelessWidget {
  final String image;
  final String title;
  final String desc;
  const GridViewitems({Key? key, required this.image, required this.title, required this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 20.h,
      width: 171.w,
      decoration: BoxDecoration(
          color: Color(0xffE5E5E5),
        borderRadius: BorderRadius.circular(7)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h,),
          SizedBox(child: Image.asset(image)),
          SizedBox(height: 10.h,),
          Text(title,style: globalvariable.lgtext3),
            SizedBox(height: 10.h,),
            Text(desc,style:  globalvariable.lgtext4,),
        ],),
      ),
      ),
    );
  }
}
