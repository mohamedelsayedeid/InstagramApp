import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram/provider/user_provider.dart';
import 'package:instagram/responsive/mobile_screen.dart';
import 'package:instagram/responsive/responsive.dart';
import 'package:instagram/responsive/web_screen.dart';
import 'package:instagram/screens/sign_in.dart';
import 'package:instagram/shared/snackbar.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDt0VIiWuOOTEsUDI35RRlV3q2cXAQij80",
            authDomain: "instagram-d2023.firebaseapp.com",
            projectId: "instagram-d2023",
            storageBucket: "instagram-d2023.appspot.com",
            messagingSenderId: "903447765354",
            appId: "1:903447765354:web:1d0d7a15e22ea0d2b94513"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {return UserProvider();},
      child: MaterialApp(
          theme: ThemeData.dark(),
          debugShowCheckedModeBanner: false,
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {return Center(child: CircularProgressIndicator(color: Colors.white,));}
                else if (snapshot.hasError) {return showSnackBar(context, "Something went wrong");}
                else if (snapshot.hasData) {
                  return const Responsive(
                      myWebScreen: WebScreen(), myMobileScreen: MobileScreen());}
                else { return Login();}
              },
            ),
          // home:
      ),
    );

  }
}
