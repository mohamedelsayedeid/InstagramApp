import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/firebase_services/storage.dart';
import 'package:instagram/model/user.dart';
import 'package:instagram/shared/snackbar.dart';

class Authentication{




  register({
    required email,required password,required context,required title,required username,
    required imgPath,required imgName
}) async {


    String message='Error => Not Starting the code';


    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );


      message='Error => Registered only';

      //______________________________________________________________________________________
     String url= await getImageUrl(
       folderName: 'profileImg',
        imgName: imgName,
        imgPath: imgPath
      );

    //______________________________________________________________________________________

      CollectionReference users = FirebaseFirestore.instance.collection('users');

      UserData user= UserData(username: username,
          password: password,
          email: email,
          title: title,
          profileImg:url,
          uid:credential.user!.uid,
          follower:[],
          following:[]
          );

      users.doc(credential.user!.uid).set(

        user.convert2Map()

      );


      message=' Registered & User Added Successfully';

    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.code);


    } catch (e) {
      print(e);
    }
    showSnackBar(context, message);
  }



  signIn({
    required email,
    required password,
    required context
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {

      showSnackBar(context, e.code);


    }
  }


// functoin to get user details from Firestore (Database)
  Future<UserData> getUserDetails() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    return UserData.convertSnap2Model(snap);
  }





}