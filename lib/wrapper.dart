import 'package:couter_application/authentication/view/login.dart';
import 'package:couter_application/counter_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<StatefulWidget> createState() {
    return _WrapperState();
  }
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          print("In the builder function...................********************++++++++++++++++++++++++++++++++++++++++++++++++++++");
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return CircularProgressIndicator();
          // } else{
            if (snapshot.hasData) {
              // User is signed in
              return CounterScreen();
            } else {
              return Login();
            }
          //}
        },
      ),
    );
  }
}
