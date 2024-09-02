import 'dart:async';
import 'package:flutter/material.dart';

class ForgotPasswordResendTimer extends ChangeNotifier {
  int _resendTime;
  bool _canResend;
  late Timer _timer;

  ForgotPasswordResendTimer({required int initialResendTime})
      : _resendTime = initialResendTime,
        _canResend = initialResendTime == 0 {
    if (!_canResend) {
      _startTimer();
    }
  }

  int get resendTime => _resendTime;
  bool get canResend => _canResend;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_resendTime > 0) {
        _resendTime--;
        notifyListeners();
      } else {
        _canResend = true;
        notifyListeners();
        _timer.cancel();
      }
    });
  }

  void resetTimer(int initialResendTime) {
    _resendTime = initialResendTime;
    _canResend = false;
    notifyListeners();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
