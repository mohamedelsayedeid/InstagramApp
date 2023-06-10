import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram/screens/add_post.dart';
import 'package:instagram/screens/home.dart';
import 'package:instagram/screens/profile.dart';
import 'package:instagram/screens/search.dart';
import 'package:instagram/shared/colors.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  final PageController _pageController = PageController(
  );
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  int currentPage=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        onTap: (index) {
          // navigate to the tabed page
          _pageController.jumpToPage(index);

          setState(() {
            currentPage=index;
          });
          },
        items:  [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: currentPage == 0? primaryColor:secondaryColor,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.search,
                  color: currentPage == 1? primaryColor:secondaryColor), label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                color: currentPage == 2? primaryColor:secondaryColor,
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.favorite,
                  color: currentPage == 3? primaryColor:secondaryColor), label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.person,
                  color: currentPage == 4? primaryColor:secondaryColor), label: ''),
        ],
      ),
      body: PageView(
        // onPageChanged: (index) {},
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
