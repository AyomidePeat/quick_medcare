import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';
import 'package:quick_medcare/screens/patient_dashboard/appointment_screen.dart';
import 'package:quick_medcare/chat_feature/chat_screen.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';
import 'package:quick_medcare/widgets/main_button.dart';

import '../../widgets/text_button_widget.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final String image;
  final String name;
  final String department;
  final List time;
  final String specialization;
  const DoctorDetailsScreen(
      {super.key,
      required this.image,
      required this.name,
      required this.department,
      required this.specialization,
      required this.time});

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  bool textRead = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Doctor\'s details', style: headLine2(black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 130,
                    width: size.width * 0.35,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(widget.image)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.5,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            overflow: TextOverflow.fade,
                            style: headLine3(black),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                for (int i = 0; i <= 4; i++)
                                  const Icon(Icons.star,
                                      color: Color.fromARGB(255, 255, 204, 65),
                                      size: 18),
                                const SizedBox(width: 4),
                                Text(
                                  '(24)',
                                  style: bodyText2(context),
                                )
                              ],
                            ),
                          ),
                          Text(
                            widget.department,
                            style: bodyText2(context),
                          ),
                        ],
                      ).animate().fadeIn(duration: 500.ms),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DetailsContainer(
                            aspect: 'patients',
                            color: Colors.red,
                            details: '1000+',
                            icon: Icons.people,
                            size: size)
                        .animate()
                        .then(duration: 300.ms)
                        .fadeIn(duration: 500.ms),
                    DetailsContainer(
                            aspect: 'Experience',
                            color: const Color.fromARGB(255, 255, 204, 65),
                            details: '10 years',
                            icon: Icons.shopping_bag_sharp,
                            size: size)
                        .animate()
                        .then(duration: 500.ms)
                        .fadeIn(duration: 500.ms),
                    DetailsContainer(
                            aspect: 'Hospital',
                            color: const Color.fromARGB(255, 36, 122, 69),
                            details: '+Health',
                            icon: Icons.location_on,
                            size: size)
                        .animate()
                        .then(duration: 700.ms)
                        .fadeIn(duration: 500.ms),
                  ],
                ),
              ),
              Text('About doctor:', style: headLine4(black)),
              const SizedBox(height: 15),
              ExpandableText(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ac odio tempor orci dapibus ultrices in iaculis nunc sed. Sed ullamcorper morbi tincidunt ornare massa eget egestas. Pharetra sit amet aliquam id diam maecenas ultricies mi eget. Fermentum leo vel orci porta non pulvinar neque. Risus quis varius quam quisque id. Fringilla phasellus faucibus scelerisque eleifend donec pretium vulputate sapien nec. Ut sem nulla pharetra diam sit amet nisl. Enim tortor at auctor urna nunc id cursus metus aliquam. Sit amet est placerat in egestas erat. Est ante in nibh mauris. Viverra nibh cras pulvinar mattis nunc. Orci porta non pulvinar neque laoreet suspendisse interdum consectetur. Nulla facilisi etiam dignissim diam quis enim lobortis scelerisque. Mi eget mauris pharetra et ultrices neque ornare aenean..",
                  readMoreText: 'Read more', onLinkPressed: (readMore) {
                setState(() {
                  textRead = readMore;
                });
              },
                  readLessText: "Show less",
                  linkTextStyle: headLine4(black),
                  trimType: TrimType.lines,
                  trim: textRead ? 29 : 4,
                  style: bodyText2(context)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text('Specialization:', style: headLine4(black)),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                color: const Color.fromARGB(255, 193, 241, 205),
                child: Text(
                  widget.specialization,
                  style:
                      const TextStyle(color: Color.fromARGB(255, 4, 143, 67)),
                ),
              ),
              const SizedBox(height: 20),
              Text('Available Times:', style: headLine4(black)),
              const SizedBox(height: 10),
              Text(
                'Today',
                style: bodyText3(grey),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  for (int i = 0; i < widget.time.length; i++)
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            width: 0.2,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        '07:30 PM',
                        style: bodyText3(context),
                      ),
                    ),
                ]),
              ),
              const SizedBox(height: 15),
              Text(
                'Tomorrow',
                style: bodyText3(grey),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  for (int i = 0; i <= widget.time.length; i++)
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            width: 0.4,
                          )),
                      child: Text(
                        widget.time[0],
                        style: bodyText3(context),
                      ),
                    ),
                ]),
              ),
              const SizedBox(height: 15),
              Center(
                child: CustomTextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AppointmentScreen()));
                  },
                  text: 'Book Appointment',
                )
                    .animate()
                    .then(duration: 300.ms)
                    .fadeIn(duration: 500.ms)
                    .slideY(duration: 500.ms, begin: 3),
              ),
              MainButton(
                      onpressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ChatScreen()));
                      },
                      height: 40,
                      width: double.infinity,
                      child: Text(
                        'Chat with doctor',
                        style: TextStyle(color: white),
                      ))
                  .animate()
                  .then(duration: 300.ms)
                  .fadeIn(duration: 500.ms)
                  .slideY(duration: 500.ms, begin: 3),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailsContainer extends StatelessWidget {
  final String details;
  final String aspect;
  final icon;
  final Color color;
  const DetailsContainer({
    super.key,
    required this.size,
    required this.details,
    required this.aspect,
    required this.icon,
    required this.color,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size.width * 0.29,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(icon, color: color),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  details,
                  style: headLine4(grey),
                ),
                Text(
                  aspect,
                  style: bodyText3(context),
                )
              ],
            ),
          ],
        ));
  }
}
