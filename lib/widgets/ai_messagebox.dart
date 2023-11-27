import 'package:flutter/material.dart';
import 'package:medi_query/constants/colors.dart';
import 'package:medi_query/constants/textstyle.dart';

class AIMessageBox extends StatelessWidget {
final String text;
  final isSender;
  const AIMessageBox({super.key, required this.text, this.isSender,  });

  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.centerLeft,
      child: Container(
          width: 283,
         
          padding: const EdgeInsets.all(10),
          decoration: ShapeDecoration(
            color: green,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          ),
          child:  Text(
text,    style: bodyText(black, 14)
    ),
          ),
    );
  }
}
