import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/common/widgets/appbar.dart';
import 'package:posterbox/common/widgets/button.dart';
import 'package:posterbox/home/services/homeService.dart';


class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  final TextEditingController _emailController = TextEditingController();
  final HomeServices homeservices = HomeServices();
  bool isLoading = false;

  void trackid(){
    setState(() {
      isLoading = true;
    });
    homeservices.trackid(context: context, id: _emailController.text, ).then((value) => setState(() {
      isLoading = false;
    }));
    Timer(Duration(minutes: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappBar(
        title: 'Track Delivery',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h,),
                Padding(
                  padding: const EdgeInsets.only( right: 15.0),
                  child: Hero(
                    tag: 'mytext',
                    child: TextFormField(
                         controller: _emailController,
                        decoration:  InputDecoration(

                            suffixIcon: IconButton(
                              color:
                              Colors.grey,
                              icon: const Icon(Icons.search),
                              onPressed: trackid, ),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black38,
                                )),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black38,
                                )),

                            contentPadding:
                            const EdgeInsets.only(left: 15.0, top: 15.0),
                            hintText: 'Enter Tracking Number',
                            hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Quicksand'))),
                  ),
                ),
              SizedBox(height: 29.h,),
              Text('Input The tracking number of your delivery.')
            ],),
            isLoading
                ?Center(child: CircularProgressIndicator()):CustomButton(text: 'Track',
              onTap: trackid)
          ],
        ),
      ),
    );
  }
}
