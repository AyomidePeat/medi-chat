import 'package:flutter/material.dart';
import 'package:medi_query/constants/colors.dart';
import 'package:medi_query/constants/textstyle.dart';

class PromptContainer extends StatelessWidget {
  final bool isSelected;
  final String prompt;
  final VoidCallback action;
  PromptContainer({super.key, required this.prompt, required this.isSelected, required this.action});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: isSelected == true ? purple : white,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Text(prompt, style: bodyText(white, 14))),
    );
  }
}
