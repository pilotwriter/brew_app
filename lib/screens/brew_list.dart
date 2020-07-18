import 'package:brew_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:brew_app/models/brew.dart';
import 'package:brew_app/screens/brew_tile.dart';



class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of< List<Brew>>(context) ?? [];
    //print(brews.documents);


    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context,index){
        return BrewTile(brew:brews[index]);
      },



    );
  }
}
