import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/models/delivery.dart';
import 'package:posterbox/utils/globalvariable.dart';
import 'package:provider/provider.dart';

import '../../Providers/delivery-providers.dart';
import '../../sendPackage/services/deliveryServices.dart';

class TrackingDetails extends StatefulWidget {
  final String  senderaddress,
      deliveryfee,
      sendername,
      sendernumber,
      recevieraddress,
      receviername,
      receviernumber,
      deliverytimeline,
      deliveryinstructions,
      deliveryweight,
      deliverydate,
      progress,id,username,number;

  const TrackingDetails({Key? key,
    required this.senderaddress,
    required this.deliveryfee,
    required this.sendername,
    required this.sendernumber,
    required this.recevieraddress,
    required this.receviername,
    required this.receviernumber,
    required this.deliverytimeline,
    required this.deliveryinstructions,
    required this.deliveryweight,
    required this.deliverydate,

    required this.progress,

    required this.id,

    required this.username,

    required this.number, }) : super(key: key);

  @override
  State<TrackingDetails> createState() => _TrackingDetailsState();
}

class _TrackingDetailsState extends State<TrackingDetails> {
  final DeliveryServices deliveryServices = DeliveryServices();
  int currentStep = 0;
  bool set = false;
  bool set1 = false;
  bool set2 = false;

  @override
  Widget build(BuildContext context) {
  if(widget.progress == 'IN- PROGRESS'){
    setState(() {
      set = true;
    });
  }
  if(widget.progress == 'Accepted package'){
    setState(() {
      set = false;
      set1 = true;
    });
  }
  if(widget.progress == 'DELIVERED'){
    setState(() {
      set1 = false;
      set2 = true;
    });
  }

    return Scaffold(

    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            SizedBox(),
            Text('Tracking Details',style: globalvariable.lgtext3),
            InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.close))
          ],),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.black12,),

              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tracking No',style: globalvariable.lgtext4),
                SizedBox(height: 6.h,),
                Text(widget.id,style: globalvariable.lgtext3),
                SizedBox(height: 11.h,),
                Text('Delivery  Timeline',style: globalvariable.lgtext5),
              ],
            ),
          ),
           SizedBox(height: 10.h),


          Column(
            children: [
              Row(
                children:<Widget> [
                  Text(widget.deliverydate,style: globalvariable.lgtext4),
                  SizedBox(width: 23.w,),
                  Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                      color:set ? Colors.white:globalvariable.primarycolor,
                    border: Border.all(width: 1,color: globalvariable.primarycolor)
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Text('The Package has been picked up',style: globalvariable.lgtext1)
                ],
              ),
              Row(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 15.w,),
                  Text('01:20pm',style: globalvariable.lgtext3),
                  SizedBox(width: 29.w,),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border(left: BorderSide(color: Color.fromARGB(255, 71, 167, 255),  width: 5),
                    ),
                  )),
                  SizedBox(width: 18,),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(30)
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Text('Picked up by',style: globalvariable.lgtext6),
                            SizedBox(height: 5,),
                            Text(widget.username,style: globalvariable.lgtext4),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children:<Widget> [

                  SizedBox(width: 90.w,),
                  Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: set1 ? Colors.white:globalvariable.primarycolor,
                        border: Border.all(width: 1,color: globalvariable.primarycolor)
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Text('The Package is on the way to ${widget.recevieraddress}')
                ],
              ),
              Row(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  SizedBox(width: 100.w,),
                  Container(
                      height: 100.h,
                      decoration: BoxDecoration(
                        border: Border(left: BorderSide(color: Color.fromARGB(255, 71, 167, 255),  width: 5),
                        ),
                      )),
                  SizedBox(width: 20.w,),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('In Transit'),
                  ),
                ],
              ),
              Row(
                children:<Widget> [
                  Text('10.Aug.2022'),
                  SizedBox(width: 20,),
                  Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: set2 ? Colors.white:globalvariable.primarycolor,
                        border: Border.all(width: 1.w,color: globalvariable.primarycolor)
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Text('The Package has been picked up')
                ],
              ),
              Row(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 15.w,),
                  Text('01:20pm'),

                  SizedBox(width: 58.w),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Text(widget.recevieraddress),
                  ),
                ],
              ),
            ],
          ),

        ],),
      ),
    ),
    );
  }
}
