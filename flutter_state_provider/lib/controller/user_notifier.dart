import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_state_provider/model/user.dart';

class UserNotifier extends ChangeNotifier {
  List<User> _userList = [];
  int _age = 0;
  int _height = 0;

  UnmodifiableListView<User> get userList => UnmodifiableListView(_userList);

  addUser(User user) {
    _userList.add(user);
    notifyListeners(); // change notifier
  }

  deleteUser(index) {
    _userList.removeWhere((_user) => _user.name == _userList[index].name);
    notifyListeners();
  }

  incrementAge() {
    _age++;
    notifyListeners();
  }

  incrementHeight() {
    _height++;
    notifyListeners();
  }
}
