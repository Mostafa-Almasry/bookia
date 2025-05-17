import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  pushTo(Widget widget) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => widget));
  }

  pushReplacement(Widget widget) {
    Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  pushAndRemoveUntil(Widget widget) {
    Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );
  }
}

bool isEmailValid(String value) {
  return RegExp(r'^[\w\-\.]+@([\w-]+\.)+[\w-]{2,}$').hasMatch(value);
}
