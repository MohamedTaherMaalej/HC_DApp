import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hc_dapp/Utils/routes.dart';

class Splash2 extends StatefulWidget {
  const Splash2({Key? key}) : super(key: key);

  @override
  State<Splash2> createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () =>
            Navigator.pushReplacementNamed(context, MyRoutes.splashScreenPage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                ),
                child: Center(
                  child: SizedBox(
                    width: 125,
                    height: 150,
                    child: Image.asset(
                      'assets/icons/logo_mydoc.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
