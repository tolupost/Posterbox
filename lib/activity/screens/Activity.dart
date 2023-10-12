import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/activity/screens/All.dart';
import 'package:posterbox/activity/screens/ByMe.dart';
import 'package:posterbox/activity/screens/fromMe.dart';
import 'package:posterbox/utils/globalvariable.dart';
import 'package:provider/provider.dart';

import '../../Providers/user-providers.dart';
class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>with SingleTickerProviderStateMixin {
  final String names='';

  AnimationController ? _controller;
  Animation<double> ? _opacityAnimation;
  Animation<double> ? _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Interval(0, 0.5),
      ),
    );
    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Interval(0, 1),
      ),
    );
    _controller!.forward();
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context).user;
    return AnimatedBuilder(
        animation: _controller!,
        builder: (context, child) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: globalvariable.primarycolor,
          title: Text('Deliveries'),
          leading: IconButton(onPressed: () {  }, icon: Icon(Icons.confirmation_num_sharp,color:globalvariable.primarycolor ),
          ),
          bottom:  PreferredSize (
            preferredSize: Size.fromHeight(48.0),
            child:Material(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: Column(
                  children: [
                    SizedBox(height: 25.h,),
                    Container(
                      height: 25.h,
                      child: Transform.translate(
                        offset: Offset(0, _scaleAnimation!.value),
                        child: TabBar(

                          indicatorColor: globalvariable.primarycolor,
                          labelColor: Colors.black,
                          padding: EdgeInsets.zero,
                          indicatorPadding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.symmetric(horizontal: 0),
                          indicatorWeight: 4,
                          tabs: [
                            Tab( text: "All",),
                            Tab( text: "From me"),
                            Tab( text: "By me")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ),
        body:      Opacity(
          opacity: _opacityAnimation!.value,
          child: TabBarView(
            children: [
              All(id: user.id,),

              FromMe(id: user.id,),
              ByMe(id: user.id,),
            ],
          ),
        ),
      ),
    ); }
    );
  }
}
