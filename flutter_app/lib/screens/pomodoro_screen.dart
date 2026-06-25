import 'dart:async';
import 'package:flutter/material.dart';

class PomodoroScreen extends StatefulWidget {
  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  static const int focusTime = 25 * 60;
  static const int breakTime = 5 * 60;

  int remainingSeconds = focusTime;
  bool isRunning = false;
  bool isFocusMode = true;
  Timer? timer;

  void startTimer() {
    if (isRunning) return;

    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        switchMode();
      }
    });

    setState(() {
      isRunning = true;
    });
  }

  void pauseTimer() {
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void resetTimer() {
    timer?.cancel();
    setState(() {
      isRunning = false;
      isFocusMode = true;
      remainingSeconds = focusTime;
    });
  }

  void switchMode() {
    timer?.cancel();

    setState(() {
      isFocusMode = !isFocusMode;
      remainingSeconds = isFocusMode ? focusTime : breakTime;
      isRunning = false;
    });

    startTimer();
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("⏱ Pomodoro Focus"),
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              isFocusMode ? "🔥 Focus Time" : "☕ Break Time",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            Text(
              formatTime(remainingSeconds),
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 40),

            // Progress circle
            SizedBox(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(
                value: isFocusMode
                    ? remainingSeconds / focusTime
                    : remainingSeconds / breakTime,
                strokeWidth: 8,
              ),
            ),

            SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ElevatedButton(
                  onPressed: startTimer,
                  child: Text("Start"),
                ),

                SizedBox(width: 10),

                ElevatedButton(
                  onPressed: pauseTimer,
                  child: Text("Pause"),
                ),

                SizedBox(width: 10),

                ElevatedButton(
                  onPressed: resetTimer,
                  child: Text("Reset"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}