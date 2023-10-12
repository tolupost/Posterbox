import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/models/delivery.dart';
import 'package:posterbox/models/getquote.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../Providers/user-providers.dart';
import '../../common/widgets/Loader.dart';
import '../../common/widgets/button.dart';
import '../../sendPackage/screens/requestDetails.dart';
import '../../sendPackage/screens/sendPackagescreen1.dart';
import '../../utils/errorHandling.dart';
import '../../utils/globalvariable.dart';
import '../../utils/utils.dart';


class GetQuoteServices {

  Future<Getquote> GetQuote({
    required BuildContext context,
    required String state1,
    required String state2,
    required String quantity,
    required String weight,

  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Getquote getquote = Getquote(
        result: 0

    );

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/get-quote'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'weight': weight,
          'state1': state1,
          'state2': state2,
          'quantity':quantity
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          getquote = Getquote.fromJson(res.body);
          showSnackBar(context, 'Calculated succesfully');
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  const Text("Delivery Quote"),
                  IconButton( onPressed: () {    Navigator.of(ctx).pop();}, icon: Icon(Icons.close),)

                ],
              ),
              content: getquote == null
                  ? const Loader()
                  :getquote.result.toString().isEmpty
                  ? const SizedBox()
                  :Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      width:110,
                      height: 130,
                      child: Image.asset('assets/Group.png')),
                  SizedBox(height: 15.h,),
                  Container(
                    height: 160,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1,color: Colors.black12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(

                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('From:',style: globalvariable.lgtext1,),
                              Text(state1,style: globalvariable.lgtext3,),
                            ],
                          ),
                          SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('To:',style: globalvariable.lgtext1,),
                              Text(state2,style: globalvariable.lgtext3,),
                            ],
                          ),
                          SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Quantity:',style: globalvariable.lgtext1,),
                              Text(quantity,style: globalvariable.lgtext3,),
                            ],
                          ),
                          SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Weight:',style: globalvariable.lgtext1,),
                              Text(weight,style: globalvariable.lgtext3,),
                            ],
                          ),
                          SizedBox(height: 15.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Cost:',style: globalvariable.lgtext,),
                              Text(getquote.result.toString(),style: globalvariable.lgtext,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25,),
                  CustomButton(text: 'Request Delivery', onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => sendPackagescreen1())) ;
                  })
                ],
              ),

            ),
          );
        },

      );
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
    return getquote;
  }

  Future<Getquote> GetQuotes({
    required BuildContext context,
    required String state1,
    required String state2,
    required String quantity,
    required String weight,
    required String senderaddress,
    required String sendername,
    required String sendernumber,
    required String recevieraddress,
    required String receviername,
    required String receviernumber,
    required String deliverytimeline,
    required String deliveryinstructions,
    required String deliveryweight ,
    required String deliverydate,
    required int start,
    required int end,

  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Getquote getquote = Getquote(
        result: 0

    );

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/get-quote'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'weight': weight,
          'state1': state1,
          'state2': state2,
          'quantity':quantity
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          getquote = Getquote.fromJson(res.body);
          showSnackBar(context, 'Calculated succesfully');
          Navigator.push(context,  MaterialPageRoute(
              builder: (context) =>   RequestDetails(

            senderaddress: senderaddress,
               sendername: sendername,
             sendernumber: sendernumber,
            recevieraddress: recevieraddress,
               receviername: receviername,
             receviernumber: receviernumber,
            deliverytimeline: deliverytimeline,
            deliveryinstructions: deliveryinstructions,
                  deliveryweight: deliveryweight ,
                    deliverydate: deliverydate,
                           start: start,
                             end: end,
            deliveryfee: getquote.result.toString(),
            state1: state1,
            state2: state2,

          ),
          ));

        },

      );
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
    return getquote;
  }

}