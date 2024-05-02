import 'package:flutter/material.dart';

class MobileMoneyPasswordBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Enter Mobile Money  Password'),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              hintText: 'Password',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Add your confirmation logic here
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (context) {
                    return MoneySuccessDialog();
                  },
                );
              },
              child: Text('Confirm'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MoneySuccessDialog extends StatelessWidget {
  const MoneySuccessDialog({super.key});

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
            'Success',
            style: TextStyle(
                color: Colors.blue, fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
      content: Text('Successfully payed for water bill'),
      actions: <Widget>[
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                minimumSize: Size(double.infinity, 50),
              ),
            ))
          ],
        )
      ],
    );
  }
}
