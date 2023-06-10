import 'package:firebase_storage/firebase_storage.dart';

getImageUrl(
    {required imgName,required imgPath,required folderName}
    ) async {

  // Upload image to firebase storage
  final storageRef = FirebaseStorage.instance.ref("$folderName/$imgName");
  // use this code if u are using flutter web
  UploadTask uploadTask = storageRef.putData(imgPath);
  TaskSnapshot snap = await uploadTask;

// Get img url
  String url = await snap.ref.getDownloadURL();

return url;
}