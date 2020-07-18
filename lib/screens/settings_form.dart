import 'package:brew_app/models/user.dart';
import 'package:brew_app/services/database.dart';
import 'package:brew_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
    final formkey = GlobalKey<FormState>();
    final List<String> sugars =['0','1','2','3','4'];

    String _currentName;
    String _currentSugars;
    int _currentStrength;



    @override
  Widget build(BuildContext context) {
      final user = Provider.of<User>(context);

      return StreamBuilder<UserData>(
      stream: DatabaseService(uid:user.uid).userData,
      builder: (context, snapshot) {
        UserData userData = snapshot.data;

        if(snapshot.hasData){
          return Form(
            key:formkey,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(

                children: <Widget>[
                  Text('Update your brew settings',style: TextStyle(
                    fontSize: 18,

                  ),),
                  SizedBox(height: 20,),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: InputDecoration(
                      hintText:userData.name,
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:Colors.tealAccent[200],
                            width: 2,
                          )
                      ),

                    ),
                    validator: (val)=> val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val){
                      setState(() {
                        _currentName = val;
                      });
                    },

                  ),
                  SizedBox(height: 20,),
                  //dropdown menu
                  DropdownButtonFormField(
                    decoration: InputDecoration(

                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color:Colors.tealAccent[200],
                            width: 2,
                          )
                      ),

                    ),
                    value: _currentSugars ??'0',
                    items:sugars.map((sugar){

                      return DropdownMenuItem(
                          value:sugar,
                          child:Text(
                              '$sugar sugars'
                          )
                      );
                    }).toList(),
                    onChanged: (value){
                      setState(() {
                        _currentSugars=value;
                      });
                    },

                  ),
                  SizedBox(height: 20,),
                  Slider(
                    activeColor: Colors.brown[_currentStrength ?? userData.strength],
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    min: 100,
                    max:900,
                    divisions: 8,
                    onChanged: (val)=>setState((){
                      _currentStrength = val.toInt();
                    }),
                  ),

                  //sileder
                  //button at
                  RaisedButton(
                    splashColor: Colors.red,
                    color:Colors.pink[200],
                    child: Text('Save',
                      style: TextStyle(

                      ),
                    ),
                    onPressed: ()async {
                    if(formkey.currentState.validate()){
                      await DatabaseService(uid:user.uid).updateUserData(
                      _currentSugars ?? userData.sugars,
                          _currentName ?? userData.name,
                          _currentStrength ?? userData.strength
                          );
                      Navigator.pop(context);
                    }
                    },
                  ),


                ],

              ),
            ),
          );

        }
        else{
          return Loading();
        }


      }
    );
  }
}
