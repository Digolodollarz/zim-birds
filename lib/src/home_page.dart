import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zim_birds/src/discover/discover_page.dart';
import 'package:zim_birds/src/services/bird_service.dart';

/// Application homepage
///
/// I don't know what to write here
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int bottomSelectedIndex = 0;

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
          icon: new Icon(Icons.home),
        label: 'Discover'
      ),
      BottomNavigationBarItem(
        icon: new Icon(Icons.search),
          label: ''
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.info_outline),
          label: ''
      )
    ];
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return Consumer<BirdService>(
      builder: (context, birdService, _) {
        return PageView(
          controller: pageController,
          onPageChanged: (index) {
            pageChanged(index);
          },
          children: <Widget>[
            DiscoverPage(),
            Blue(),
            Yellow(),
          ],
        );
      }
    );
  }

  void pageChanged(int index) {
    setState(() {
      bottomSelectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageView(),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              items: buildBottomNavBarItems(),
              currentIndex: bottomSelectedIndex,
              onTap: (index) {
                bottomTapped(index);
              },
              selectedItemColor: Theme.of(context).primaryColor,
              // showSelectedLabels: false,
              showUnselectedLabels: false,
            ),
          )),
    );
  }
}

class Blue extends StatefulWidget {
  @override
  _BlueState createState() => _BlueState();
}

class _BlueState extends State<Blue> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
    );
  }
}

class Yellow extends StatefulWidget {
  @override
  _YellowState createState() => _YellowState();
}

class _YellowState extends State<Yellow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellowAccent,
    );
  }
}
