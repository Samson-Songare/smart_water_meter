import 'package:flutter/material.dart';
import 'package:smart_water_meter/pages/login_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculate the desired image size based on the screen width
    double imageSize =
        screenWidth * 0.7; // You can adjust this factor as needed
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 8.0),
            child: Text(
              'WaterTrack \n App',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 8),
          Image.asset(
            'images/water.jpg',
            height: imageSize,
            width: imageSize,
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 8.0),
            child: Text(
              'Track Your Water Usage',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 5.0, 8.0, 8.0),
            child: Text(
              'With WaterTrack you can easily Monitor and manage your daily water consumption, Stat informed about your usage, Pay bills and Receive notification for unusal activity',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 100,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // specify corner radius
                  ),
                ),
                onPressed: () {
                  //Navigate to Login page
                  // TODO: later replace this with provider route
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: const Text(
                  "Start Tracking",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
