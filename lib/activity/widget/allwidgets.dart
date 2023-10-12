import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/utils/globalvariable.dart';

class AllWidgets extends StatelessWidget {
  const AllWidgets({
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
      child:  byme? Material(
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
                            Image.asset('assets/vector2.png'),
                            SizedBox(width: 3.w,),
                            Text('Delivery to ${receiver}',style: globalvariable.lgtext3,),
                          ],
                        ),


                        SizedBox()
                      ],
                    ),

                    SizedBox(height: 15.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Text.rich(
                                TextSpan(
                                    text: 'To- ',
                                    style: TextStyle(fontFamily: 'Inter',fontWeight: FontWeight.w500, fontSize: 12,),
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: receiver,
                                        style: globalvariable.lgtext4,
                                      )
                                    ]
                                )
                            ),
                            Text.rich(
                                TextSpan(
                                    text: 'From- ',
                                    style: TextStyle(fontFamily: 'Inter',fontWeight: FontWeight.w500, fontSize: 12,),
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: sender,
                                        style: globalvariable.lgtext4,
                                      )
                                    ]
                                )
                            ),

                          ],
                        ),
                        Text('27/08/2022',style:globalvariable.lgtext4),
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