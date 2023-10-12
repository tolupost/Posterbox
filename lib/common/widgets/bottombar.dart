

import 'package:flutter/material.dart';
import 'package:posterbox/utils/globalvariable.dart';

import '../../account/screens/accountScreen.dart';
import '../../activity/screens/Activity.dart';
import '../../home/screens/home.dart';
import '../../schedule/screens/schedulescreen.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const ActivityScreen(),
    const ScheduleScreen(),
    const AccountScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: globalvariable.primarycolor,
        unselectedItemColor: Colors.black12,
        backgroundColor: globalvariable.backgroundcolor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          // HOME
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(

                  ),
                  child: const Icon(
                    Icons.home_outlined,
                  ),
                ),
                Text('Home',style: TextStyle(fontFamily: 'Inter',fontWeight: FontWeight.w500, fontSize: 10,color:  _page == 0
                    ? globalvariable.primarycolor
                    : Colors.black12,
                )
                ),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(

                  ),
                  child: const Icon(
                    Icons.access_time_sharp,
                  ),
                ),
                Text('Activity',style: TextStyle(fontFamily: 'Inter',fontWeight: FontWeight.w500, fontSize: 10,color:  _page == 1
                    ? globalvariable.primarycolor
                    : Colors.black12,
              )
                ) ],
            ),
                label: '',
          ),

          // CART
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(

                  ),

                    child: const Icon(
                      Icons.card_travel_outlined,
                    ),

                ),
                Text('Schedule',style: TextStyle(fontFamily: 'Inter',fontWeight: FontWeight.w500, fontSize: 10,color:  _page == 2
                    ? globalvariable.primarycolor
                    : Colors.black12,
                )
                ),
              ],
            ),
            label: '',
          ),
          // ACCOUNT
          BottomNavigationBarItem(
            icon: Column(
              children: [
                Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                  ),
                  child: const Icon(
                    Icons.person_outline_outlined,
                  ),
                ),
                Text('Account',style: TextStyle(fontFamily: 'Inter',fontWeight: FontWeight.w500, fontSize: 10,color:  _page == 3
                    ? globalvariable.primarycolor
                    : Colors.black12,
                )
                ),
              ],
            ),
            label: '',
          ),
        ],
      ),

    );
  }
}