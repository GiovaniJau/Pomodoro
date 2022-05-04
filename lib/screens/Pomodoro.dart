// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pomodoro/resources/constants.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({Key? key}) : super(key: key);

  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();

  double percent = 0;
  int timerRunning = 0;
  int currentTimer = 25;

  late Timer timer;

  void _initPlayer() {
    audioPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: audioPlayer);
  }

  void _playSound(String assetSound) {
    audioCache.play(assetSound);
    _startTimer();
  }

  void _startTimer() {
    timerRunning = currentTimer;
    int Time = timerRunning * 60;
    double SecPercent = (Time/100);

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if(Time > 0){
          Time--;
          if(Time % SecPercent == 0){
            if(percent < 1){
              percent += 0.01;
            }else {
              percent = 1;
            }
          }
        } else {
          percent = 0;
          timer.cancel();

          if (currentTimer == 25) {
            currentTimer = 5;
            _playSound('sounds/sound_1.mp3');
          } else {
            currentTimer = 25;
            _playSound('sounds/sound_2.mp3');
          }
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _initPlayer();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();

    audioCache.clearAll();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF1B5E20), Color(0xFFF1F8B9)],
                  begin: FractionalOffset(0.5,1)
              )
          ),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              const Text(kAppTitle, style: kTextTitleStyle),
              const SizedBox(height: 30.0,),
              CircularPercentIndicator(
                percent: percent,
                animation: true,
                animateFromLastPercent: true,
                radius: MediaQuery.of(context).size.width / 2.75,
                lineWidth: 30.0,
                progressColor: Colors.red,
                backgroundColor: Colors.red.shade200,
                center: Text("$currentTimer", style: kNumberStyle),
              ),
              const SizedBox(height: 50.0,),
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(30.0), topLeft: Radius.circular(30.0))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: const [
                                    Text(kFocusedTime, style: kTextAccentStyle),
                                    SizedBox(height: 10.0,),
                                    Text(kFocusedMinutes, style: kNumberStyle)
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: const [
                                    Text(kBreakTime, style: kTextAccentStyle),
                                    SizedBox(height: 10.0,),
                                    Text(kBreakMinutes, style: kNumberStyle)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(kBackButtom, style: kTextButtomStyle),
                  style: ElevatedButton.styleFrom(fixedSize: Size(MediaQuery.of(context).size.width, 50)),
              )
            ],
          ),
        ),
      ),
    );
  }
}