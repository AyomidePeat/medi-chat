import 'package:flutter/material.dart';
import 'package:medi_query/constants/colors.dart';
import 'package:medi_query/constants/textstyle.dart';

class MyMessageBox extends StatelessWidget {
  final String text;
  final isSender;
  const MyMessageBox({super.key, required this.text, this.isSender, });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
          width: 212,
          height: 34,
          padding: const EdgeInsets.all(10),
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
          child: Text(text,
              style: bodyText(black, 12))),
    );
  }
}
