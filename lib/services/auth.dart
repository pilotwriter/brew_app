import 'package:brew_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_app/models/user.dart';
class AuthService{
//Auth işlemlerini yaparken kullandığımız FireBaseAuth objesi,bütün auth işlemleri
final FirebaseAuth _auth = FirebaseAuth.instance;



  //sigin anon
  //signin email-password
  //Register with email-password

//create user object based on firebase object
  User _userFromFirebaseUser(FirebaseUser user){
      //eğer user boş değilse User objesi oluştur ve uid olarak FireBaseUser'ın idsini gir
    return user != null ? User(uid:user.uid) : null;
  }


  //signinanon
  Future signInAnon() async {
try{
    AuthResult result = await _auth.signInAnonymously();
    FirebaseUser user = result.user;

    //basicly returning our User class object,not the FireBaseUser object
return _userFromFirebaseUser(user);

}
catch(e){
  print(e);
  print('there was an error');
  return null;

}
  }

  Future registerWithEmail(String email, String password) async{
try{


  AuthResult result =await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
  FirebaseUser user = result.user;
  //create a new document for the user with uid and p
  await DatabaseService(uid:user.uid).updateUserData('0 Sugar', 'new crew member', 100);
  return _userFromFirebaseUser(user);
}
catch(e){

  print(e.toString());
  return null;

}

  }

  Future loginWithEmailAndPassword (String email, String password) async {
    try{
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
    FirebaseUser user = result.user;
    return _userFromFirebaseUser(user);}
    catch(e){
      print(e.toString());
    }
  }

//auth change user stream callled at main
Stream<User> get user{
    //state change olduğunda FirebaseUser objesini bizim  User objesine döndürüp return eder!
    return _auth.onAuthStateChanged.map((FirebaseUser user ) => _userFromFirebaseUser(user));
    //   .map(_userFromFirebaseUser)  aynı işlemi yapar
}

//signout

Future signOut() async{

    try{


return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
}

}