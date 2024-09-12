import 'package:flutter/foundation.dart';
import 'package:todo/models/user_model.dart';

class UserProvider with ChangeNotifier{
  UserModel? currentUser;
  void updatUser(UserModel? user){
    currentUser = user;
    notifyListeners();
  }
}