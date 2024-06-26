import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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
 

  final progressBarCenterTextStyle = const TextStyle(
    fontSize: 40,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  //fetch data of the user 
  DatabaseReference _usersData =
      FirebaseDatabase.instance.ref().child('users').child('mtui');
  double remainingUnit = 10;
  Map<Object?, Object?> userData = {};
  Map<Object?, Object?> rawMap = {};
  DatabaseReference _testRef = FirebaseDatabase.instance.ref().child('bills');
   double totalUnits =20;
  //function to fetch the user data
 void fetchUserInfo() async {
    DataSnapshot snapshot1 = await _usersData.get();
    userData = snapshot1.value as Map<Object?, Object?>;

    setState(() {
      remainingUnit = double.parse(userData['Units'].toString()!);
    });

    print(remainingUnit);

//fetching the total units for the bills 
      DataSnapshot snapshot = await _testRef.child('mtui').get();
    rawMap = snapshot.value as Map<Object?, Object?>;
    // getting the total units bought from the begenning
      setState(
        (){
         totalUnits=double.parse(rawMap['total_units_bought'].toString());
        }
      );

  }

  @override
  void initState() {
    super.initState();
   fetchUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    // screen width
    fetchUserInfo();
    double screeWidth = MediaQuery.of(context).size.width;
    totalUnits=double.parse(rawMap['total_units_bought'].toString());
     remainingUnit = double.parse(userData['Units'].toString()!);
     final double  totalUnit=totalUnits;
    final double  percent =(totalUnits-remainingUnit)*100/totalUnits;
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
                "Good Afternoon , Mtui",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                "Meter Id:  003-mtui",
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
                 
                  SizedBox(
                    width: 100.0, // Set the width here
                    height: 100.0,
                    child: CircularProgressIndicator(
                      value:
                          (totalUnits-remainingUnit)/totalUnits, // Set the progress value here (between 0.0 and 1.0)
                      strokeWidth: 25.0,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  ),
                  //
                   Text(
                    ' Used Up : ${percent.round()} %',
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
              builder: (context) => ViewBillsPage(),
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
