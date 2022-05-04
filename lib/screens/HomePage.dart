import 'package:flutter/material.dart';
import 'package:pomodoro/resources/constants.dart';
import 'package:pomodoro/screens/Pomodoro.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppTitle),
      ),
      body: GestureDetector(
        child: Container(
          color: Colors.lightGreen.shade200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                child: Image.asset("assets/images/pomodoro.png", fit: BoxFit.scaleDown,),
              ),
              const Text(kClickToStart, style: kTextStyle,)
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Pomodoro()));
        },
      )
    );
  }
}
