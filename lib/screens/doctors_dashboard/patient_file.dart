import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_medcare/screens/patient_dashboard/chat_screen.dart';
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
          style: headline4(),
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
                      style: headline4(),
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
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context)=>ChatScreen()));
                },
                child: Text(
                  'Continue to Chat',
                  style: bodyText4(context),
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
                      style: headline3(context),
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
                  style: bodyText7(),
                ),
                Text(' 42', style: headline4()),
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
                  style: bodyText7(),
                ),
                Text(' dd/mm/yyyy', style: headline4()),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Gender:', style: bodyText7()),
                Text(' Female', style: headline4()),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Father\'s Name:', style: bodyText7()),
                Text(' John Doe', style: headline4()),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Mother\'s Name:', style: bodyText7()),
                Text(' Janet Doe', style: headline4()),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Phone Number:', style: bodyText7()),
                Text(' +234123456789', style: headline4()),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Email Address:', style: bodyText7()),
                Text(' example@gmail.com', style: headline4()),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Home Address:', style: bodyText7()),
                SizedBox(
                    width: 150,
                    child: Text(' 12, XYZ street, LA',
                        overflow: TextOverflow.fade, style: headline4())),
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
                      style: headline3(context),
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
                Text('Name of Next of Kin:', style: bodyText7()),
                Text(' John Doe', style: headline4()),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('DOB:', style: bodyText7()),
                Text(' dd/mm/yyyy', style: headline4()),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Gender:', style: bodyText7()),
                Text(' Male', style: headline4()),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Relationship:', style: bodyText7()),
                Text(' Father', style: headline4()),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Home Address:', style: bodyText7()),
                SizedBox(
                    width: 150,
                    child: Text(' 12, XYZ street, LA',
                        overflow: TextOverflow.fade, style: headline4())),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Phone Number:', style: bodyText7()),
                Text(' +234123456789', style: headline4()),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Email Address:', style: bodyText7()),
                Text(' example@gmail.com', style: headline4()),
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
                      style: headline3(context),
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
                Text('Blood Type:', style: bodyText7()),
                Text(' O Positive', style: headline4()),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Genetotype', style: bodyText7()),
                Text(' AA', style: headline4()),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Health Insurance Agency', style: bodyText7()),
                Text(' NHIS', style: headline4()),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Religion:', style: bodyText7()),
                Text(' Christainity', style: headline4()),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: CustomDivider(),
            ),
            Row(
              children: [
                Text('Occupation:', style: bodyText7()),
                SizedBox(
                    width: 200,
                    child: Text('Fashion designer',
                        overflow: TextOverflow.fade, style: headline4())),
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
