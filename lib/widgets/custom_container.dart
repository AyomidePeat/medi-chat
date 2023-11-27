import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medi_query/constants/colors.dart';
import 'package:medi_query/constants/images.dart';
import 'package:medi_query/constants/textstyle.dart';

class CustomContainer extends StatelessWidget {
  final Color color;
  final String text;
  final String image;
  final onTap;
  const CustomContainer(
      {super.key,
      required this.color,
      required this.text,
      required this.image, required this.onTap
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap:onTap,
      child: Container(
        width: 167,
        height: 160,
        padding: EdgeInsets.all(30),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(30), color: color),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(image),
            Text(text, style: bodyText(black, 14)),
          ],
        ),
      ),
    );
  }
}
