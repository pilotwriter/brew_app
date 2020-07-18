import 'package:brew_app/screens/wrapper.dart';
import 'package:brew_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_app/models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //streamprovider backendden data çeken nehir gibi,userı alıp wrapperin içine atıyor ve kontrol ediyor
    return StreamProvider<User>.value(
      value:AuthService().user,


      child: MaterialApp(
        home:Wrapper(),



      ),
    );
  }
}
