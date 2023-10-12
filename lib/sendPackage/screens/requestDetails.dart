import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/common/widgets/appbar.dart';
import 'package:posterbox/common/widgets/button.dart';
import 'package:posterbox/utils/globalvariable.dart';

import '../../common/widgets/paystack.dart';
import '../../utils/utils.dart';
import '../services/deliveryServices.dart';


class RequestDetails extends StatefulWidget {
  final String  state1,state2,senderaddress,deliveryfee,sendername,sendernumber,recevieraddress,receviername,receviernumber,deliverytimeline,deliveryinstructions,deliveryweight,deliverydate;
  final int start,end;
  const RequestDetails({Key? key, required this.senderaddress, required this.sendername, required this.sendernumber, required this.recevieraddress, required this.receviername, required this.receviernumber, required this.deliverytimeline, required this.deliveryinstructions, required this.deliveryweight, required this.deliverydate, required this.start, required this.end, required this.deliveryfee, required this.state1, required this.state2}) : super(key: key);

  @override
  State<RequestDetails> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails>with TickerProviderStateMixin{
  Animation ? animation, delayedAnimation,muchDelayAnimation,animation1,animation2,animation3;
  AnimationController ? animationController;

  @override
  void initState() {

    super.initState();

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

  }
  bool isLoading = false;
  bool value = false;
  bool value1 = false;
  bool wallet = false;
  final DeliveryServices deliveryServices = DeliveryServices();

  void requestDelivery() {
    setState(() {
      isLoading = true;
    });

    if (value || value1) {
      if (value1) {
        // Show AlertDialog
        showDialog(
          context: context,
          builder: (context) => paystack(
            fee: widget.deliveryfee,
            callback: (bool success) {
              setState(() {
                isLoading = false;
              });
              if (success) {
                // Payment successful
                // Continue with the code execution
                deliveryServices.requestDelivery(
                  context: context,
                  deliveryfee: widget.deliveryfee,
                  deliveryinstructions: widget.deliveryinstructions,
                  deliveryweight: widget.deliveryweight,
                  deliverytimeline: widget.deliverytimeline,
                  recevieraddress: widget.recevieraddress,
                  receviername: widget.receviername,
                  receviernumber: widget.receviernumber,
                  sendername: widget.sendername,
                  sendernumber: widget.sendernumber,
                  senderaddress: widget.senderaddress,
                  progress: '',
                  usernumber: '',
                  deliverydate: widget.deliverydate,
                  state1: widget.state1,
                  state2: widget.state2,
                  start: widget.start,
                  end: widget.end,
                  wallet: wallet,
                ).then((value) => setState(() {
                  isLoading = false;
                }));
                Timer(Duration(minutes: 1), () {
                  setState(() {
                    isLoading = false;
                  });
                });
              } else {
                // Payment not successful
                showSnackBar(context, 'Payment not successful');
              }
            },
          ),
        );
      } else {
        deliveryServices.requestDelivery(
          context: context,
          deliveryfee: widget.deliveryfee,
          deliveryinstructions: widget.deliveryinstructions,
          deliveryweight: widget.deliveryweight,
          deliverytimeline: widget.deliverytimeline,
          recevieraddress: widget.recevieraddress,
          receviername: widget.receviername,
          receviernumber: widget.receviernumber,
          sendername: widget.sendername,
          sendernumber: widget.sendernumber,
          senderaddress: widget.senderaddress,
          progress: '',
          usernumber: '',
          deliverydate: widget.deliverydate,
          state1: widget.state1,
          state2: widget.state2,
          start: widget.start,
          end: widget.end,
          wallet: wallet,
        ).then((value) => setState(() {
          isLoading = false;
        }));
      }
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, 'Pick either wallet or card');
    }
  }



  @override
  Widget build(BuildContext context) {
    animationController!.forward();
    return AnimatedBuilder(animation: animationController!, builder: (context, child){

      return Scaffold(
      appBar: customappBar(
        title: 'Request Details',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: globalvariable.backgroundcolor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            children: [
      FadeTransition(
      opacity: animation3 as dynamic,
      child: Transform(
      transform: Matrix4.translationValues(animation!.value * 40, 0, 0),
      child: Column(
                children: [
                  Image.asset('assets/Group.png'),
                  SizedBox(height: 4.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('From:',style: globalvariable.lgtext6,),
                      Column(

                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(widget.sendername,style: globalvariable.lgtext1,),
                          SizedBox(height: 2.h,),
                          Text(widget.senderaddress,style: globalvariable.lgtext4,)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 15.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('To:',style: globalvariable.lgtext6,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(widget.receviername,style: globalvariable.lgtext1,),
                          SizedBox(height: 2.h,),
                          Text(widget.recevieraddress,style: globalvariable.lgtext4,)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 15.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Timeline:',style: globalvariable.lgtext6,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(widget.deliverytimeline,style: globalvariable.lgtext1,),
                          SizedBox(height: 2.h,),
                          Text(widget.deliverydate,style: globalvariable.lgtext4,)
                        ],
                      )
                    ],
                  ),
                ],
              ))),
      FadeTransition(
      opacity: animation2 as dynamic,
      child: Transform(
      transform: Matrix4.translationValues(delayedAnimation!.value * 40, 0, 0),
      child:Column(
                children: [
                  SizedBox(height: 15.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Weight:',style: globalvariable.lgtext6,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('0.1-1kg',style: globalvariable.lgtext1,),
                          SizedBox(height: 2.h,),
                          Text(widget.deliveryweight,style: globalvariable.lgtext4,)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 15.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Instructions:',style: globalvariable.lgtext6,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if(widget.deliveryinstructions == '')
                          Text('None',style: globalvariable.lgtext1,),
                          if(widget.deliveryinstructions != '')
                            Text(widget.deliveryinstructions,style: globalvariable.lgtext1,),

                          SizedBox(height: 2.h,),
                          Text('optional',style: globalvariable.lgtext4,)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 15.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Fee:',style: globalvariable.lgtext6,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(widget.deliveryfee,style: globalvariable.lgtext1,),
                          SizedBox(height: 2.h,),
                          Text('${widget.deliveryweight}',style: globalvariable.lgtext4,)
                        ],
                      )
                    ],
                  ),
                ],
              ))),
             FadeTransition(
                opacity: animation1 as dynamic,
               child: Transform(
                  transform: Matrix4.translationValues(0, muchDelayAnimation!.value * 40, 0),
                   child:
               Column(
                children: [
                  SizedBox(height: 2.h,),
                  Container(
                    height: 50.h,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.black12,),
                      ),
                    ),
                    child:   Text('Payment option'),),

                    SizedBox(height: 2.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(    value: this.value1,
                          onChanged: (bool ? value1) {
                            setState(() {
                              this.value1 = value1!;
                            });
                          },),
                        Text('Card'),
                        Checkbox(value: this.value,
                          onChanged: (bool ? value) {
                            setState(() {
                              this.value = value!;
                                if (this.value) {
                                  wallet = true;
                                } else {
                                  wallet = false;
                                }
                            });
                          },),
                        Text('Wallet'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      SizedBox(
                        height:48.h,
                          width: 140.w,
                          child: CustomButton(text: 'Cancel', onTap: (){
                            Navigator.pop(context);
                          },color: Colors.white,)),
                      SizedBox(
                          height:48.h,
                          width: 140.w,
                          child:  isLoading
                                   ?  Center(child: CircularProgressIndicator()) : CustomButton(text: 'Proceed', onTap:
                            requestDelivery
                            ))
                    ],),
                ],
              ))),

            ],
          ),
        ),
      ),
    );});
  }
}
