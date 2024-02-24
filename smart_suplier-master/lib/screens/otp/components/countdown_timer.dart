import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_bin/constant.dart';
import 'package:smart_bin/widgets/text.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({Key? key}) : super(key: key);

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? countdownTimer;
  Duration myDuration = Duration(
    seconds: 10,
  );

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    countdownTimer?.cancel();
    super.dispose();
  }

  /// Timer related methods ///
  // Step 3
  void startTimer() {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(minutes: 2));
    startTimer();
  }

  // Step 6
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    final isResend=(countdownTimer == null || countdownTimer!.isActive);

    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
          onTap: () {
            if(!isResend){
              resetTimer();
              print(myDuration);
            }
          },
          child: Text(
            (isResend)
                ? "Resend in $minutes:$seconds"
                : 'Resend OTP',
            style: titleBlack18.copyWith(color: kPrimaryColor),
          )),
    );
  }
}
