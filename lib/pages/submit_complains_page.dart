
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SubmitComplainsPage extends StatefulWidget {
  const SubmitComplainsPage({Key? key}) : super(key: key);

  @override
  State<SubmitComplainsPage> createState() => _SubmitComplainsPageState();
}

class _SubmitComplainsPageState extends State<SubmitComplainsPage> {
  double _scale = 1.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Submit Complains",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              const SizedBox(height: 40),
              const Text(
                "Name",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    hintText: "0********",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.grey))),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Email",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: "Enter your email",
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.grey))),
              ),
              const SizedBox(
                height: 12.0,
              ),
              const Text(
                "Share your experience in scaling",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 12.0,
              ),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              const SizedBox(
                height: 12.0,
              ),
              InteractiveViewer(
                boundaryMargin: EdgeInsets.all(20),
                minScale: 0.1,
                maxScale: 3.0,
                onInteractionUpdate: (ScaleUpdateDetails details) {
                  setState(() {
                    _scale = details.scale;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey), // Add border
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: 'Enter your comment here...',
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.all(10.0), // Padding inside the TextField
                    ),
                    style: TextStyle(fontSize: 16 * _scale),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                  onPressed: () {
                    //TODO: submit complains  logic here
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
