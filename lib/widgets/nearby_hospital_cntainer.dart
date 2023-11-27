import 'package:flutter/material.dart';
import 'package:medi_query/constants/colors.dart';
import 'package:medi_query/constants/textstyle.dart';

class NearbyHospitalContainer extends StatelessWidget {
  final String name;
  final String distance;
  final String address;
  final String city;

  const NearbyHospitalContainer(
      {super.key,
      required this.name,
      required this.distance,
      required this.address,
      required this.city,
      
      });

  @override
  Widget build(BuildContext context) {
    return Container(
    
        decoration: BoxDecoration(
          color: purple,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Row(
                children: [
                 // SizedBox(width: 43, height:43,child: Image.network(image)),
               const   SizedBox(width: 7,),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: headline(black, 14)
            ),
            Text(
                  '$address, $city',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: bodyText(black, 12)
            ),
            Text(
                  '$distance meters',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                 style: bodyText(black, 12)
            ),
          ]),
                ],
              ),
        ));
  }
}
