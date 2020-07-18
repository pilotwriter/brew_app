import 'package:brew_app/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:brew_app/screens/register.dart';


class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
    //it is a jump between sigin and signup pages
    //we change which page will be show easly changing the boolean value


  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn == true){
      return SignIn(toggleView:toggleView);
    }
    else {
      return Register(toggleView:toggleView);
    }
  }
}
