import 'package:brew_app/models/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_app/models/user.dart';


class DatabaseService{
  //collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brews');
  final String uid;
  DatabaseService({this.uid});

  Future updateUserData(String sugars,String name,int strength) async{
//when created the user and from settings
    return await brewCollection.document(uid).setData({
        'sugars':sugars,
        'name':name,
        'strength':strength,


      });

  }
  //brew list from snapschot
  //we are creating a Brew object everytime we have a new one in database
  //so we can use the objects easier,it is kind of parsing the data
  //coming from Stream for easier usage!
  List<Brew> _brewListFromSnapchot(QuerySnapshot snapshot ){
    return snapshot.documents.map((document){
      return Brew(
        name:document.data['name'],
          sugars: document.data['sugars'],
          strength:document.data['strength'] ?? 0,
      );
    }).toList();

  }

  //get brews streamibasicly check database constantly for a change with Stream

Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapchot);
}

//get the snapshot and create UserData object

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(

      uid:uid,
      name:snapshot.data['name'],
      sugars:snapshot.data['sugars'],
      strength:snapshot.data['strength']

    );

  }



//get user doc stream

Stream<UserData> get userData{
    return brewCollection.document(uid).snapshots().
  map(_userDataFromSnapshot);
}


}