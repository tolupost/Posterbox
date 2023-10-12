import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/user-providers.dart';
import '../../home/services/homeService.dart';
import '../../models/delivery.dart';
import '../../schedule/screens/scheduledetail.dart';
import '../widget/allwidget1.dart';
import '../widget/allwidgets.dart';

class FromMe extends StatefulWidget {
  final String id;
  const FromMe({Key? key, required this.id}) : super(key: key);

  @override
  State<FromMe> createState() => _FromMeState();
}

class _FromMeState extends State<FromMe> {
  List<Delivery>? deliveryList;

  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
  }

  fetchCategoryProducts() async {
    deliveryList = await homeServices.fetchCategoryProducts(
      context: context,
      id: widget.id,

    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      body:deliveryList == null
          ? Center(child: const CircularProgressIndicator())
          : ListView.builder(
        itemCount: deliveryList?.length,
        itemBuilder: (BuildContext context,

            int index) {
          final delivery = deliveryList![index];

          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ScheduleDetails(
                username: delivery.username,
                deliverydate: delivery.deliverydate,
                deliveryfee: delivery.deliveryfee,
                deliveryinstructions: delivery.deliveryinstructions,
                deliverytimeline: delivery.deliverytimeline,
                deliveryweight: delivery.deliveryweight,
                id: delivery.id!,
                number: delivery.usernumber,
                progress: delivery.progress,
                recevieraddress: delivery.recevieraddress,
                receviername: delivery.receviername,
                receviernumber: delivery.receviernumber,
                senderaddress: delivery.senderaddress,
                sendername: delivery.sendername,
                sendernumber: delivery.sendernumber,
              )));
            },
            child: AllWidget1(
                progress: (delivery.progress == 'IN- PROGRESS'),
                delivered: (delivery.progress == 'DELIVERED'),
                cancelled: (delivery.progress == 'CANCELLED'),
              notbyme: (delivery.userId == user.id),
              byme: (delivery.deliverId == user.id),
              sender: delivery.sendername,
              receiver: delivery.receviername,
              address: delivery.recevieraddress,
              username: delivery.username,
              date: delivery.deliverydate,),
          );
        },

      ),
    );
  }
}
