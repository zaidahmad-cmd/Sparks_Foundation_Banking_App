import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Center(child: SizedBox(height: 300)),
                ],
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/bank');
                  },
                  child: Text("Show All Users"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
