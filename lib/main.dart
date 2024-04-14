import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:posterbox/common/widgets/bottombar.dart';
import 'package:posterbox/home/screens/contact_page.dart';
import 'package:posterbox/router.dart';
import 'package:posterbox/utils/globalvariable.dart';
import 'Providers/delivery-providers.dart';
import 'Providers/user-providers.dart';
import 'auth/screens/splashpage.dart';
import 'package:provider/provider.dart';

import 'auth/service/authservice.dart';

void main() {
  //Remove this method to stop OneSignal Debugging


  runApp(MultiProvider(providers: [
      ChangeNotifierProvider(
      create: (context) => UserProvider(),
  ),
    ChangeNotifierProvider(
      create: (context) => DeliveryProvider(),
    ),
  ],
      child: const MyApp())

  );
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none,);

  OneSignal.shared.setAppId("2ad13506-a328-47d9-b9e4-36a20260eb9d");
  OneSignal.shared.getDeviceState().then((value) => {
    print(value!.userId),
  });


// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final AuthService authService = AuthService();

  @override
  void initState() {
  super.initState();
  authService.getUserData(context);
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
        builder: (context , child)  =>MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange).copyWith(background: globalvariable.backgroundcolor),
             ),
         onGenerateRoute: (settings) => generateRoute(settings),
         home:
            Provider.of<UserProvider>(context).user.token.isNotEmpty
                ? const BottomBar()
                : const splashpage(),

    ));
  }
}

