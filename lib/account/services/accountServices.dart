import 'dart:convert';
import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:posterbox/account/screens/accountScreen.dart';
import 'package:posterbox/auth/screens/splashpage.dart';
import 'package:posterbox/common/widgets/bottomBar.dart';
import 'package:posterbox/models/kyc.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Providers/user-providers.dart';
import '../../models/user.dart';
import '../../utils/errorHandling.dart';
import '../../utils/globalvariable.dart';
import '../../utils/utils.dart';
import '../screens/CardScreen.dart';
import '../screens/WalletScreen.dart';



class AccountServices {

 editUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      String? deviceId = '';
      OneSignal.shared.getDeviceState().then((value) => {
        value!.userId = deviceId,
        print(deviceId),
      });
      User user = User(
        id: userProvider.user.id,
        name: name,
        password: password,
        email: email,
        address: '',
        phone: '',
        token: '', card: [],
        kyc: [], wallet: 0,
        schedule: [], notification: [], image: '', verified: '', ongoing: '', deliveriesDone: 0, device: deviceId,

      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/editprofile'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

 addCard({
    required BuildContext context,
    required String cardholdername,
    required String cardnumber,
    required String expiry,
    required String cvv,

  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-card'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          "cardholdername":cardholdername,
          "cardnumber":cardnumber,
          "expiry":expiry,
          "cvv":cvv,
          "_id":userProvider.user.id
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {

          print(userProvider.user.card);
          User user =
          userProvider.user.copyWith(card: jsonDecode(res.body)['card'] );
          userProvider.setUserFromModel(user);
          print(res.body);
          Navigator.push(context,  MaterialPageRoute(
            builder: (context) =>  const CardScreen(),
          ));
        },
      );
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }
 Kyc({
    required BuildContext context,
    required String name,
    required String dateofbirth,
    required String residence,
   required File profilepic,
    required String type,
   required String number,
    required File image,

  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {


      final cloudinary = CloudinaryPublic('dmksweuu5', 'w0yle4jd');
      String imageUrl = '';


      CloudinaryResponse res1 = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(profilepic.path, folder: userProvider.user.name),
      );
      imageUrl = res1.secureUrl;
      String imageUrls = '';


        CloudinaryResponse res2 = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image.path, folder: name),
        );
        imageUrls = res2.secureUrl;

      http.Response res = await http.post(
        Uri.parse('$uri/api/kyc'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          "name":name,
          "dateofbirth":dateofbirth,
          "residence":residence,
          "type":type,
          "profilepic":imageUrl,
          "image":imageUrls,
          "number":number,
          "userId":userProvider.user.id
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user =
          userProvider.user.copyWith(kyc: jsonDecode(res.body)['kyc'] );
          userProvider.setUserFromModel(user);
          Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(
            builder: (context) =>  const BottomBar(),
          ),(route) => false);
        },
      );
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }
  void profilepic({
    required BuildContext context,
    required File image,

  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final cloudinary = CloudinaryPublic('dmksweuu5', 'w0yle4jd');
      String imageUrls = '';


      CloudinaryResponse res1 = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path, folder: userProvider.user.name),
      );
      imageUrls = res1.secureUrl;

      http.Response res = await http.post(
        Uri.parse('$uri/api/profilepic'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          "image":imageUrls,
          "userId":userProvider.user.id
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {


          User user =
          userProvider.user.copyWith(image: jsonDecode(res.body)['image'] );
          userProvider.setUserFromModel(user);


        },
      );
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }

   addFund({
    required BuildContext context,

    required int amount,


  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-fund'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },

        body: jsonEncode({
          "amount":amount,
          "name":userProvider.user.name,
          "userId":userProvider.user.id
        }),
      );
      print(userProvider.user.name);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {


          User user =
          userProvider.user.copyWith(wallet: jsonDecode(res.body)['wallet'] );
          userProvider.setUserFromModel(user);
          Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(
              builder: (context) =>  const AccountScreen()), (Route<dynamic> route) => false,);

        },
      );
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }
   withdraw({
    required BuildContext context,
    required String account,
    required int amount,
    required String name,



  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/withdraw'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          "amount":amount,
          "account":account,
          "userId":userProvider.user.id,
          "name":name,
          "username":userProvider.user.name
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {

          print(res.body);
          User user =
          userProvider.user.copyWith(wallet: jsonDecode(res.body)['wallet'] );
          userProvider.setUserFromModel(user);
          Navigator.push(context,  MaterialPageRoute(
              builder: (context) =>  const WalletScreen()));

        },
      );
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }


  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
        context,
        splashpage.routeName,
            (route) => false,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}