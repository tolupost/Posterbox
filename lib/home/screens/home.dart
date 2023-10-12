import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/Providers/delivery-providers.dart';
import 'package:posterbox/Providers/user-providers.dart';
import 'package:posterbox/common/widgets/bottomBar.dart';
import 'package:posterbox/common/widgets/button.dart';
import 'package:posterbox/home/services/homeService.dart';
import 'package:posterbox/schedule/screens/Delivery.dart';
import 'package:posterbox/GetQuote/screens/GetQuote.dart';
import 'package:posterbox/home/screens/Notification.dart';
import 'package:posterbox/home/widget/GridviewItems.dart';
import 'package:posterbox/utils/globalvariable.dart';
import 'package:provider/provider.dart';
import '../../auth/service/authservice.dart';
import '../../sendPackage/screens/sendPackagescreen1.dart';
import '../../utils/errorHandling.dart';
import '../../utils/utils.dart';
import 'DeliveryScreen.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key, }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>   with SingleTickerProviderStateMixin{
  final TextEditingController _emailController = TextEditingController();
  final AuthService authService = AuthService();
  final HomeServices homeServices = HomeServices();

   Delivery ? delivery;
  Animation ? animation, delayedAnimation,muchDelayAnimation,animation1,animation2,animation3;
  AnimationController ? animationController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
    trackhomeid();
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


  void progress(){
    setState(() {
      isLoading = true;
    });
   progresse(context: context, progress: 'Accepted package').then((value) => setState(() {
     isLoading = false;
   }));

  }
  void progress1(){
    setState(() {
      isLoading = true;
    });
   progresse(context: context, progress: 'DELIVERED').then((value) => setState(() {
     isLoading = false;
   }));
  }
  void changeDeliveryStatus() {
    homeServices.ongoing(context: context, ongoing: '');
  }
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

 progresse({
    required BuildContext context,
    required String progress,

  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final deliveryProvider = Provider.of<DeliveryProvider>(context, listen: false);
    print(userProvider.user.ongoing);
    print(userProvider.user.id);
    print(progress);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/change-order-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': userProvider.user.ongoing,
          'progress': progress,
          'userId':userProvider.user.id
        }),
      );
      print(deliveryProvider.delivery.state1);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
           print(res.body);
          Provider.of<DeliveryProvider>(context, listen: false).setDelivery(res.body);
          Navigator.push(context, MaterialPageRoute(builder: (context) => BottomBar()));
        },

      );
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }
  trackhomeid() async {
    delivery = (await homeServices.trackhomeid(
      context: context,
    )) as Delivery?;
    isgoing = delivery != null;
  }
  bool isgoing = false;
  bool progresses = false;


  @override
  Widget build(BuildContext context) {
final delivery = context.watch<DeliveryProvider>().delivery;
final user = context.watch<UserProvider>().user;
final userCartLen = context.watch<UserProvider>().user.notification.length;


if(user.ongoing != ''){
  setState(() {
    isgoing = true;
  });
}
if(user.ongoing == ''){
  setState(() {
    isgoing = false;
  });
}
if(delivery.progress == 'Accepted package'){
  setState(() {
    progresses = true;
  });
}
animationController!.forward();
return AnimatedBuilder(animation: animationController!,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: globalvariable.backgroundcolor,
          body: SafeArea(
            child:             FadeTransition(
            opacity: animation3 as dynamic,
            child: Transform(
            transform: Matrix4.translationValues(animation!.value * 40, 0, 0),
              child: ListView(
                children: [
                  Container(

                    height: 150.h,
                    decoration: BoxDecoration(
                      color: globalvariable.primarycolor
                    ),
                    child: Column(

                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                            SizedBox(height: 46.h,
                                width:119.w,child: Image.asset('assets/logo.png')),
                            GestureDetector(
                                onTap: ()=> Navigator.push(context,  MaterialPageRoute(
                                  builder: (context) =>   const Notifications(),
                                )),
                                child: Stack(
                                  children: [
                                    const Icon(Icons.notifications_none_rounded,color: globalvariable.backgroundcolor,),
                                     userCartLen > 0 ?
                                    Positioned(
                                      right: 2,
                                      child: Container(
                                        height: 7.h,
                                        width: 7.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(7),
                                          color: Colors.red
                                        ),
                                      ),
                                    )
                                         : SizedBox()
                                    ,
                                  ],
                                )),
                          ], ),
                        ),
                      SizedBox(height: 40.0.h),
                      FadeTransition(
                        opacity: animation2 as dynamic,
                        child: Transform(
                          transform: Matrix4.translationValues(delayedAnimation!.value * 40, 0, 0),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(5.0),
                              child: Stack(
                                children: [

                                  TextFormField(

                                      decoration:  InputDecoration(
                                          border: InputBorder.none,
                                          suffixIcon: IconButton(
                                            color:
                                            Colors.grey,
                                            icon: const Icon(Icons.search),
                                            onPressed: (){
                                             Navigator.push(context, MaterialPageRoute(builder: (context) => const DeliveryScreen() ));
                                            }, ),
                                          contentPadding:
                                          const EdgeInsets.only(left: 15.0, top: 15.0),
                                          hintText: 'Enter Tracking Number',
                                          hintStyle: const TextStyle(
                                              color: Colors.grey,
                                              fontFamily: 'Quicksand'))),
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => DeliveryScreen()));
                                    },
                                    child:  SizedBox(
                                      width: 300.w,
                                      height: 50.h,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                         SizedBox(height: 5.0.h),
                      ],
                    ),
                  ),
                   SizedBox(height: 15.0.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(

                      height: 184.h,
                      decoration:  BoxDecoration(
                        color:  globalvariable.backgroundcard,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13.0),
                        child: Row(
                          children: [
                           Text('Earn While doing \nDeliveries for People',style: globalvariable.lgtext2,),
                            SizedBox(width:150.w,child: Image.asset('assets/Robot.png')),
                          ],
                        ),
                      ),
                    ),
                  ),
                   SizedBox(height: 15.0.h),

              FadeTransition(
                opacity: animation1 as dynamic,
                child: Transform(
                  transform: Matrix4.translationValues(0, muchDelayAnimation!.value * 40, 0),
                    child: GridView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio:1.1,crossAxisSpacing: 2,mainAxisSpacing: 2 ),
                      children: [
                        InkWell( onTap:() {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const sendPackagescreen1()));
                            },child: GridViewitems(image: 'assets/vector1.png', title: 'Send Package', desc: 'Schedule your package to be delivered')),
                        InkWell(onTap:() {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const Delivery()));
                                },child: GridViewitems(image: 'assets/vector2.png', title: 'Do Delivery', desc: 'BE Available to do Delivery')),
                        InkWell(onTap:() {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const GetQuote()));
                                },child: const GridViewitems(image: 'assets/Vector3.png', title: 'Delivery Rate', desc: 'Get the  prices of deliveries within states')),
                        InkWell(onTap:() {},child: const GridViewitems(image: 'assets/Vector4.png', title: 'Contact support', desc: 'Get the  prices of deliveries within states')),
                          ],
                    ),
                  ),)
                ],
              ),
            ),
          ),),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
          floatingActionButton: Builder(
            builder: (context) {
              return isgoing ? Padding(
            padding: const EdgeInsets.all(8.0),
               child: SizedBox(
                height: 30.h,
                width: 150.w,
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                    ),
                  mini: false,
                  backgroundColor: Colors.black,
                  child: Text('On going delivery'),
                  onPressed: () {

                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25)),

                    ),
                    builder: (BuildContext context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.65,
                       width: 200.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text('On going Delivery',style: globalvariable.lgtext,),
                                  ),
                                  IconButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.close))
                                ],
                              ),
                              SizedBox(height: 10.h,),
                              Image.asset('assets/deliveryboy.png'),
                              SizedBox(height: 10.h,),
                              Text('From:',style: globalvariable.lgtext5,),
                              SizedBox(height: 5.h),
                              Text(delivery.senderaddress,style: globalvariable.lgtext6,),
                              SizedBox(height: 13.h,),
                              Text('To:',style: globalvariable.lgtext5,),
                              SizedBox(height: 5.h),
                              Text(delivery.recevieraddress,style: globalvariable.lgtext6,),
                              SizedBox(height: 30.h,),
                              InkWell(
                                  onTap:(){

                                  },child: Text('Cancel Delivery',style: globalvariable.lgtext9,)),
                              SizedBox(height: 10.h,),
                              progresses? isLoading
                                  ? const Center(child: CircularProgressIndicator()):CustomButton(text: 'Delivered', onTap: (){
                                setState(() {
                                  isgoing = false;
                                });
                                progress1();



                                Navigator.pop(context);

                              }):isLoading
                                  ? const Center(child: CircularProgressIndicator()):CustomButton(text: 'Accepted package', onTap: (){

                                progress();

                              })

                            ],
                          )
                        ),
                      );
                    },
                  );
                },),
            ),
            ): SizedBox();
      },
     ),
        );
      }
    );
  }
}
