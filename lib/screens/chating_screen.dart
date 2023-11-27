import 'dart:convert';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:medi_query/constants/colors.dart';
import 'package:medi_query/constants/images.dart';
import 'package:medi_query/constants/textstyle.dart';
import 'package:medi_query/model/chat_model.dart';
import 'package:medi_query/screens/history_screen.dart';
import 'package:medi_query/widgets/ai_messagebox.dart';
import 'package:medi_query/widgets/my_message_box.dart';
import 'package:medi_query/widgets/textfield_widget.dart';

class ChattingScreen extends StatefulWidget {
  final String? prompt;
  const ChattingScreen({super.key, this.prompt});

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  TextEditingController promptController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<ChatModel> chats = [];
  bool isTyping = false;

  @override
  void dispose() {
    promptController.dispose();
  }

  void sendMsg() async {
    String text = widget.prompt!.isNotEmpty? widget.prompt! :promptController.text;

    promptController.clear();
    try {
      if (text.isNotEmpty) {
        setState(() {
          chats.insert(0, ChatModel(true, text));
          isTyping = true;
        });
        scrollController.animateTo(0.0,
            duration: const Duration(seconds: 1), curve: Curves.easeOut);
        var response = await http.post(
            Uri.parse("https://api.openai.com/v1/chat/completions"),
            headers: {
              "Authorization":
                  "Bearer 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",
              "Content-Type": "application/json"
            },
            body: jsonEncode({
              "model": "gpt-3.5-turbo",
              "messages": [
                {"role": "user", "content": text}
              ]
            }));
        if (response.statusCode == 200) {
          var json = jsonDecode(response.body);
          setState(() {
            isTyping = false;
            chats.insert(
                0,
                ChatModel(
                    false,
                    json["choices"][0]["message"]["content"]
                        .toString()
                        .trimLeft()));
          });
          scrollController.animateTo(0.0,
              duration: const Duration(seconds: 1), curve: Curves.easeOut);
        }
      }
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Some error occurred, please try again!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: Size(50, 50),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    InkWell(
                      child: SvgPicture.asset(option),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HistoryScreen())),
                    ),
                    Text(
                      'Discover',
                      style: headline(white, 25),
                    ),
                  ],
                ),
                SvgPicture.asset(profile)
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: chats.length,
                  shrinkWrap: true,
                  reverse: true,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: chats[index].isSender
                            ? Column(
                                children: [
                                  MyMessageBox(
                                    text: chats[0].msg,
                                    isSender: true,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 16, top: 4),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Typing...")),
                                  )
                                ],
                              )
                            : AIMessageBox(
                                text: chats[index].msg,
                                isSender: chats[index].isSender,
                              ));
                  }),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 44,
                      decoration: BoxDecoration(
                          border: Border.all(color: purple),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 240,
                              height: 66,
                              child: TextField(
                                style: bodyText(white, 14),
                                controller: promptController,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                onSubmitted: (value) {
                                  sendMsg();
                                },
                                textInputAction: TextInputAction.send,
                                showCursor: true,
                                cursorColor: green,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Malaria symptoms',
                                    hintStyle: bodyText(
                                        Colors.white
                                            .withOpacity(0.4000000059604645),
                                        16)),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                sendMsg();
                              },
                              child: Text(
                                'Continue',
                                style: bodyText(white, 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // InkWell(
                //   onTap: () {
                //     sendMsg();
                //   },
                //   child: Container(
                //     height: 40,
                //     width: 40,
                //     decoration: BoxDecoration(
                //         color: Colors.blue,
                //         borderRadius: BorderRadius.circular(30)),
                //     child: const Icon(
                //       Icons.send,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
                const SizedBox(
                  width: 8,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
