import 'package:brew_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:brew_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:brew_app/screens/brew_list.dart';
import 'package:brew_app/models/brew.dart';
import 'package:brew_app/screens/settings_form.dart';
class Home extends StatelessWidget {

  final AuthService _auth  =AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel(){
      //this is a special flutter method that shows the bottom pop-up
      showModalBottomSheet(context: context, builder:(context){
        return SettingsForm();
      });
    }



    //database içerisindeki brews() fonksiyonunu çağırıyor
    //böylece databasedeki değişikliklere ulaşıyor!
    //list<Brew> returned
    return StreamProvider<List<Brew>>.value(
      value:DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.grey[700],
        appBar: AppBar(
          title: Text('Welcome to Main Page'),
          elevation: 0.0,
          backgroundColor: Colors.grey[600],

          actions: <Widget>[
            FlatButton.icon(onPressed:() async {
              await _auth.signOut();


            }, icon: Icon(Icons.person), label: Text('Logout')),
            FlatButton.icon(onPressed: (){
              _showSettingsPanel();

            }, icon: Icon(Icons.settings), label: Text('settings')),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
