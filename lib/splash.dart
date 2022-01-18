import 'dart:async';
import 'package:flutter/material.dart';
import 'package:traveller/onboarding.dart';
import 'utils.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Onboarding(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: context.height(.15),
                child: Image.asset(
                  'assets/icons/logo.png',
                  height: context.width(.25),
                  width: context.width(.25),
                ),
              ),
              Text(
                "Traveller",
                style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.w500,
                    fontSize: context.width(.15)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
