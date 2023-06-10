import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/screens/add_post.dart';
import 'package:instagram/screens/home.dart';
import 'package:instagram/screens/profile.dart';
import 'package:instagram/screens/search.dart';
import 'package:instagram/shared/colors.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({Key? key}) : super(key: key);

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  navigate2Screen(int index){
    _pageController.jumpToPage(index);
  }
  final _pageController=PageController();
  int currentPage=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: webBackgroundColor,
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: SvgPicture.asset('assets/img/instagram.svg',
          height: 42,
          color: primaryColor,
        ),
        actions: [
          IconButton(
              onPressed: () {
                navigate2Screen(0);
                setState(() {
                  currentPage=0;
                });
              },
              icon: Icon(
                Icons.home,
                color: currentPage==0?primaryColor: secondaryColor,
              )),
          IconButton(
            icon: Icon(
              Icons.search,
              color: currentPage==1?primaryColor: secondaryColor,
            ),
            onPressed: () {
            navigate2Screen(1);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.add_a_photo,
              color: currentPage==2?primaryColor: secondaryColor,
            ),
            onPressed: () {
               navigate2Screen(2);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.favorite,
              color:currentPage==3?primaryColor: secondaryColor,
            ),
            onPressed: () {
              navigate2Screen(3);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              color:currentPage==4?primaryColor: secondaryColor,
            ),
            onPressed: () {
              navigate2Screen(4);
            },
          ),
        ],
      ),
      body: PageView(
        onPageChanged: (index) {
        setState(() {
          currentPage=index;
        });
        },
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          Home(),
          Search(),
          AddPost(),
          Center(
            child: Text('Love u '),
          ),
          Profile()
        ],
      ),
    );
  }
}
