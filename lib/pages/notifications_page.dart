import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();

  static const route='/notification-screen';
}

class _NotificationPageState extends State<NotificationPage> {
  // Sample notification data

  DatabaseReference _usersData =
      FirebaseDatabase.instance.ref().child('users').child('mtui');
      List<Map<Object?, Object?>> filteredEntries = [];
  final List<Map<String, dynamic>> notificationData = [
    {
      'title': 'Notification 1',
      'description':
          'It seems today you have used above 15 units which is your daily average',
      'time': '10:00 AM',
      'date': 'Today'
    },
    {
      'title': 'Notification 1',
      'description':
          'It seems today you have used above 15 units which is your daily average',
      'time': '01:00 PM',
      'date': 'Today'
    },
    {
      'title': 'Notification 2',
      'description':
          'It seems today you have used above 15 units which is your daily average',
      'time': 'Yesterday',
      'date': 'Yesterday'
    },
    {
      'title': 'Notification 3',
      'description':
          'It seems today you have used above 15 units which is your daily average',
      'time': '02/04/2024',
      'date': '02/04/2024'
    },
  ];

  final List<String> filterOptions = [
    'All',
    'Today',
    'Last Week',
    'Last Month',
    'Last Year'
  ];

// Selected filter option
  String selectedFilter = 'All';

  // method to fetch the occurred notifications
  void fetchNotifications() async {
    DataSnapshot snapshot1 = await _usersData.child('tamper_notifications').get();
    Map<Object?, Object?> userData = snapshot1.value as Map<Object?, Object?>;
    print(userData);
   
    if(userData!=null){
      filteredEntries.clear();
      filteredEntries.add(userData);
    }
   
  }

@override
  void initState() {
    super.initState();
    fetchNotifications();
  }
  @override
  Widget build(BuildContext context) {
    // for notifications
    fetchNotifications();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedFilter,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedFilter = newValue;
                  });

                  // You can filter notification data here based on the selected filter
                  // For now, just print the selected filter
                  print('Selected filter: $selectedFilter');
                }
              },
              items:
                  filterOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredEntries.length,
              itemBuilder: (BuildContext context, int index) {
                final Map<Object?, dynamic> notification =
                    filteredEntries[index];
                final String title = 'Warning';
                final String description = notification['message'];
                // final String time = notification['time'];
                // final String date = notification['date'];

                return Container(
                  margin: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: const Color(0xff2c2b2b)),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.notification_important),
                    title: Text(
                      'title',
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(description),
                    trailing: Text('time'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
