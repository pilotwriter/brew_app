import 'package:flutter/material.dart';
import 'package:brew_app/services/auth.dart';
import 'package:brew_app/screens/authenticate.dart';
import 'package:brew_app/shared/loading.dart';


class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String email;
  String password;
  String error ='';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        elevation: 0.0,
        title: Text('Sign Up'),

        actions: <Widget>[
          FlatButton.icon(onPressed: (){
            widget.toggleView();




          }, icon: Icon(Icons.add_circle),
              color:Colors.tealAccent[200],
              label: Text('Have an Account?')),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50,vertical: 20),
        child: Form(
          key:_formkey,
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
              TextFormField(
                decoration: InputDecoration(
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
                child: Text('Register',
                  style: TextStyle(

                  ),
                ),
                onPressed: () async{
                  if(_formkey.currentState.validate()){
                    setState(() {
                      loading=true;
                    });
                    dynamic result = await _auth.registerWithEmail(email, password);
                    if(result == null){
                      setState(() {
                        loading=false;
                        error ='Please supply valid datas';
                      });

                    }

                  }
                  else{
                    print('not valid form');
                  }
                },

              ),
              SizedBox(height: 20,),
              Center(
                child: Text(error,
                style: TextStyle(
                  fontSize: 25,
                  color:Colors.red,
                  fontWeight: FontWeight.bold,
                ),),
              )

            ],
          ),

        ),
      ),

    );
  }
}
