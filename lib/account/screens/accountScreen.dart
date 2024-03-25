import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/account/screens/CardScreen.dart';
import 'package:posterbox/account/screens/KycScreen.dart';
import 'package:posterbox/utils/globalvariable.dart';
import 'package:provider/provider.dart';

import '../../Providers/user-providers.dart';
import '../../utils/utils.dart';
import '../services/accountServices.dart';
import 'EditProfile.dart';
import 'WalletScreen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> with SingleTickerProviderStateMixin{
  final AccountServices accountServices = AccountServices();
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


  File images = File('');
  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }
  void profilepic(){
    accountServices.profilepic(context: context, image: images);
  }
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    animationController!.forward();
    return AnimatedBuilder(
        animation: animationController!,
        builder: (context, child) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: globalvariable.primarycolor,
        title: const Text('Account'),
         leading: IconButton(onPressed: () {  }, icon: const Icon(Icons.confirmation_num_sharp,color:globalvariable.primarycolor ),
      ),
    ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               SizedBox(height: 4.h,),
          FadeTransition(
              opacity: animation3 as dynamic,
              child: Transform(
              transform: Matrix4.translationValues(animation!.value * 40, 0, 0),
                 child: Column(
                 children: [
                  user.image != ''?
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    foregroundImage: NetworkImage(user.image,),

                  )
                      :
                  Container(
                    height: 100.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),

                    ),
                    child: Image.asset('assets/pic.png',fit: BoxFit.cover,),
                  )
                  ,
                  SizedBox(height: 4.h,),
                  Text(user.name),
                   SizedBox(height: 4.h,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const WalletScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        height: 90.h,
                        width: 380.w,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                        color: globalvariable.primarycolor),
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Balance',style: TextStyle(color: Colors.white),),
                            SizedBox(height: 10.h,),
                            Text('N ${user.wallet}.00',style: const TextStyle(color: Colors.white),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ))),
            SizedBox(height: 10.h,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FadeTransition(
            opacity: animation2 as dynamic,
            child: Transform(
            transform: Matrix4.translationValues(delayedAnimation!.value * 40, 0, 0),
                child:Column(
                  children: [
                    Container(
                      height: 50.h,
                      width: 380.w,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(color: Colors.black12,width: 0.8.w)
                      ),
                      child:  Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Deliveries done'),
                          Text(user.deliveriesDone.toString()),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      height: 10.h,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                  ],
                ))),
          ),

          FadeTransition(
          opacity: animation1 as dynamic,
          child: Transform(
          transform: Matrix4.translationValues(0, muchDelayAnimation!.value * 40, 0),
          child: Column(
                children: [
                 SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfile()));
                    },
                    child: Container(
                      height: 50.h,
                      width: 380.w,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration:  BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1.w,color: Colors.black12))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Edit Account'),
                          Icon(Icons.navigate_next)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CardScreen()));
                    },
                    child: Container(
                      height: 50.h,
                      width: 380.w,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1.w,color: Colors.black12))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Card Settings'),
                          Icon(Icons.navigate_next)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const KycScreen()));
                    },
                    child: Container(
                      height: 50.h,
                      width: 380.w,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration:  BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1.w,color: Colors.black12))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Update KYC'),
                          Icon(Icons.navigate_next)
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 50.h,
                    width: 380.w,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration:  BoxDecoration(
                        border: Border(bottom: BorderSide(width: 1.w,color: Colors.black12))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Contact Support'),
                        Icon(Icons.navigate_next)
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: ()=> AccountServices().logOut(context),
                    child: Container(
                      height: 50.h,
                      width: 380.w,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1.w,color: Colors.black12))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Log Out'),
                          Icon(Icons.navigate_next,color: Colors.white,)
                        ],
                      ),
                    ),
                  ),
                ],
              )))
            ],
          ),
        ),
      ),

    );});
  }
}
