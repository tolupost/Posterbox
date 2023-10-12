import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:posterbox/models/delivery.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../Providers/delivery-providers.dart';
import '../../Providers/user-providers.dart';
import '../../common/widgets/bottomBar.dart';
import '../../models/user.dart';
import '../../utils/errorHandling.dart';
import '../../utils/globalvariable.dart';
import '../../utils/utils.dart';
import '../screens/TrackingDetails.dart';


class HomeServices {
  Future<List<Delivery>> fetchCategoryProducts({
    required BuildContext context,
    required String id,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Delivery> deliveryList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/delivery?searchTerm=$id'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });


      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {

          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            deliveryList.add(
              Delivery.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }

        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return deliveryList;
  }
  Future<List<Delivery>> getusernotification({
    required BuildContext context,

  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Delivery> deliveryList = [];
    try {
      http.Response res = await http
          .post(Uri.parse('$uri/api/get-user-notification/deliveries'),

        headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      },

          body: jsonEncode({
          'userId': userProvider.user.id,
          }),
      );
      print(userProvider.user.id);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          print(res.body);
          print(userProvider.user.notification);
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            deliveryList.add(
              Delivery.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return deliveryList;
  }
   changeDeliveryStatus({
    required BuildContext context,
    required String username,
    required String usernumber,
    required String progress,
    required Delivery delivery,
    required String notificationId,
    required String ongoing,

  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);


    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/accept-delivery'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          '_id': delivery.id,
          'userId':delivery.userId,
          'username': username,
          'usernumber': usernumber,
          'progress':progress,
          'deliverId':userProvider.user.id,
          'notificationId':  notificationId,
          'ongoing': ongoing,
        }),

      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          print(res.body);
          Provider.of<DeliveryProvider>(context, listen: false).setDelivery(res.body);

          showSnackBar(context, 'Delivery request created Accepted!');
          Navigator.push(context, MaterialPageRoute(builder: (context) => BottomBar()));


        },

      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
  Future<Delivery> trackid({
    required BuildContext context,
    required String id,



  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Delivery delivery = Delivery(
      state1: '',
      username: '',
      deliverydate: '',
      deliveryfee: '',
      deliveryinstructions: '',
      state2: '',
      deliveryweight: '',
      deliverytimeline: '',
      recevieraddress: '',
      receviername: '',
      receviernumber: '',
      sendername: '',
      sendernumber: '',
      senderaddress: '',
      progress: '',
      usernumber: '', start: 0, end: 0, wallet: false, senderusername: '', deliverId: '', userId: '',


    );
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/track-delivery'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          '_id': id,


        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          delivery = Delivery.fromJson(res.body);
          Navigator.push(context,  MaterialPageRoute(
            builder: (context) =>   TrackingDetails(
              recevieraddress: delivery.recevieraddress,
              receviername: delivery.receviername,
              senderaddress: delivery.senderaddress,
              deliveryfee: delivery.deliveryfee,
              sendername: delivery.sendername,
              sendernumber: delivery.sendername,
              receviernumber: delivery.receviernumber,
              deliverytimeline: delivery.deliverytimeline,
              deliveryinstructions: delivery.deliveryinstructions,
              deliveryweight: delivery.deliveryweight,
              deliverydate: delivery.deliverydate,
              progress: delivery.progress,
              id: id,
              username: delivery.username,
              number: delivery.usernumber,
            ),
          ));
        },

      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return delivery;
  }
  Future<Delivery> trackhomeid({
    required BuildContext context,




  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Delivery delivery = Delivery(
    state1: '',
      username: '',
      deliverydate: '',
      deliveryfee: '',
      deliveryinstructions: '',
      state2: '',
      deliveryweight: '',
      deliverytimeline: '',
      recevieraddress: '',
      receviername: '',
      receviernumber: '',
      sendername: '',
      sendernumber: '',
      senderaddress: '',
      progress: '',
      usernumber: '',
      start: 0,
      end: 0,
      wallet: false, senderusername: '', deliverId: '', userId: '',


    );
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/track-delivery'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': userProvider.user.ongoing,


        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {

          delivery = Delivery.fromJson(res.body);
          Provider.of<DeliveryProvider>(context, listen: false).setDelivery(res.body);

        },

      );
    } catch (e) {
      // showSnackBar(context, e.toString());
    }
    return delivery;
  }
  void ongoing({
    required BuildContext context,
    required String ongoing,


  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {


      http.Response res = await http.post(
        Uri.parse('$uri/api/ongoing'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          "ongoing":ongoing,
          "userId":userProvider.user.id
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {


          User user =
          userProvider.user.copyWith(ongoing: jsonDecode(res.body)['ongoing'] );
          userProvider.setUserFromModel(user);

         print(user.ongoing);
        },
      );
    } catch (e) {

      showSnackBar(context, e.toString());
    }
  }
 removenotification({
  required BuildContext context,
  required String notificationId,
}) async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);

  try {
    http.Response res = await http.delete(
      Uri.parse('$uri/api/remove-notification'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      },
      body: jsonEncode({
        'userId': userProvider.user.id,
        'notificationId': notificationId,
      }),
    );

    httpErrorHandle(
      response: res,
      context: context,
      onSuccess: () {
        Navigator.pop(context);
        showSnackBar(context, 'Delivery request deleted Accepted!');
      },

    );
  } catch (e) {
    showSnackBar(context, e.toString());
  }
}
  void progresses({
    required BuildContext context,
    required String progress,

  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final deliveryProvider = Provider.of<DeliveryProvider>(context, listen: false);

    print(progress);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/change-order-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': deliveryProvider.delivery.id,
          'progress': progress,
          'userId':userProvider.user.id
        }),
      );
      print(deliveryProvider.delivery.state1);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {

           Provider.of<DeliveryProvider>(context, listen: false).setDelivery(res.body);

        },

      );
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }
}
