import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/common/widgets/button.dart';
import 'package:posterbox/home/screens/home.dart';
import 'package:posterbox/utils/globalvariable.dart';

import '../services/deliveryServices.dart';

class successPage extends StatefulWidget {
  final String id,state1,state2;
  final int start,end;
  const successPage({Key? key, required this.id, required this.state1, required this.state2, required this.start, required this.end}) : super(key: key);

  @override
  State<successPage> createState() => _successPageState();
}

class _successPageState extends State<successPage> {
  final DeliveryServices deliveryServices = DeliveryServices();
  void findDeliver() {
    deliveryServices.findDeliver(
      context: context,
      id: widget.id,
      state1: widget.state1,
      state2: widget.state2,
      start: widget.start,
      end: widget.end,

    );


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 150.0),
            child: Column(
              children: [
                Container(
                  height: 100.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Icon(Icons.check,size: 100,color:Colors.white,),
                ),
                SizedBox(height:4,),
                Text('Sucessful!',style: globalvariable.lgtext7,),
                SizedBox(height:4,),
                Text('The payment made was sucessfull',style: globalvariable.lgtext5,),

              ],
            ),
          ),
          CustomButton(text: 'Back to Home', onTap: (){
            findDeliver();

          })
        ],
      ),
    );
  }
}
