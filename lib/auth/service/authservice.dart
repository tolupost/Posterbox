import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../../models/user.dart';
import '../../Providers/user-providers.dart';
import '../../common/widgets/bottomBar.dart';

import '../../models/otp.dart';
import '../../utils/errorHandling.dart';
import '../../utils/globalvariable.dart';
import '../../utils/utils.dart';
import '../screens/login.dart';
import '../screens/verification.dart';

class AuthService {
  // sign up user
  signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String phone,
    required String otp
  }) async {
    try {
      OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none,);
      OneSignal.shared.setAppId("2ad13506-a328-47d9-b9e4-36a20260eb9d");


      var value = await OneSignal.shared.getDeviceState();
      String? deviceId = value!.userId;
      print(deviceId);
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        phone: phone,
        token: '', card: [],
        kyc: [], wallet: 0,
        schedule: [], notification: [], image: '', verified: '', ongoing: '', deliveriesDone: 0, device: '',

      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: jsonEncode({
          'name':name,
          'email': email,
          'password': password,
          'phone':phone,
          'otp':otp,
          'device': deviceId
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login(),),(route) => false,);
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

  // sign in user
 signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none,);
      OneSignal.shared.setAppId("2ad13506-a328-47d9-b9e4-36a20260eb9d");


      var value = await OneSignal.shared.getDeviceState();
      String? deviceId = value!.userId;
      print(deviceId);
      OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });
      print(deviceId);
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
          'device':deviceId
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          print(res.body);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);

          Navigator.pushNamedAndRemoveUntil(
            context, BottomBar.routeName, (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
  generateOtp({
    required BuildContext context,
    required String phone,
    required String email,
    required String password,
    required String name,

  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/generate-otp'),
        body: jsonEncode({
          'phone': phone,

        }),
        headers: <String, String>{
      "Access-Control-Allow-Origin": "header", // Required for CORS support to work
      "Access-Control-Allow-Credentials": "true", // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS",
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print('you');
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          print(res.body);
          Navigator.push(context,MaterialPageRoute (builder :(context) => Verification(

            email: email,
            name: name,
            password: password,
            phone: phone, res: res.body,
          )),);
        },
      );
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }
  resendOtp({
    required BuildContext context,
    required String phone,


  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/generate-otp'),
        body: jsonEncode({
          'phone': phone,

        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print('you');
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {

        },
      );
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }
  verifyOtp({
    required BuildContext context,
    required String phone,
    required String otp,

  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/verify-otp'),
        body: jsonEncode({
          'phone': phone,
          'otp':otp,

        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
        print('love');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }


  // get user data
  void getUserData(
      BuildContext context,
      ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      print(e);
    }
  }
static var client = http.Client();

  static Future<OtpLoginResponseModel> otpLogin(String mobileNo) async{
    Map<String,String> requestHeaders = {'Content-type':'application/json'
  };

    http.Response res = await http.post(
      Uri.parse('$uri/otp'),
      body: jsonEncode(
        {
        "phone":mobileNo

    },
      ),
      headers: requestHeaders
    );
    print(res.body);
    return otploginResponseJSON(res.body);
}
  static Future<OtpLoginResponseModel> verifyOTP(
      String mobileNo,
      String otpHash,
      String otpCode
      ) async{
    Map<String,String> requestHeaders = {'Content-type':'application/json'
    };

    http.Response res = await http.post(
        Uri.parse('$uri/votp'),
        body: jsonEncode(
          {
            "phone":mobileNo,
            "otp": otpCode,
            "hash": otpHash

          },
        ),
        headers: requestHeaders
    );
    return otploginResponseJSON(res.body);
  }

}
