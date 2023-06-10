import 'package:cloud_firestore/cloud_firestore.dart';

class UserData{

  String username;
  String title;
  String email;
  String password;
  String profileImg;
  String uid;
  List follower;
  List following;


  UserData({
    required this.username,
    required this.title,
    required this.email,
    required this.password,
    required this.profileImg,
    required this.uid,
    required this.follower,
    required this.following
  }
      );


  //To convert UserData (Data type) to Map< String, dynamic>

     Map<String,dynamic> convert2Map(){
    return {
      'username':username,
      'title':title,
      'email':email,
      'password':password,
       'profileImg':profileImg,
        'uid':uid,
      "follower":[],
      "following":[]

    };

     }

  // function that convert "DocumentSnapshot" to a User
// function that takes "DocumentSnapshot" and return a User

  static    convertSnap2Model(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserData(
      email: snapshot["email"],
      username: snapshot["username"],
      title: snapshot['title'],
      password: snapshot['password'],
      follower: snapshot['follower'],
      following: snapshot['following'],
      profileImg: snapshot['profileImg'],
      uid: snapshot['uid']



    );
  }

}