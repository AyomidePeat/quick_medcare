import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quick_medcare/utils/colors.dart';
import 'package:quick_medcare/utils/textstyle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String currentDate =
        DateFormat(' EEEE, MMMM dd, yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: false,
          elevation: 0,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [CircleAvatar(), Icon(Icons.notifications_none_sharp)],
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How is your health today?',
              overflow: TextOverflow.fade,
              style: headline1(context),
            ),
            const SizedBox(height: 10),
            Text(currentDate,
                style: const TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 230, 225, 225),
                    fontFamily: 'Poppins-Regular')),
            const SizedBox(height: 25),
            Text(
              'Upcoming appointment',
              style: bodyText2(context),
            ),
            const SizedBox(height: 15),
            Container(
              height: size.height * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: blue,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dr. Christabel Heritage ',
                              style: bodyText4(context),
                            ),
                            Text('10:30AM. General Consultation',
                                style: bodyText5(context))
                          ],
                        )
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 41, 86, 233)),
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text('Starts in 2 mins'),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.grey,
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                    color: blue, borderRadius: BorderRadius.circular(10)),
                tabs: [
                  Tab(
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 0.4),
                      ),
                      child: const Align(
                          alignment: Alignment.center,
                          child: Text('Gynaecologists')),
                    ),
                  ),
                  Tab(
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 0.4),
                      ),
                      child: const Align(
                          alignment: Alignment.center,
                          child: Text('Neuroloists')),
                    ),
                  ),
                  Tab(
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 0.4),
                      ),
                      child: const Align(
                          alignment: Alignment.center,
                          child: Text('Dermatologists')),
                    ),
                  ),
                  Tab(
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey, width: 0.4),
                      ),
                      child: const Align(
                          alignment: Alignment.center,
                          child: Text('Ophthalmologists')),
                    ),
                  ),
                ])
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: blue,
          tooltip: 'Book Appointment',
          child: const Icon(Icons.add)),
    );
  }
}
