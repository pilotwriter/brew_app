import 'package:brew_app/screens/authenticate.dart';
import 'package:brew_app/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'package:brew_app/models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return either home or authenicate widget
      final user = Provider.of<User>(context);
      //home sended us to here with user object. İf it is empty it means user must login,otherwise we show home page!

      if(user == null){
        return Authenticate();
      }
      else{
        return Home();
      }
  }
}
