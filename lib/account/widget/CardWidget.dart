import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/user-providers.dart';

class CardWidget extends StatefulWidget {
  final int index;
  const CardWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    final Card = context.watch<UserProvider>().user.card![widget.index];
    final cardnumber = Card['cardnumber'];
    String cardnum = cardnumber.substring(cardnumber.length - 4);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.all(15),
          width: 361,
          height: 122,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),

          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Text('Mastercard',style: TextStyle(fontFamily: 'Inter',fontWeight: FontWeight.w700,fontSize: 14),),
                  Text("****${cardnum}",style: TextStyle(fontFamily: 'Inter',fontWeight: FontWeight.w700,fontSize: 14),)
                ],
              ),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 18.0),
                   child: Image.asset('assets/Group8.png'),
                 ),
            ],
          ),
        ),
      ),
    );
  }
}
