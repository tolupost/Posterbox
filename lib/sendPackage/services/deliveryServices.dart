import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:posterbox/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../Providers/user-providers.dart';

import '../../common/widgets/bottomBar.dart';
import '../../models/delivery.dart';
import '../../models/user.dart';
import '../../utils/errorHandling.dart';
import '../../utils/globalvariable.dart';
import '../screens/successPage.dart';

class DeliveryServices{
   requestDelivery({
    required BuildContext context,
    required String deliveryfee,
    required String deliveryinstructions,
    required String deliveryweight,
    required String deliverytimeline,
    required String recevieraddress,
    required String receviername,
    required String receviernumber,
    required String sendername,
    required String sendernumber,
    required String senderaddress,
    required String progress,
    required String usernumber,
    required String deliverydate,
    required String state1,
    required String state2,
    required int start,
    required int end,
    required bool wallet,



  }) async{
 final userProvider = Provider.of<UserProvider>(context, listen: false);


       Delivery  delivery =  Delivery(
        deliveryfee: deliveryfee,
        deliveryinstructions: deliveryinstructions,
        deliverytimeline: deliverytimeline,
        deliveryweight: deliveryweight,
        progress: progress,
        recevieraddress: recevieraddress,
        receviername: receviername,
        senderaddress: senderaddress,
        sendername: sendername,
        usernumber: usernumber,
         username: '',
         receviernumber: receviernumber,
         sendernumber: sendernumber,
         deliverydate: deliverydate, state1: state1,
         state2: state2, start: start,
         end: end, wallet: wallet,
         senderusername: '', deliverId: '', userId: '',

      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/add-delivery'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },

        body: jsonEncode({
          'start': start,
          'end':end,
          'state1': state1,
          'state2':state2,
          'deliveryfee': deliveryfee,
          'deliveryinstructions': deliveryinstructions,
          'deliverytimeline': deliverytimeline,
          'deliveryweight': deliveryweight,
          'progress': progress,
          'recevieraddress': recevieraddress,
          'receviername': receviername,
          'senderaddress': senderaddress,
          'sendername': sendername,
          'usernumber': usernumber,
          'wallet': wallet,
          'username': '',
          'receviernumber': receviernumber,
          'sendernumber': sendernumber,
          'deliverydate': deliverydate,
          'userId': userProvider.user.id,
          'senderusername':userProvider.user.name
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {

          delivery = Delivery.fromJson(res.body);
          int fee = int.parse(deliveryfee);
          int newBalance = userProvider.user.wallet - fee;
          User newUser = User(
            id: userProvider.user.id,
            name: userProvider.user.name,
            email: userProvider.user.email,
            password: userProvider.user.password,
            token: userProvider.user.token,
            wallet: newBalance,
            address: userProvider.user.address,
            phone: userProvider.user.phone,
            verified: userProvider.user.phone,
            ongoing: userProvider.user.ongoing,
            card: userProvider.user.card,
            kyc: userProvider.user.kyc,
            deliveriesDone: userProvider.user.deliveriesDone,
            image: userProvider.user.image,
            schedule: userProvider.user.schedule,
            notification: userProvider.user.notification, device: userProvider.user.device,
          );

          // Update the userProvider with the new User instance
          userProvider.setUserFromModel(newUser);
          showSnackBar(context, 'Delivery request created Successfully!');
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              successPage(
                id: delivery.id!,
                state1: state1,
                state2: state2,
                start: start,
                end: end, )));
        },
      );

 try{

 } catch (e) {
  showSnackBar(context, e.toString());
 }
  }

  void findDeliver({
    required BuildContext context,
    required String id,
    required int start,
    required int end,
    required String state1,
    required String state2,


  }) async{
    final userProvider = Provider.of<UserProvider>(context, listen: false);


    http.Response res = await http.post(
      Uri.parse('$uri/api/find-deliver'),
    body: jsonEncode({
    'id': id,
     'start': start,
      'end':end,
      'state1': state1,
      'state2':state2,
    }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      },

    );

    httpErrorHandle(
      response: res,
      context: context,
      onSuccess: () {
        print(userProvider.user.id);
        Navigator.push(context, MaterialPageRoute(builder: (context) => BottomBar()));
      },
    );

    try{

    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }


}