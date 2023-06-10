import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/firebase_services/storage.dart';
import 'package:instagram/model/posts.dart';
import 'package:uuid/uuid.dart';
import 'package:instagram/shared/snackbar.dart';

class FireStoreMethod {
  uploadPostData({
    required imgName,
    required imgPath,
    required description,
    required username,
    required profileImg,
    required context
  }) async {
    String message = 'Error => Not Starting the code';

    try {
      //______________________________________________________________________________________
      String url = await getImageUrl(imgName: imgName, imgPath: imgPath, folderName: 'postImg/${FirebaseAuth.instance.currentUser!.uid}');

      //______________________________________________________________________________________

      CollectionReference posts =
          FirebaseFirestore.instance.collection('posts');

     String newId=const Uuid().v1();

      message = 'Error => error hereeeeeeeeee';

      PostData post = PostData(
          username: username,
          description: description,
          imgPost: url,
          uid: FirebaseAuth.instance.currentUser!.uid,
          postId: newId,
          datePublished: DateTime.now(),
          likes: [],
          profileImg: profileImg);

      posts
          .doc(newId)
          .set(post.convert2Map()).then((value) => print('done')).catchError((error){print('failed to post :$error');});

      message = ' posted Successfully';
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.code);
    } catch (e) {
      print(e);
    }
    showSnackBar(context, message);
  }
}
