import 'package:flutter/material.dart';
import 'package:instagram/provider/user_provider.dart';
import 'package:provider/provider.dart';
class Responsive extends StatefulWidget {
  final myWebScreen;
  final myMobileScreen;
  const Responsive({Key? key,
    required this.myWebScreen,required this.myMobileScreen}) : super(key: key);

  @override
  State<Responsive> createState() => _ResponsiveState();
}

class _ResponsiveState extends State<Responsive> {
  // To get data from DB using provider
  getDataFromDB() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }


  @override
  void initState() {
    super.initState();
    getDataFromDB();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder:(BuildContext,BoxConstraints){
          if(BoxConstraints.maxWidth>600){
            return widget.myWebScreen;
          }
          else{
            return widget.myMobileScreen;
          }
        } );
  }
}
