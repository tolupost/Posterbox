import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/schedule/services/scheduleservices.dart';
import 'package:posterbox/utils/globalvariable.dart';
import 'package:provider/provider.dart';

import '../../Providers/user-providers.dart';

class Schedule extends StatefulWidget {
  final int index;
  const Schedule({Key? key, required this.index}) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  final ScheduleServices scheduleServices = ScheduleServices();

  bool _isChecked = false;
  bool select = false;
  @override
  Widget build(BuildContext context) {

    final Schedule = context.watch<UserProvider>().user.schedule![widget.index];
    final to = Schedule['to'];
    final from = Schedule['from'];
    final time = Schedule['time'];
    final id =Schedule['_id'];
    String str = time;
    String day;
    if (str.length > 1 && str[1] == '/') {
      day = str[0];
    } else {
      day = str.substring(0, 2);
    }

    void schedule(){
      scheduleServices.removeschedule(context: context, scheduleId: id);
    }
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        elevation: 4,
        child: _isChecked ? Container(
         padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
          height: 100.h,
          width: 367.w,
          decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(6),

          ),
          child: Row(

            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Row(
                children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      select = !select;
                    });
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Delete Schedule"),
                        content: const Text("Would you like to delete this Schedule "),
                        actions: <Widget>[

                          Row(

                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                  setState(() {
                                    select = !select;
                                  });
                                },
                                child: Container(

                                  padding: const EdgeInsets.all(14),
                                  child: const Text("Cancel"),
                                ),
                              ),
                              SizedBox(width: 80.w,),
                              TextButton(
                                onPressed: () {
                                schedule();
                                },
                                child: Container(

                                  padding: const EdgeInsets.all(14),
                                  child: const Text("Delete"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                   height: 15.h,
                   width: 15.w,
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.black,width: 1.w),
                    ),
                    child: Center(
                      child: Container(
                        height: 8,
                        width: 8.w,
                        decoration: BoxDecoration(
                          color: select ? globalvariable.primarycolor  : Colors.white,
                          borderRadius: BorderRadius.circular(8),

                        ),
                      ),
                    ),
                   ),
                ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Column(children: [
                     Text(day,style: TextStyle(color: globalvariable.primarycolor,fontWeight: FontWeight.w500,fontSize: 20,),),
                    Text('July',style: globalvariable.lgtext6,),
                  ],),
                  SizedBox(width: 10.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 1,),
                    Text('Traveling From-. ${from}'),
                      SizedBox(height: 6,),
                    Text('Traveling To: ${to}'),
                  ],),
                ],
              ),

              GestureDetector(
                  onTap: () {
                    setState(() {
                      _isChecked = !_isChecked;
                    });
                  },
                  child: Center(child: Icon(Icons.info_outline,color: globalvariable.primarycolor,)))
            ],
          ),
        ):Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
          height: 120.h,
          width: 367.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),

          ),
          child: Row(

            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Row(
                children: [
                  Column(children: [
                    Text(day,style: TextStyle(color: globalvariable.primarycolor,fontWeight: FontWeight.w500,fontSize: 20,),),
                    Text('July',style: globalvariable.lgtext6,),
                  ],),
                  SizedBox(width: 10.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 1,),
                      Text('Traveling From-. ${from}'),
                      SizedBox(height: 6,),
                      Text('Traveling To: ${to}'),
                    ],),
                ],
              ),

              GestureDetector(
                  onTap: () {
                    setState(() {
                      _isChecked = !_isChecked;
                    });
                  },
                  child: Center(child: Icon(Icons.info_outline,color: globalvariable.primarycolor,)))
            ],
          ),
        )
      ),
    );
  }
}
