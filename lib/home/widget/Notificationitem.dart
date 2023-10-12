import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/utils/globalvariable.dart';

class Notificationitems extends StatelessWidget {
  final String day;
  final String address;
  final String sender;
  final VoidCallback onTap;
  final VoidCallback onTap1;
  const Notificationitems({Key? key, required this.day, required this.address, required this.sender, required this.onTap, required this.onTap1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
      child: Material(
        borderRadius: BorderRadius.circular(9),
        elevation: 3,
        child: Container(
          height:124.h,
          width: 361.w,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(

          ),
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Image.asset('assets/noti.png'),
                      SizedBox(width: 5.w,),
                      Text('Request for Delivery',style: globalvariable.lgtext3,),
                    ],),
                    Text('Within:${day} days',style: globalvariable.lgtext4,),
                  ],
                ),
                SizedBox(height: 13.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('To_ ${address}',style: globalvariable.lgtext4,),
                        SizedBox(height: 5.h,),
                        Text('By: ${sender}',style: globalvariable.lgtext4,),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: globalvariable.backgroundcolor,
                            borderRadius:   BorderRadius.circular(35),
                            border: Border.all(color: globalvariable.primarycolor)
                          ),
                          child: InkWell(onTap: onTap1,child: Icon(Icons.close,color: globalvariable.primarycolor,)),
                        ),
                        SizedBox(width: 10.w,),
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              color: globalvariable.backgroundcolor,
                              borderRadius:   BorderRadius.circular(35.h),
                              border: Border.all(color: globalvariable.primarycolor)
                          ),
                          child: InkWell(
                              onTap: onTap,
                              child: Icon(Icons.check,color: globalvariable.primarycolor,)),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
