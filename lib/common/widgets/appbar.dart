import 'package:flutter/material.dart';
import 'package:posterbox/utils/globalvariable.dart';

class customappBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;


  const customappBar({Key? key, required this.title}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(56.0);
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyle(color: Colors.white), ),
      centerTitle: true,
      backgroundColor: globalvariable.primarycolor,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,),
      ),

    );
  }
}
