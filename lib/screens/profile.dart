// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/shared/colors.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map userData={};
  bool isLoading=true;
  int following=0;
  int follower=0;
  int postNumber=0;

 getData() async {
    setState(() {
      isLoading=true;
    });
    try{
      DocumentSnapshot<Map<String, dynamic>> snapshot =

      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();

      userData=snapshot.data()!;

       following=userData['following'].length;
       follower=userData['follower'].length;
      // To get post length
    dynamic snapshotPost=
    FirebaseFirestore.instance.collection('posts').where("uid", isEqualTo:FirebaseAuth.instance.currentUser!.uid).get();
    postNumber=snapshotPost.docs.length;

    }catch(e){}
    setState(() {
      isLoading=false;
    });

 }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

  }

  
  
  @override
  Widget build(BuildContext context) {

    final double widthScreen = MediaQuery.of(context).size.width;
    return isLoading?Scaffold(
       backgroundColor: mobileBackgroundColor,
        body: Center(child: CircularProgressIndicator(color: Colors.white,)))
        :Scaffold(
        backgroundColor:widthScreen>600? webBackgroundColor: mobileBackgroundColor,      appBar:widthScreen>600?null: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text(userData['username'],style: TextStyle(),),
      ),
      body:Container(
        decoration: BoxDecoration(
            color: mobileBackgroundColor,
            borderRadius: BorderRadius.circular(12)
        ),
        margin: EdgeInsets.symmetric(vertical: 11,horizontal:widthScreen>600? widthScreen/6:0),
        child: Column(
          children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.only(left: 12),
                padding: EdgeInsets.all(4),
                decoration:BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(125, 78, 91, 110)
                ),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                      userData['profileImg']),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(" $postNumber",style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 5,),
                  Text(
                    'Posts',
                  style:TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,) ,)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(follower.toString(),style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 5,),
                  Text(
                    'Followers',
                    style:TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,) ,)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(following.toString(),style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 5,),
                  Text(
                    'Following',
                    style:TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,) ,)
                ],
              )

            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 21, 0, 15),
           width: double.infinity,
           child: Text(userData['title'],),
          ),
          Divider(
            color: Colors.white,
            thickness:widthScreen>600? 0.06 : 0.44,
          ),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: (){},
                icon: Icon(Icons.edit, color: Colors.grey, size: 24.0, ),
                label: Text("Edit Profile", style: TextStyle(fontSize: 17),),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(0, 90, 103, 223)),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical:widthScreen>600? 19: 10,horizontal: 33)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                      side: BorderSide(
                    color: Color.fromARGB(109, 255, 255, 255),
                    style: BorderStyle.solid
                  ))),
                ),),
              SizedBox(width: 15,),
              ElevatedButton.icon(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                icon: Icon(Icons.logout, color: Colors.grey, size: 24.0, ),
                label: Text("Log out", style: TextStyle(fontSize: 17),),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(143, 255, 55, 112)),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical:widthScreen>600? 19: 10,horizontal: 33)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),

                  )
                  ),
                ),),
            ],
          ),
            SizedBox(height: 8,),
            Divider(
              color: Colors.white,
              thickness:widthScreen>600? 0.06 : 0.44,
            ),
            SizedBox(height: 19,),
           FutureBuilder(
      future: FirebaseFirestore.instance.collection('posts').where("uid", isEqualTo:FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }



        if (snapshot.connectionState == ConnectionState.done) {
          return  Expanded(
            child: Padding(
              padding:  EdgeInsets.all(widthScreen>600? 55: 3.0),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        snapshot.data!.docs[index]['imgPost'],
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(color:Colors.white),
        );
      },
    )
          ],
        ),
      )
    );
  }
}
