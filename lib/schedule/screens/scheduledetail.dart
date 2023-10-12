import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/common/widgets/appbar.dart';

import '../../common/widgets/button.dart';
import 'package:posterbox/utils/globalvariable.dart';

import '../../home/screens/TrackingDetails.dart';

class ScheduleDetails extends StatefulWidget {
  final String  senderaddress,deliveryfee,sendername,sendernumber,recevieraddress,receviername,receviernumber,deliverytimeline,deliveryinstructions,deliveryweight,deliverydate,progress,id,username,number;
  
  const ScheduleDetails({Key? key, required this.senderaddress, required this.deliveryfee, required this.sendername, required this.sendernumber, required this.recevieraddress, required this.receviername, required this.receviernumber, required this.deliverytimeline, required this.deliveryinstructions, required this.deliveryweight, required this.deliverydate, required this.progress, required this.id, required this.username, required this.number}) : super(key: key);

  @override
  State<ScheduleDetails> createState() => _ScheduleDetailsState();
}

class _ScheduleDetailsState extends State<ScheduleDetails> with TickerProviderStateMixin{
  Animation ? animation, delayedAnimation,muchDelayAnimation,animation1,animation2,animation3;
  AnimationController ? animationController;

  @override
  void initState() {

    super.initState();
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

  }  @override
  Widget build(BuildContext context) {
    animationController!.forward();
    return AnimatedBuilder(animation: animationController!, builder: (context, child){

      return Scaffold(
      appBar: const customappBar(
        title: 'detail',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      FadeTransition(
      opacity: animation3 as dynamic,
      child: Transform(
      transform: Matrix4.translationValues(animation!.value * 40, 0, 0),
      child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(widget.progress,style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14,color: Colors.blue),),
               SizedBox(height: 25.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Text('Tracking ID',style: globalvariable.lgtext6,),
                    Text(widget.id,style: globalvariable.lgtext4,)
                  ],
                ),
                SizedBox(height: 15.h,),
                Container(
                  height: 55.h,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black12,),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text('From:',style: globalvariable.lgtext6,),
                      Column(

                        crossAxisAlignment: CrossAxisAlignment.end,
                        children:  [
                          Text(widget.sendername,style: globalvariable.lgtext1,),
                          SizedBox(height: 2.h,),
                          Text(widget.senderaddress,style: globalvariable.lgtext4,)
                        ],
                      )
                    ],
                  ),
                ),

                Container(
                  height: 55.h,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black12,),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text('To:',style: globalvariable.lgtext6,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children:  [
                          Text(widget.receviername,style: globalvariable.lgtext1,),
                          SizedBox(height: 2.h,),
                          Text(widget.recevieraddress,style: globalvariable.lgtext4,)
                        ],
                      )
                    ],
                  ),
                ),
            ],
          ))),

      FadeTransition(
      opacity: animation2 as dynamic,
      child: Transform(
      transform: Matrix4.translationValues(delayedAnimation!.value * 40, 0, 0),
      child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  height: 55.h,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black12,),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text('Timeline:',style: globalvariable.lgtext6,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children:  [
                          Text('${widget.deliverytimeline} days',style: globalvariable.lgtext1,),
                          SizedBox(height: 2.h,),
                          Text(widget.deliverydate,style: globalvariable.lgtext4,)
                        ],
                      )
                    ],
                  ),
                ),

                Container(
                  height: 55.h,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black12,),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text('Weight:',style: globalvariable.lgtext6,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children:  [
                          Text('0.1-1kg',style: globalvariable.lgtext1,),
                          SizedBox(height: 2.h,),
                          Text(widget.deliveryweight,style: globalvariable.lgtext4,)
                        ],
                      )
                    ],
                  ),
                ),

                Container(
                  height: 55.h,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black12,),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text('Instructions:',style: globalvariable.lgtext6,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children:  [
                          Text(widget.deliveryinstructions,style: globalvariable.lgtext1,),
                          SizedBox(height: 2.h,),
                          Text('optional',style: globalvariable.lgtext4,)
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ))),

      FadeTransition(
      opacity: animation1 as dynamic,
      child: Transform(
      transform: Matrix4.translationValues(0, muchDelayAnimation!.value * 40, 0),
      child:Column(crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  height: 55.h,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black12,),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text('Fee:',style: globalvariable.lgtext6,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children:  [
                          Text(widget.deliveryfee,style: globalvariable.lgtext1,),
                          SizedBox(height: 2.h,),
                          Text('0.1-1.0kg.',style: globalvariable.lgtext4,)
                        ],
                      )
                    ],
                  ),
                ),

                Container(
                  height: 55.h,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black12,),
                    ),
                  ),
                  child:           Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text('Mode of Payment:',style: globalvariable.lgtext6,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children:  [
                          Text('Card',style: globalvariable.lgtext1,),
                          SizedBox(height: 2.h,),
                          Text('Cerdit/Debit',style: globalvariable.lgtext4,),
                        ],
                      )
                    ],
                  ),),
                Container(
                  height: 90,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.black12,),
                    ),
                  ),
                  child:           Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text('Agent:',style: globalvariable.lgtext6,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                         Container(
                           height:37.h,
                           width: 37.w,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(37)
                           ),
                           child: Image.asset('assets/pic.png'),
                         ),
                         SizedBox(height: 2.h,),
                          Text(widget.username,style: globalvariable.lgtext1,),
                        SizedBox(height: 2.h,),
                           Text(widget.number,style: globalvariable.lgtext4,),
                        ],
                      )
                    ],
                  ),),

            SizedBox(height: 2.h,),

          CustomButton(text: 'Track', onTap: (){
          Navigator.push(context,  MaterialPageRoute(
                  builder: (context) =>   TrackingDetails(
                    recevieraddress: widget.recevieraddress,
                    receviername: widget.receviername,
                    senderaddress: widget.senderaddress,
                    deliveryfee: widget.deliveryfee,
                    sendername: widget.sendername,
                    sendernumber: widget.sendername,
                    receviernumber: widget.receviernumber,
                    deliverytimeline: widget.deliverytimeline,
                    deliveryinstructions: widget.deliveryinstructions,
                    deliveryweight: widget.deliveryweight,
                    deliverydate: widget.deliverydate,
                    progress: widget.progress,
                    id: widget.id,
                    username: widget.username,
                    number: widget.number,),
                ));
          }),
              ],
            )))

          ],
        ),
      ),
    );});
  }
}
