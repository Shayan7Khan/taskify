import 'package:flutter/material.dart';
import 'package:taskify/core/constants/enums.dart';

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.idle;

  ViewState get state => _state;

  void setState(state) {
    _state = state;
    notifyListeners();
  }
}
