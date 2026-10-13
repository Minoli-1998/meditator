import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meditator/models/sleep_exercise_model.dart';
import 'package:meditator/utils/colors.dart';

class SleepExerciseTimer extends StatefulWidget {
  final SleepExercise sleepExercise;
  const SleepExerciseTimer({super.key, required this.sleepExercise});

  @override
  State<SleepExerciseTimer> createState() => _SleepExerciseTimerState();
}

class _SleepExerciseTimerState extends State<SleepExerciseTimer> {
  // timer
  Timer? _timer;
  int _remaningTime = 0;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _remaningTime = widget.sleepExercise.duration * 60;
  }

  // start the timer
  void _startTimer() {
    // if there is a timer already running stop that
    if (_timer != null) {
      _timer!.cancel();
    }

    _isRunning = true;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remaningTime > 0) {
          _remaningTime--;
        } else {
          _timer!.cancel();
        }
      });
    });
  }

  void _pauseTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _isRunning = false;
    }
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }

    setState(() {
      _remaningTime = widget.sleepExercise.duration * 60;
      _isRunning = false;
    });
  }

  String _formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;

    return "$minutes:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sleep Story Timer",
          style: TextStyle(
            color: AppColors.primaryBlack,
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.sleepExercise.category,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryPurple,
                  ),
                ),

                SizedBox(height: 15),

                Text(
                  widget.sleepExercise.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlack,
                  ),
                ),

                SizedBox(height: 15),

                Text(
                  "Duration : ${widget.sleepExercise.duration} minutes",
                  style: TextStyle(fontSize: 16, color: AppColors.primaryGrey),
                ),

                SizedBox(height: 15),

                Text(
                  widget.sleepExercise.description,
                  style: TextStyle(fontSize: 16, color: AppColors.primaryGrey),
                ),

                SizedBox(height: 40),

                Center(
                  child: Column(
                    children: [
                      Text(
                        _formatTime(_remaningTime),
                        style: TextStyle(
                          fontSize: 40,
                          color: AppColors.primaryBlack,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (_isRunning) {
                                  _pauseTimer();
                                } else {
                                  _startTimer();
                                }
                              });
                            },
                            child: Text(
                              _isRunning
                                  ? "Pause"
                                  : (_remaningTime <
                                            widget.sleepExercise.duration * 60
                                        ? "Resume"
                                        : "Start"),
                            ),
                          ),

                          SizedBox(width: 20),

                          ElevatedButton(
                            onPressed: () {
                              _stopTimer();
                            },
                            child: Text("Stop"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
