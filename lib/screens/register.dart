// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last


import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';


import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show basename;
import 'package:flutter/material.dart';
import 'package:instagram/firebase_services/auth.dart';
import 'package:instagram/screens/sign_in.dart';
import 'package:instagram/shared/colors.dart';
import 'package:instagram/shared/contants.dart';




import 'package:instagram/shared/snackbar.dart';



class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isVisable = true;
  Uint8List? imgPath;
  String? imgName;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final usernameController = TextEditingController();
  final titleController = TextEditingController();



  uploadImage2Screen(ImageSource source) async {
    Navigator.pop(context);
    final XFile? pickedImg = await ImagePicker().pickImage(source: source);
    try {

      if (pickedImg != null) {

        imgPath=await pickedImg.readAsBytes();
        setState(() {
          // imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
          print(imgName);
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }


  }
  showmodel() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(22),
          height: 170,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await uploadImage2Screen(ImageSource.camera);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.camera,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Camera",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () {
                  uploadImage2Screen(ImageSource.gallery);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.photo_outlined,
                      size: 30,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "From Gallery",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }



  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();

    usernameController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        title: Text("Register"),
        elevation: 0,
        // backgroundColor: appbarGreen,
      ),
      body: Center(
        child: Padding(
          padding: widthScreen > 600
              ? EdgeInsets.symmetric(horizontal: widthScreen * .3)
              : const EdgeInsets.all(33.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(125, 78, 91, 110),
                    ),
                    child: Stack(
                      children: [
                        imgPath == null
                            ? CircleAvatar(
                          backgroundColor:
                          Color.fromARGB(255, 225, 225, 225),
                          radius: 71,
                          // backgroundImage: AssetImage("assets/img/avatar.png"),
                          backgroundImage:
                          AssetImage("assets/img/avatar.png"),
                        )
                            : CircleAvatar(
                          backgroundColor:
                          Color.fromARGB(255, 225, 225, 225),
                          radius: 71,
                          // backgroundImage: AssetImage("assets/img/avatar.png"),
                          backgroundImage:
                          MemoryImage(imgPath!),
                        ),
                        Positioned(
                          left: 99,
                          bottom: -10,
                          child: IconButton(
                            onPressed: () {

                              showmodel();
                            },
                            icon: const Icon(Icons.add_a_photo),
                            color: Color.fromARGB(255, 208, 218, 224),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  TextFormField(
                      validator: (value){
                        return value!.isEmpty? "Can not be empty":null;
                      },

                      controller: usernameController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      decoration: decorationTextfield.copyWith(
                          hintText: "Enter Your username : ",
                          suffixIcon: Icon(Icons.person))),
                  const SizedBox(
                    height: 22,
                  ),
                  TextFormField(
                    validator: (value){
                      return value!.isEmpty? 'Can not be empty':null;
                    },
                      controller: titleController,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      decoration: decorationTextfield.copyWith(
                          hintText: "Enter Your title : ",
                          suffixIcon: Icon(Icons.person_outline))),
                  const SizedBox(
                    height: 22,
                  ),
                  TextFormField(
                    // we return "null" when something is valid
                      validator: (email) {
                        return email!.contains(RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                            ? null
                            : "Enter a valid email";
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: false,
                      decoration: decorationTextfield.copyWith(
                          hintText: "Enter Your Email : ",
                          suffixIcon: Icon(Icons.email))),
                  const SizedBox(
                    height: 22,
                  ),
                  TextFormField(

                      // we return "null" when something is valid
                      validator: (value) {
                        return value!.length < 8
                            ? "Enter at least 8 characters"
                            : null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: isVisable ? true : false,
                      decoration: decorationTextfield.copyWith(
                          hintText: "Enter Your Password : ",
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisable = !isVisable;
                                });
                              },
                              icon: isVisable
                                  ? Icon(Icons.visibility)
                                  : Icon(Icons.visibility_off)))),
                  const SizedBox(
                    height: 33,
                  ),
                  ElevatedButton(
                    onPressed: () async {

                      if (_formKey.currentState!.validate()
                      &&imgPath!=null &&imgName!=null

                      ) {
                        setState(() {
                          isLoading = true;
                        });

                        await Authentication()
                            .register(
                          title: titleController.text,
                            username: usernameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            imgPath: imgPath,
                            imgName: imgName,

                            context: context);


                        setState(() {
                          isLoading = false;
                        });
                        if (!mounted) return;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Login()
                          ),
                        );
                      } else {
                        showSnackBar(context, "ERROR");
                      }
                    },
                    child: isLoading
                        ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : Text(
                      "Register",
                      style: TextStyle(fontSize: 19),
                    ),
                    style: ButtonStyle(

                      padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Do not have an account?",
                          style: TextStyle(fontSize: 18)),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          child: Text('sign in',
                              style: TextStyle(
                                  fontSize: 18,
                                  decoration: TextDecoration.underline))),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}