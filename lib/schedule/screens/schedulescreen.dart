import 'package:flutter/material.dart';
import 'package:posterbox/schedule/widget/scheduleWidget.dart';
import 'package:posterbox/utils/globalvariable.dart';
import 'package:provider/provider.dart';

import '../../Providers/user-providers.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: globalvariable.primarycolor,
        title: Text('Schedule'),
        leading: IconButton(onPressed: () {  }, icon: Icon(Icons.confirmation_num_sharp,color:globalvariable.primarycolor ),
        ),
      ),
      body: ListView.builder(
        itemCount: user.schedule?.length,
        itemBuilder: (BuildContext context, int index) {
          return Schedule(
            index: index,
          );
        },

      ),
    );
  }
}
