import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/auth/screens/login.dart';
import 'package:posterbox/auth/screens/signup.dart';
import 'package:posterbox/common/widgets/button.dart';
import 'package:posterbox/utils/globalvariable.dart';

class onboardingScreen extends StatefulWidget {
 onboardingScreen({Key? key}) : super(key: key);

  @override
  State<onboardingScreen> createState() => _onboardingScreenState();
}

class _onboardingScreenState extends State<onboardingScreen>  with TickerProviderStateMixin{
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
  int _current = 0;

  final CarouselController _controller = CarouselController();

 final List<String> imgList = [
       'assets/Delivery.png',
       'assets/onlinepay.png',
       'assets/Delivery25.png'
 ];
  final List<Map<String, String>> onboardingContent = [
    {
      'title': 'Request Delivery',
      'subtitle': 'Make a request for your parcel to be \n sent to any state in the country',
    },
    {
    'title': 'Make Money',
      'subtitle': 'Earn while doing Deliveries to the \n Travel Destination',
    },
    {
      'title': 'Get Started',
      'subtitle': 'Make a request  for your parcel to be \n sent to any state in the country',
    },];



  @override
  Widget build(BuildContext context) {
    animationController!.forward();
    return AnimatedBuilder(animation: animationController!, builder: (context, child){
    return Scaffold(
       backgroundColor: globalvariable.backgroundcolor,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
              opacity: animation3 as dynamic,
               child: Transform(
               transform: Matrix4.translationValues(animation!.value * 40, 0, 0),
               child: Column(
                children: [
                  SizedBox(
                      height: 100.h,
                      width: 200.w,
                      child: Image.asset('assets/logo2.png',fit: BoxFit.contain,)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 12.0.w,
                          height: 12.0.h,
                          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : globalvariable.primarycolor)
                                  .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),)),
              FadeTransition(
              opacity: animation2 as dynamic,
              child: Transform(
              transform: Matrix4.translationValues(delayedAnimation!.value * 40, 0, 0),
              child: CarouselSlider(

                options: CarouselOptions(
                   height: 400.h,



                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),



                items: imgList.asMap().entries.map((entry) {
                  final int index = entry.key;
                  final String imagePath = entry.value;
                  final String title = onboardingContent[index]['title']!;
                  final String subtitle = onboardingContent[index]['subtitle']!;
                  return Column(
                    children: [
                      Padding(
                        padding:  EdgeInsets.all(8.h),
                        child: Text(title, style: globalvariable.lgtext),
                      ),
                      Text(subtitle, style: globalvariable.lgtext1,textAlign: TextAlign.center),
                      SizedBox(
                        width: 250.w,
                        height:310.h,
                        child: Image.asset(imagePath,fit: BoxFit.contain,),
                      ),
                    ],
                  );
                }).toList(),
              ))),
           FadeTransition(
           opacity: animation1 as dynamic,
           child: Transform(
            transform: Matrix4.translationValues(0, muchDelayAnimation!.value * 40, 0),
           child:Column(
                children: [
                  CustomButton(text: 'Sign Up', onTap: ()=> Navigator.push(context,  MaterialPageRoute(
                    builder: (context) =>  const SignUp(),
                  ))),

                  CustomButton(text: 'Login', onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));},color: Colors.white,),
                ],
              ),
           ))
            ],
          ),
        ),
      ),

    );});
  }
}
