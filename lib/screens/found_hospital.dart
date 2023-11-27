import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medi_query/constants/colors.dart';
import 'package:medi_query/model/hospital_model.dart';
import 'package:medi_query/widgets/nearby_hospital_cntainer.dart';


class FoundHospitalScreen extends ConsumerStatefulWidget {
  final nearbyHospital;
  const FoundHospitalScreen({super.key, required this.nearbyHospital});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FoundHospitalScreenConsumerState();
}

class _FoundHospitalScreenConsumerState extends ConsumerState<FoundHospitalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon:
                        const Icon(Icons.arrow_back_ios, color: Colors.white)),
                const Text(
                  'Hosiptals Near You',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ],
            )),
        body: ListView.builder(
          itemCount: widget.nearbyHospital.length,
          itemBuilder: (BuildContext context, int index) {
            HospitalModel hospital = widget.nearbyHospital[index];
            if (widget.nearbyHospital.isNotEmpty) {
              return ListTile(
                title: NearbyHospitalContainer(
                  name: hospital.name,
                  distance: hospital.distance.toString(),
                  address: hospital.address,
                  city: hospital.city,
                 
                ),
               
              );
            } else {
              return const Center(
                  child: Text('No Hospital found near you',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)));
            }
          },
        ));
  }
}
