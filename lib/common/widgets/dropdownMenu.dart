import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:posterbox/utils/globalvariable.dart';

class dropdownMenu extends StatefulWidget {
  late  String dropdownvalue;
  final List <String> items;
 dropdownMenu({Key? key, required this.dropdownvalue, required this.items, }) : super(key: key);

  @override
  State<dropdownMenu> createState() => _dropdownMenuState();
}

class _dropdownMenuState extends State<dropdownMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9),
      width: 170.w,
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.black,width: 0.5.w)
      ),
      child: Center(
        child: DropdownButton(
          elevation: 0,
          underline: Container(
            decoration: BoxDecoration(

                border: Border.all(color: Colors.white,width: 0.5.w)
            ),
          ),
          isDense: true,
          isExpanded: true,

             style:globalvariable.lgtext4 ,
          // Initial Value
          value: widget.dropdownvalue,
          hint: const Text('Country'),
          alignment: Alignment.center,

          // Down Arrow Icon
          icon: const Icon(Icons.keyboard_arrow_down),

          // Array list of items
          items: widget.items.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (String? newValue) {
            setState(() {
              widget.dropdownvalue = newValue!;
            });
          },
        ),
      ),
    );
  }
}
