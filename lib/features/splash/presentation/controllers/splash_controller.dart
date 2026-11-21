import 'package:flutter/material.dart';

class SplashController extends ChangeNotifier {
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  SplashController({
    Duration delay = const Duration(milliseconds: 150),
  }) {
    Future.delayed(delay, () {
      _isLoaded = true;
      notifyListeners();
    });
  }

  void setLoaded(bool value) {
    if (_isLoaded != value) {
      _isLoaded = value;
      notifyListeners();
    }
  }
}
