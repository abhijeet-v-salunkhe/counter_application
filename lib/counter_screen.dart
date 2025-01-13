import 'package:couter_application/authentication/domain/authentication_service.dart';
import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CounterScreenState();
  }
}

class _CounterScreenState extends State<CounterScreen> {
  int counter = 0;
  final authenticationService = AuthenticationService();

  void incrementCouter() {
    setState(() {
      counter += 1;
    });
  }

  void decrementCouter() {
    setState(() {
      counter == 0 ? 0 : counter -= 1;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter App"),
        actions: [IconButton(onPressed: authenticationService.logOut, icon: Icon(Icons.logout))],
      ),
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            IconButton(
              onPressed: incrementCouter,
              icon: Icon(Icons.add),
              iconSize: 50.0,
              color: const Color.fromARGB(255, 46, 227, 148),
            ),
            SizedBox(width: 20),
            Text("Counter : $counter", style: TextStyle(fontSize: 30)),
            SizedBox(width: 20),
            IconButton(
              onPressed: decrementCouter,
              icon: Icon(Icons.remove),
              iconSize: 50.0,
              color: const Color.fromARGB(255, 255, 0, 0),
            ),
          ],
        ),
      ),
    );
  }
}
