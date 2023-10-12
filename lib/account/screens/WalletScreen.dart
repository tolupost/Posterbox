import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/account/screens/AddFunds.dart';
import 'package:posterbox/account/screens/Withdraw.dart';
import 'package:posterbox/utils/globalvariable.dart';
import 'package:provider/provider.dart';

import '../../Providers/user-providers.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> with TickerProviderStateMixin{
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

  }
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet' ),
        centerTitle: true,
        backgroundColor: globalvariable.primarycolor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        bottom: PreferredSize (
          preferredSize: Size.fromHeight(120.0),
          child:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80.0),
            child: Center(
              child: Column(

                children: [
              Text('Balance',style: TextStyle(fontFamily: 'Inter',fontWeight: FontWeight.w500,fontSize: 12,color: Colors.white),),
                  SizedBox(height: 4.h,),
              Text('N${user.wallet}.00',style: TextStyle(fontFamily: 'Inter',fontWeight: FontWeight.w700,fontSize: 20,color: Colors.white),),

              Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: SizedBox(
                      width: 220.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: (){
                                 Navigator.push(context,  MaterialPageRoute(
                                  builder: (context) =>  const Addfund(),
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(100, 157, 174, 189),
                              ),
                              child: Text('Add Funds')),
                          ElevatedButton(
                              onPressed: (){
                               Navigator.push(context,  MaterialPageRoute(
                                  builder: (context) =>  const Withdraw(),
                                ));
                              },

                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(100, 157, 174, 189),

                              ),
                              child: Text('Withdraw')),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      )

    );
  }
}
