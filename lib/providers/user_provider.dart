import 'package:flutter/foundation.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/services/auth_services.dart';

class UserProvider with ChangeNotifier {
  //
  UserModel? _userModel;
  UserModel get getUser => _userModel!;

  final AuthServices authServices = AuthServices();

  Future<void> refreshUser() async {
    UserModel user = await authServices.getUserDetails();
    _userModel = user;
    notifyListeners();
  }
}
