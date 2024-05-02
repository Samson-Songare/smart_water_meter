import 'package:flutter/material.dart';
import 'package:smart_water_meter/pages/login_page.dart';
import 'package:smart_water_meter/pages/profile/personal_details.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
  final String _username = "Samson Doe";
  @override
  Widget build(BuildContext context) {
    double screeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          "Account",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: screeWidth,
            height: screeWidth * 0.6,
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 12.0,
                ),
                Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("images/sam.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: Icon(Icons.camera_alt_rounded,
                              color: Colors.black),
                          onPressed: () {
                            // Add functionality to edit the profile image
                            // For example, show a dialog to pick a new image.
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Text(
                  _username,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          GestureDetector(
            onTap: () {
              // when the Personal details is tapped
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PersonalDetails(),
              ));
            },
            child: const ListTile(
              tileColor: Color(0xfff4eded),
              leading: Text(
                "Personal Details",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          const SizedBox(
            height: 18.0,
          ),
          const ListTile(
            tileColor: Color(0xfff4eded),
            leading: Text(
              "Language",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const SizedBox(
            height: 18.0,
          ),
          const ListTile(
            tileColor: Color(0xfff4eded),
            leading: Text(
              "Notifications",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          const SizedBox(
            height: 18.0,
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return LogoutDialog();
                },
              );
            },
            child: const ListTile(
              tileColor: Color(0xfff4eded),
              leading: Text(
                "Sign out",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ],
      ),
    );
  }
}

class LogoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xfff1d9d7),
            ),
            child: Icon(
              Icons.warning,
              size: 50 *
                  0.6, // Adjust the size of the icon relative to the container
              color: Colors.red,
            ),
          ),
          Text(
            'Warning',
            style: TextStyle(
                color: Colors.blue, fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
      content: Text('Are you sure you want to logout?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            // Close the dialog
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Perform logout action
            // For example, you can navigate to the login screen
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => LoginPage(),
            ));
            // Add your logout logic here
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
