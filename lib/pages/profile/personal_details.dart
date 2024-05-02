import 'package:flutter/material.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const SizedBox(height: 32),
                    const Text(
                      "Firstname",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.grey))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Surname",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.grey))),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "email",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.grey))),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    const Text(
                      "Phone number",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.grey))),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 35,
                child: ElevatedButton(
                  onPressed: () {
                    // Add your button functionality here
                    print('Button pressed!');
                  },
                  child: Text('Apply'),
                ),
              ),
            ]),
      ),
    );
  }
}
