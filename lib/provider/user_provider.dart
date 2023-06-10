import 'package:flutter/material.dart';
import 'package:instagram/firebase_services/auth.dart';
import 'package:instagram/model/user.dart';
class UserProvider with ChangeNotifier {
  UserData? _userData;
  UserData? get getUser => _userData;

  refreshUser() async {
    UserData userData = await Authentication().getUserDetails();
    _userData = userData;
    notifyListeners();
  }
}