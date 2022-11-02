import 'package:flutter/material.dart';

class InternetOff extends StatefulWidget {
  @override
  _InternetOffState createState() => _InternetOffState();
}

class _InternetOffState extends State<InternetOff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.wifi_off,
              size: 80,
              color: Colors.red,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Check You Internet Connection",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
