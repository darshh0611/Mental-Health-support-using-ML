import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../colors.dart';
import '../home.dart';


class PomodoroTimer extends StatefulWidget {
  @override
  _PomodoroTimerState createState() => _PomodoroTimerState();
}

class _PomodoroTimerState extends State<PomodoroTimer> {
  int _duration = 25 * 60;
  bool _isRunning = false;
  String _message = 'Ready to start';

  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  AppBar appBar() {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage(userId: '',)));
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          width: 37,
          child: SvgPicture.asset(
            'assets/icons/Arrow - Left 2.svg',
            height: 25,
            width: 25,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      title: const Text(
        'Pomodoro!',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
              height: 5,
              width: 5,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Wrap your widget in a Scaffold
      appBar: appBar(),
      body: Container(
        color: AppColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _formatDuration(_duration),
              style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 20),
            Text(
              _message,
              style: TextStyle(fontSize: 24, color: AppColors.black),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_isRunning) {
                  stopTimer();
                } else {
                  startTimer(_duration);
                }
              },
              style: ElevatedButton.styleFrom(
                primary: _isRunning ? AppColors.primary : AppColors.secondary,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text(
                _isRunning ? 'Stop' : 'Start',
                style: TextStyle(fontSize: 20, color: AppColors.white),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    startTimer(5 * 60);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.primary,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(
                    'Short Break',
                    style: TextStyle(fontSize: 16, color: AppColors.white),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    startTimer(15 * 60);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.primary,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(
                    'Long Break',
                    style: TextStyle(fontSize: 16, color: AppColors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: resetTimer,
              style: ElevatedButton.styleFrom(
                primary: AppColors.secondary,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text(
                'Reset',
                style: TextStyle(fontSize: 20, color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void startTimer(int duration) {
    _isRunning = true;
    _message = 'Work in progress...';
    _duration = duration;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_duration > 0) {
        setState(() {
          _duration -= 1;
        });
      } else {
        stopTimer();
        _message = 'Break is over!';
      }
    });
  }

  void stopTimer() {
    _isRunning = false;
    _timer.cancel();
    _message = 'Timer paused';
  }

  void resetTimer() {
    _isRunning = false;
    _timer.cancel();
    setState(() {
      _duration = 25 * 60;
      _message = 'Ready to start';
    });
  }
}
