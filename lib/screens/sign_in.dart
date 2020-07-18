import 'package:brew_app/screens/authenticate.dart';
import 'package:brew_app/screens/register.dart';
import 'package:brew_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_app/services/auth.dart';
import 'package:brew_app/shared/loading.dart';


class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //we follow the process of a form with form key
  final _formkey = GlobalKey<FormState>();
  //auth service is used to signin
  final AuthService _auth = AuthService();
  String email;
  String password;
String error = '';
//show loading page during process
bool loading = false;


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :  Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        elevation: 0.0,
        title: Text('Sign In'),

        actions: <Widget>[
          FlatButton.icon(onPressed: (){
            widget.toggleView();

          }, icon: Icon(Icons.add_circle),
              color:Colors.tealAccent[200],
              label: Text('Create an Account')),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50,vertical: 20),
        //form starts here!
        child: Form(
          key: _formkey,
          child:Column(
            children: <Widget>[
              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  hintText:'Email',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
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
                validator: (val)=> val.isEmpty ? 'Enter an Email' : null,
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                  },

              ),
              SizedBox(height: 20,),
              TextFormField(decoration: InputDecoration(
                hintText:'Password',
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
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
                validator: (val)=> val.length < 6 ? 'Enter your password' : null,

                onChanged: (val){
                  setState(() {
                    password = val;
                  });
                },
                obscureText: true,


              ),
              SizedBox(height: 20,),
              RaisedButton(
                  splashColor: Colors.red,
                color:Colors.tealAccent[200],
                child: Text('Sign in',
                style: TextStyle(

                ),
                ),
                onPressed: () async{
                    //make a backend call to sign_in
                   if(_formkey.currentState.validate()){
                     //if the form is valid
                     setState(() {
                       //show loading page
                       loading=true;
                       //for loading page to show
                     });

                     dynamic result = await _auth.loginWithEmailAndPassword(email, password);
                     //if it is succesfull,it will automaticly direct to main page
                     //because we are keep checking status of user and according to that
                     //routing our user,check main.dart
                     if(result == null){
                       setState(() {
                         loading=false;
                         //değer boşsa loading pageyi göstermesin!
                         error = 'Please check your credentials again';
                       });
                     }

                    }
                   else{
                     print('not valid form');

                   }
                },

              ),

              Text(error,
              style: TextStyle(
                fontSize: 28,
                color: Colors.red,

              ),)

            ],
          ),

        ),

      ),

    );
  }
}
