import 'package:flutter/material.dart';
import 'package:medi_query/constants/colors.dart';
import 'package:medi_query/constants/textstyle.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController promptController;
  final onSubmitted;
  final onTap;
  const TextFieldWidget(
      {super.key,
      required this.promptController,
      required this.onSubmitted,
      this.onTap});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool isEmpty = true;
  @override
  void initState() {
    super.initState();

    // Listen for changes in the text controller to update the icon
    widget.promptController.addListener(() {
      setState(() {
        isEmpty = widget.promptController.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            height: 44,
            padding: const EdgeInsets.only(
              left: 20,
              right: 10,
            ),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: purple),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 240,
                    height: 66,
                    child: TextField(
                      onSubmitted: widget.onSubmitted,
                      maxLines: null,
                      cursorColor: green,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Malaria symptoms',
                          hintStyle: bodyText(
                              Colors.white.withOpacity(0.4000000059604645),
                              16)),
                      style: bodyText(white, 16),
                    ),
                  ),
                  if (isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 10, right: 5),
                      child: InkWell(
                        onTap: widget.onTap,
                        child: Text(
                          'Continue',
                          style: bodyText(white, 16),
                        ),
                      ),
                    )
                ])),
      ],
    );
  }
}
