import 'dart:io';

import 'package:flutter/material.dart';

class MyModel extends ChangeNotifier {
  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }
}
