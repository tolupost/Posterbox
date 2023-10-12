import 'dart:async';

import 'package:flutter/material.dart';
import 'package:posterbox/common/widgets/appbar.dart';
import 'package:posterbox/home/widget/Notificationitem.dart';
import 'package:posterbox/models/delivery.dart';
import 'package:provider/provider.dart';

import '../../Providers/user-providers.dart';
import '../services/homeService.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<Delivery>? deliveryList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    getusernotification();
  }



  getusernotification() async {
    deliveryList = await homeServices.getusernotification(
      context: context, 
    );
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: customappBar(
        title: 'Notifications',
      ),
      body: deliveryList == null
          ? Center(child: const CircularProgressIndicator())
          :ListView.builder(
          itemCount: deliveryList?.length,
          itemBuilder: (context, index)
            {
            final delivery = deliveryList![index];
            bool isLoading = false;
            void changeDeliveryStatus() {
              setState(() {
                isLoading = true;
              });
              homeServices.changeDeliveryStatus(
                context: context,
                username: user.name, usernumber: user.phone, progress: 'IN- PROGRESS', delivery: delivery, notificationId: delivery.id!, ongoing: delivery.id!,
              ).then((value) => setState(() {
                isLoading = false;
              }));
              Timer(Duration(minutes: 1), () {
                setState(() {
                  isLoading = false;
                });
              });


            }
            void removenotification() {
              setState(() {
                isLoading = true;
              });
              homeServices.removenotification(
                context: context, notificationId: delivery.id!,

              ).then((value) => setState(() {
                isLoading = false;
              }));
              Timer(Duration(minutes: 1), () {
                setState(() {
                  isLoading = false;
                });
              });
            }
              return  isLoading
                  ?Center(child: CircularProgressIndicator()):Notificationitems(
                day: delivery.deliverytimeline,
                address: delivery.recevieraddress,
                sender: delivery.sendername,
                onTap: changeDeliveryStatus,
                onTap1: removenotification,);
      })
    );
  }
}
