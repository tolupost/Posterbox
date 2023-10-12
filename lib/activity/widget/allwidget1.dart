import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/utils/globalvariable.dart';

class AllWidget1 extends StatelessWidget {
  const AllWidget1({
    Key? key,
    required this.progress,
    required this.delivered,
    required this.cancelled,
    required this.notbyme,
    required this.byme,
    required this.sender,
    required this.receiver,
    required this.address,
    required this.username,
    required this.date,
  }) : super(key: key);

  final bool progress;
  final bool delivered;
  final bool cancelled;
  final bool notbyme;
  final bool byme;
  final String sender;
  final String receiver;
  final String address;
  final String username;
  final String date;

  @override
  Widget build(BuildContext context) {

    return   Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
        child: notbyme? Material(
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(15),
        width: 361.w,
        height: 122.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),

        ),
        child: Column(
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if(progress)
                          Image.asset('assets/deliver2.png'),
                        if(delivered)
                          Image.asset('assets/deliver3.png'),
                        if(cancelled)
                          Image.asset('assets/deliver1.png'),
                        SizedBox(width: 3.w,),
                        Text('Delivery to ${receiver}',style: globalvariable.lgtext3,),
                      ],
                    ),
                    if(progress)
                      Text('IN- PROGRESS',style: globalvariable.lgtext8,),
                    if(delivered)
                      Text('DELIVERED',style: globalvariable.lgtext8,),
                    if(cancelled)
                      Text('CANCELLED',style: globalvariable.lgtext8,),

                  ],
                ),

                SizedBox(height: 15.h,),
                Text.rich(
                    TextSpan(
                        text: 'Address-.',
                        style: TextStyle(fontFamily: 'Inter',fontWeight: FontWeight.w500, fontSize: 12,),
                        children: <InlineSpan>[
                          TextSpan(
                            text: address,
                            style: globalvariable.lgtext4,
                          )
                        ]
                    )
                ),
                SizedBox(height: 13.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Text('BY ${username}',style: TextStyle(fontFamily: 'Inter',fontWeight: FontWeight.w500, fontSize: 12,),),
                    Text(date,style:globalvariable.lgtext4),
                  ],
                ),
              ],
            ),

          ],
        ),
      ),
    ): SizedBox()
    );
  }
}