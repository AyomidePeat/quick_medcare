import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_medcare/chat_feature/chat_screen.dart';
import 'package:quick_medcare/screens/chat_list_screen.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';

import '../../widgets/custom_container.dart';
import '../../widgets/main_button.dart';

class PatientFile extends StatefulWidget {
  const PatientFile({super.key});

  @override
  State<PatientFile> createState() => _PatientFileState();
}

class _PatientFileState extends State<PatientFile> {
  int idNo = 09755;
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          'Bio Data',
          style: headLine4(black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                const CircleAvatar(
                  minRadius: 30,
                  backgroundImage: AssetImage('images/patient.jpg'),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jane Doe',
                      style: headLine4(black),
                    ),
                    Text(
                      'Reg No: $idNo',
                      style: const TextStyle(
                          fontFamily: 'Poppins-Regular',
                          fontSize: 12,
                          color: Colors.black),
                    ),
                    const Text(
                      'Registered February 25, 2019',
                      style: TextStyle(
                          fontFamily: 'Poppins-Regular',
                          fontSize: 9,
                          color: Colors.black),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const ContactInfo(),
            const SizedBox(height: 30),
            const NextOfKinContainer(),
            const SizedBox(
              height: 30,
            ),
            const OtherInfo(),
            const SizedBox(
              height: 30,
            ),
            MainButton(
                height: 35,
                width: double.infinity,
                onpressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UsersListScreen()));
                },
                child: Text(
                  'Continue to Chat',
                  style: bodyText3(black),
                )),
          ]),
        ),
      ),
    );
  }
}

class ContactInfo extends StatelessWidget {
  const ContactInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        color: lightBlue,
        height: 500,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('images/note.svg'),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Contact Info',
                      style: headLine3(black),
                    ),
                  ],
                ),
                SvgPicture.asset('images/edit.svg'),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  'Age:',
                  style: bodyText3(black),
                ),
                Text(' 42', style: headLine4(black)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text(
                  'DOB:',
                  style: bodyText3(black),
                ),
                Text(' dd/mm/yyyy', style: headLine4(black)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Gender:', style: bodyText3(black)),
                Text(' Female', style: headLine4(black)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Father\'s Name:', style: bodyText3(black)),
                Text(' John Doe', style: headLine4(black)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Mother\'s Name:', style: bodyText3(black)),
                Text(' Janet Doe', style: headLine4(black)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Phone Number:', style: bodyText3(black)),
                Text(' +234123456789', style: headLine4(black)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Email Address:', style: bodyText3(black)),
                Text(' example@gmail.com', style: headLine4(black)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Home Address:', style: bodyText3(black)),
                SizedBox(
                    width: 150,
                    child: Text(' 12, XYZ street, LA',
                        overflow: TextOverflow.fade, style: headLine4(black))),
              ],
            ),
          ]),
        ));
  }
}

class NextOfKinContainer extends StatelessWidget {
  const NextOfKinContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        color: lightBlue,
        height: 500,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('images/people.svg'),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Next of Kin',
                      style: headLine3(black),
                    ),
                  ],
                ),
                SvgPicture.asset('images/edit.svg'),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text('Name of Next of Kin:', style: bodyText3(black)),
                Text(' John Doe', style: headLine4(black)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('DOB:', style: bodyText3(black)),
                Text(' dd/mm/yyyy', style: headLine4(black)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Gender:', style: bodyText3(black)),
                Text(' Male', style: headLine4(black)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Relationship:', style: bodyText3(black)),
                Text(' Father', style: headLine4(black)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Home Address:', style: bodyText3(black)),
                SizedBox(
                    width: 150,
                    child: Text(' 12, XYZ street, LA',
                        overflow: TextOverflow.fade, style: headLine4(black))),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Phone Number:', style: bodyText3(black)),
                Text(' +234123456789', style: headLine4(black)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Email Address:', style: bodyText3(black)),
                Text(' example@gmail.com', style: headLine4(black)),
              ],
            ),
          ]),
        ));
  }
}

class OtherInfo extends StatelessWidget {
  const OtherInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
        color: lightBlue,
        height: 350,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('images/more.svg'),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Other Info',
                      style: headLine3(black),
                    ),
                  ],
                ),
                SvgPicture.asset('images/edit.svg'),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text('Blood Type:', style: bodyText3(black)),
                Text(' O Positive', style: headLine4(black)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Genetotype', style: bodyText3(black)),
                Text(' AA', style: headLine4(black)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Health Insurance Agency', style: bodyText3(black)),
                Text(' NHIS', style: headLine4(black)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Religion:', style: bodyText3(black)),
                Text(' Christainity', style: headLine4(black)),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Occupation:', style: bodyText3(black)),
                SizedBox(
                    width: 200,
                    child: Text('Fashion designer',
                        overflow: TextOverflow.fade, style: headLine4(black))),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
          ]),
        ));
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 1,
      color: Colors.grey,
    );
  }
}
