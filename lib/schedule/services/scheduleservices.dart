import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:posterbox/models/delivery.dart';
import 'package:posterbox/models/getquote.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../Providers/user-providers.dart';


import '../../models/user.dart';
import '../../utils/errorHandling.dart';
import '../../utils/globalvariable.dart';
import '../../utils/utils.dart';


class ScheduleServices {

   addSchedule({
    required BuildContext context,
    required String to,
    required String from,
    required String time,
    required int date,

  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);


    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-schedule'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'to': to,
          'from': from,
          'date': date,
          'time':time,
          '_id':userProvider.user.id
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {

          showSnackBar(context, 'Calculated succesfully');

          User user =
          userProvider.user.copyWith(schedule: jsonDecode(res.body)['schedule'] );
          userProvider.setUserFromModel(user);
          deliverSchedule(context: context, state1: from, state2: to, date: date);

        },

      );
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }

  }
  void deliverSchedule({
    required BuildContext context,
    required String state1,
    required String state2,
    required int date,

  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);


    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/get-deliver-schedule'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'state1': state1,
          'state2': state2,
          'number': date,
          'userverified':userProvider.user.verified,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {



        },

      );
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }

  }
  void removeschedule({
    required BuildContext context,
    required String scheduleId,


  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/remove-schedule'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'userId': userProvider.user.id,
          'scheduleId': scheduleId,

        }),
      );
      print(scheduleId);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          print(userProvider.user.schedule);
          print(res.body);
          User user =
          userProvider.user.copyWith(schedule: jsonDecode(res.body)['schedule'] );
          userProvider.setUserFromModel(user);

        },

      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

}