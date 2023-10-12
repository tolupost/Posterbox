import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/account/widget/CardWidget.dart';
import 'package:posterbox/common/widgets/appbar.dart';
import 'package:posterbox/utils/globalvariable.dart';
import 'package:provider/provider.dart';

import '../../Providers/user-providers.dart';
import 'AddCard.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {

  @override
  Widget build(BuildContext context) {

    final user = context.watch<UserProvider>().user;

    return Scaffold(
      appBar: customappBar(
        title: 'Card',
      ),
      body: ListView.builder(
        itemCount: user.card!.length + 1,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index == user.card!.length) {
            // This is the last index, so return the widget you want at the end
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.all(15),
                  width: 361.w,
                  height: 122.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),

                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Add new card',style: globalvariable.lgtext6,),
                      SizedBox(height: 10.h,),
                      InkWell(
                        onTap: (){
                          Navigator.push(context,  MaterialPageRoute(
                            builder: (context) =>  const AddCard(),
                          ));
                        },
                        child: Container(
                          height: 30.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color.fromARGB(255, 217, 217, 217)
                          ),
                          child: Icon(Icons.add,color: Colors.black,size: 20,),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            // This is not the last index, so return your regular item
            return CardWidget(
              index: index,
            );
          }

        },
      ),
    );
  }
}
