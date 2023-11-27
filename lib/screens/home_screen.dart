import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medi_query/constants/colors.dart';
import 'package:medi_query/constants/images.dart';
import 'package:medi_query/constants/textstyle.dart';
import 'package:medi_query/screens/blog_post_screen.dart';
import 'package:medi_query/screens/chating_screen.dart';
import 'package:medi_query/screens/found_hospital.dart';
import 'package:medi_query/screens/history_screen.dart';
import 'package:medi_query/services/map_service.dart';
import 'package:medi_query/widgets/custom_container.dart';
import 'package:medi_query/widgets/prompt_container.dart';
import 'package:permission_handler/permission_handler.dart';

final hospitalLocationProvider = Provider((ref) => mapApiProvider);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  var nearestHospital;
  //   final ref = watch(hospitalLocationProvider);
  late List containerFunctions = [];
  List icons = [breath, location, sethstoscope, lungs, wand, wand];
  List actions = [
    'Check your symptoms',
    'Locate a nearby hospital around you',
    'Talk to a medical personnel',
    'Discover health resources',
    'Discover blog posts',
    'What\'s the possible symptoms of covid'
  ];
  bool isMalaria = false;
  bool isCovid = false;
  bool isEbola = false;
  bool isRandom = false;
  void malaria() {
    setState(() {
      isMalaria = true;
      isCovid = false;
      isEbola = false;
      isRandom = false;
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChattingScreen(
                  prompt: 'malaria',
                )));
  }

  void covid() {
    setState(() {
      isMalaria = false;
      isCovid = true;
      isEbola = false;
      isRandom = false;
    });
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChattingScreen(
                  prompt: 'covid',
                )));
  }

  void ebola() {
    setState(() {
      isMalaria = false;
      isCovid = false;
      isEbola = true;
      isRandom = false;
    });
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChattingScreen(
                  prompt: 'ebola',
                )));
  }

  void random() {
    setState(() {
      isMalaria = false;
      isCovid = false;
      isEbola = false;
      isRandom = true;
    });
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChattingScreen(
                  prompt: 'Tell me something random about health',
                )));
  }

  final promptController = TextEditingController();
  @override
  void dispose() {
    promptController.dispose();
    super.dispose();
  }

  List colors = [purple, green, white, purple, green, grey];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mapRef = ref.watch(mapApiProvider);

    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size(50, 50),
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
                            builder: (context) => const HistoryScreen())),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            const SizedBox(height: 10),
            Row(
              children: [
                CustomContainer(
                    color: colors[0],
                    text: actions[0],
                    image: icons[0],
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChattingScreen()));
                    }),
                const SizedBox(width: 15),
                CustomContainer(
                  color: colors[1],
                  text: actions[1],
                  image: icons[1],
                  onTap: () async {
                    var result = await Permission.location.request();
                    if (result.isGranted) {
                      Position position = await Geolocator.getCurrentPosition(
                          desiredAccuracy: LocationAccuracy.high);
                      final nearByHospital = await mapRef.findNearestHospital(
                        position.latitude,
                        position.longitude,
                      );
                      setState(() {
                        nearestHospital = nearByHospital;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FoundHospitalScreen(
                                  nearbyHospital: nearestHospital)));
                    } else if (result.isDenied) {
                      openAppSettings();
                    } else if (result.isPermanentlyDenied) {
                      openAppSettings();
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                CustomContainer(
                  color: colors[2],
                  text: actions[2],
                  image: icons[2],
                  onTap: () {},
                ),
                const SizedBox(width: 15),
                CustomContainer(
                  color: colors[3],
                  text: actions[3],
                  image: icons[3],
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                CustomContainer(
                  color: colors[4],
                  text: actions[4],
                  image: icons[4],
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlogPostScreen()));
                  },
                ),
                const SizedBox(width: 15),
                CustomContainer(
                  color: colors[5],
                  text: actions[5],
                  image: icons[5],
                  onTap: () {
                    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChattingScreen(
                  prompt: 'What\'s the possible symptoms of covid',
                )));
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PromptContainer(
                    prompt: 'Malaria symptoms',
                    isSelected: isMalaria,
                    action: malaria,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  PromptContainer(
                    prompt: 'Covid',
                    isSelected: isCovid,
                    action: covid,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  PromptContainer(
                    prompt: 'Ebola',
                    isSelected: isEbola,
                    action: ebola,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  PromptContainer(
                      prompt: 'Random', isSelected: isRandom, action: random),
                ],
              ),
            ),
            const SizedBox(height: 15),
          ]),
        ),
      ),
    );
  }
}
