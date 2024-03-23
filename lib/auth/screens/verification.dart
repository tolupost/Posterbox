import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:posterbox/utils/globalvariable.dart';

import '../../common/widgets/appbar.dart';
import '../../common/widgets/button.dart';
import '../service/authservice.dart';

class Verification extends StatefulWidget {

  final String email;
  final String name;

  final String password;
  final String phone;
  final String res;
  const Verification({Key? key,

    required this.email,
    required this.name,
    required this.password,
    required this.phone,
    required this.res}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> with TickerProviderStateMixin {
  final AuthService authService = AuthService();
  Animation ? animation, delayedAnimation,muchDelayAnimation,animation1,animation2,animation3;
  AnimationController ? animationController;
  AnimationController ? _controller;
  int levelClock = 300;
  bool isLoading = false;
  bool resend = false;
  bool two = false;
  void resendOtp() {

    authService.resendOtp(
      context: context,
      phone: widget.phone,

    );
  }
  void signUpUser() {
    print(_otpCode);
    setState(() {
      isLoading = true;
    });

     authService.signUpUser(
          context: context,
          email: widget.email,
          password: widget.password,
          name: widget.name,
          phone: widget.phone,
          otp: _otpCode,
        ).then((value) => setState(() {
          isLoading = false;
        }));
        Timer(Duration(minutes: 1), () {
          setState(() {
            isLoading = false;
          });
        });


  }


  String _otpCode ="";
  bool isApiCall= false;
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    myFocusNode.requestFocus();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(
            seconds:
            levelClock) // gameData.levelClock is a user entered number elsewhere in the applciation
    );

    _controller?.forward();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) => AlertDialog(
    //       title: Text("Your one time token"),
    //       content: Text(widget.res),
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
  void dispose() {

    _controller?.dispose();
    myFocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
  final defaultPinTheme = PinTheme(

      width: 56.w,
      height: 56.h,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius:  BorderRadius.circular(8),
        // borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: globalvariable.primarycolor),
      borderRadius: BorderRadius.circular(8),
    );
  animationController!.forward();
  return AnimatedBuilder(animation: animationController!, builder: (context, child){
    return Scaffold(
      appBar: customappBar(
        title: 'Verification',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 13),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h,),
        FadeTransition(
          opacity: animation3 as dynamic,
          child: Transform(
            transform: Matrix4.translationValues(animation!.value * 40, 0, 0),
            child:Text('Input the 6 digit dent to your mobile number to verify your accout. ',style: globalvariable.lgtext1,))),
                SizedBox(height: 7.h,),
        FadeTransition(
          opacity: animation2 as dynamic,
          child: Transform(
            transform: Matrix4.translationValues(delayedAnimation!.value * 40, 0, 0),
            child: Pinput(

                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) {
                    setState(() {
                      _otpCode = pin;
                    });
                  },
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    if (val.length == 6) {
                      setState(() {
                        val == _otpCode;
                      });

                    }

                  },

                ))),
                SizedBox(height: 14.h,),
                InkWell(

                  onTap: resend ? () {
                   resendOtp();
                   _controller = AnimationController(
                       vsync: this,
                       duration: Duration(
                           seconds:
                           levelClock) // gameData.levelClock is a user entered number elsewhere in the applciation
                   );

                   _controller?.forward();
                  } : null,
                  child: Countdown(
                    animation: StepTween(
                      begin: levelClock, // THIS IS A USER ENTERED NUMBER
                      end: 0,
                    ).animate(_controller!)..addStatusListener((status) {
                      // Trigger the onTap function when the countdown animation is complete
                      if (status == AnimationStatus.completed) {
                       setState(() {
                         resend = true;
                       });
                      }
                    }),
                  ),
                ),
              ],
            ),
          FadeTransition(
              opacity: animation1 as dynamic,
              child: Transform(
                 transform: Matrix4.translationValues(0, muchDelayAnimation!.value * 40, 0),
                child:isLoading
                  ? const Center(child: CircularProgressIndicator()):CustomButton(text: 'Next', onTap: () {
                     signUpUser();
                })))],
        ),
      ),
    );});
  }
}
class Countdown extends AnimatedWidget {
  Countdown({Key ? key, required this.animation,}) : super(key: key, listenable: animation);
  Animation<int> animation;
  final AuthService authService = AuthService();


  @override
  build(BuildContext context) {

    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    if (clockTimer.inSeconds == 0) {
      return

          Text(
            'Resend otp. ',style: globalvariable.lgtext9,
          );



    }
    return Text(
      'Resend otp in ${timerText}s. ',style: globalvariable.lgtext1,
    );
  }
}