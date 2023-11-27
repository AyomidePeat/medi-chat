import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medi_query/constants/colors.dart';
import 'package:medi_query/constants/images.dart';
import 'package:medi_query/constants/textstyle.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        appBar: AppBar(automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(option),
                        Text(
                          'History',
                          style: headline(white, 25),
                        ),
                      ],
                    ),
                    SvgPicture.asset(profile)
                  ],
                ),
              ),
              Container(
                width: 336,
                height: MediaQuery.of(context).size.height - 200,
                decoration: ShapeDecoration(
                  color: const Color(0xFFFCDDEC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Color(0xFF4C3C3C3C),
                                ),
                                suffixIcon:
                                    Icon(Icons.mic, color: Color(0xFF4C3C3C3C)),
                                contentPadding: EdgeInsets.all(5),
                                filled: true,
                                fillColor: white,
                                hintText: 'Search',
                                hintStyle:
                                    bodyText(const Color(0xFF4C3C3C3C), 17)),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text('Today', style: headline(black, 12)),
                        const SizedBox(height: 30),
                        Text('Malaria symptoms  ', style: bodyText(black, 12)),
                        const SizedBox(height: 30),
                        Text('Malaria symptoms  ', style: bodyText(black, 12)),
                        const SizedBox(height: 30),
                        Text('Yesterday', style: headline(black, 12)),
                        const SizedBox(height: 30),
                        Text('Malaria symptoms  ', style: bodyText(black, 12)),
                        const SizedBox(height: 30),
                        Text('Malaria symptoms  ', style: bodyText(black, 12)),
                        const SizedBox(height: 30),
                        Text('Malaria symptoms  ', style: bodyText(black, 12)),
                        const SizedBox(height: 30),
                        Text('Malaria symptoms  ', style: bodyText(black, 12)),
                        const SizedBox(height: 30),
                        Text('Malaria symptoms  ', style: bodyText(black, 12)),
                        const SizedBox(height: 30),
                        Text('Malaria symptoms  ', style: bodyText(black, 12)),
                        const SizedBox(height: 30),
                        Text('Previous 7 days', style: bodyText(black, 12)),
                        const SizedBox(height: 30),
                        Text('Malaria symptoms  ', style: bodyText(black, 12)),
                        const SizedBox(height: 30),
                        Text('Malaria symptoms  ', style: bodyText(black, 12)),
                        const SizedBox(height: 30),
                        Text('Malaria symptoms  ', style: bodyText(black, 12)),
                        const SizedBox(height: 30),
                        Text('Malaria symptoms  ', style: bodyText(black, 12)),
                        const SizedBox(height: 30),
                        Text('Malaria symptoms  ', style: bodyText(black, 12)),
                        const SizedBox(height: 30),
                        Text('Malaria symptoms  ', style: bodyText(black, 12)),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
