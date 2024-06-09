import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:smart_water_meter/pages/notifications_page.dart';
import 'package:smart_water_meter/pages/profile/profile_page.dart';
import 'package:smart_water_meter/pages/submit_complains_page.dart';
import 'package:smart_water_meter/pages/view_bills_page.dart';
import 'package:smart_water_meter/pages/weekly_report.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ValueNotifier<double> valueNotifier;

  final progressBarCenterTextStyle = const TextStyle(
    fontSize: 40,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  @override
  void initState() {
    super.initState();
    // initialize the value notifier
    // TODO: change this value using data passed to it
    valueNotifier = ValueNotifier(75.0);
  }

  @override
  Widget build(BuildContext context) {
    // screen width
    double screeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 1),
        child: AppBar(
          centerTitle: false,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(height: 1, color: const Color(0xff464242)),
          ),
          title: const Column(
            children: [
              Text(
                "Good Afternoon , Samson",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                "Meter No:  4512780512",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          actions: [
            // TODO: add here the image of user which will be clickable
            GestureDetector(
              child: const CircleAvatar(
                child: Icon(
                  Icons.person_2,
                ),
              ),
              onTap: () {
                //TODO: go to the profile screen on click
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ));
              },
            )
          ],
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: screeWidth,
            height: screeWidth * 0.6,
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "120 Units",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  SimpleCircularProgressBar(
                    size: 120,
                    valueNotifier: valueNotifier,
                    progressStrokeWidth: 24,
                    backStrokeWidth: 24,
                    mergeMode: true,
                    onGetText: (value) {
                      return Text(
                        '${value.toInt()}%',
                        style: progressBarCenterTextStyle,
                      );
                    },
                    progressColors: const [Colors.green],
                    backColor: Colors.white,
                  ),
                  //
                  const Text(
                    " Used Up Until :13th February, 2021",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ]),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const HomeContainer(
                containerIcon: Icon(Icons.graphic_eq),
                containerText: "View Weekly Reports",
              ),
              const HomeContainer(
                containerIcon: Icon(Icons.payment_outlined),
                containerText: "View Bills",
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const HomeContainer(
                containerIcon: Icon(Icons.message),
                containerText: "Submit Complains",
              ),
              const HomeContainer(
                containerIcon: Icon(Icons.notification_add),
                containerText: "Notifications",
              ),
            ],
          )
        ],
      ),
    );
  }
}

//home container for each link to the specified page
class HomeContainer extends StatelessWidget {
  const HomeContainer(
      {super.key, required this.containerText, required this.containerIcon});

  final String containerText;
  final Icon containerIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // when the widget is pressed
        // navigate to page according to container texts
        // TODO:later use provider here
        switch (containerText) {
          case "View Weekly Reports":
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const WeeklyReports(),
            ));
            break;
          case "Submit Complains":
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const SubmitComplainsPage(),
            ));
            break;
          case "View Bills":
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>  ViewBillsPage(),
            ));
            break;
          case "Notifications":
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NotificationPage(),
            ));
            break;
        }
      },
      child: Container(
        width: 153,
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0), color: Colors.grey),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.graphic_eq,
              size: 60,
            ),
            Text(
              containerText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
