import 'package:flutter/material.dart';

class OnboardingController extends ChangeNotifier {
  bool _isActionInProgress = false;

  bool get isActionInProgress => _isActionInProgress;

  void startAction() {
    _isActionInProgress = true;
    notifyListeners();
  }

  void endAction() {
    _isActionInProgress = false;
    notifyListeners();
  }
}
