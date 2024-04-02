import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:noisie/screens/home_screen.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  final _screens = [
    const HomeScreen(),
    const Scaffold(
      body: Center(
        child: Text('Explore'),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text('Add'),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text('Subscriptions'),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text('Library'),
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // CustomBottomNavigationBar: CustomBottomNavigationBar(
      //   type: CustomBottomNavigationBarType.fixed,
      //   currentIndex: _selectedIndex,
      //   onTap: (i) => setState(() => _selectedIndex = i),
      //   selectedItemColor: Colors.white,
      //   selectedFontSize: 10.0,
      //   unselectedFontSize: 10.0,
      //   items: const [
      //     CustomBottomNavigationBarItem(
      //       icon: Icon(Icons.home_outlined),
      //       activeIcon: Icon(Icons.home),
      //       label: ('Home'),
      //     ),
      //     CustomBottomNavigationBarItem(
      //       icon: Icon(Icons.explore_outlined),
      //       activeIcon: Icon(Icons.explore),
      //       label: 'Explore',
      //     ),
      //     CustomBottomNavigationBarItem(
      //       icon: Icon(Icons.add_circle_outline),
      //       activeIcon: Icon(Icons.add_circle),
      //       label: 'Add',
      //     ),
      //     CustomBottomNavigationBarItem(
      //       icon: Icon(Icons.subscriptions_outlined),
      //       activeIcon: Icon(Icons.subscriptions),
      //       label: 'Subscriptions',
      //     ),
      //     CustomBottomNavigationBarItem(
      //       icon: Icon(Icons.video_library_outlined),
      //       activeIcon: Icon(Icons.video_library),
      //       label: 'Library',
      //     ),
      //   ],
      // ),
      body: Stack(
          children: _screens
              .asMap()
              .map((i, screen) => MapEntry(
                    i,
                    Offstage(
                      offstage: _selectedIndex != i,
                      child: screen,
                    ),
                  ))
              .values
              .toList()),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GNav(
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            duration: Duration(milliseconds: 500),
            backgroundColor: Colors.black,
            activeColor: Colors.white,
            color: Colors.white,
            tabBackgroundColor: const Color.fromRGBO(66, 66, 66, 1),
            gap: 8,
            padding: EdgeInsets.all(15),
            tabs: const [
              GButton(
                iconActiveColor: Color.fromARGB(255, 255, 34, 107),
                icon: Icons.home_outlined,
                text: 'Home',
                textStyle: TextStyle(
                    fontFamily: 'Spotify', fontWeight: FontWeight.w600),
              ),
              GButton(
                iconActiveColor: Color.fromARGB(255, 255, 34, 107),
                icon: Icons.my_library_music_outlined,
                text: 'Library',
                textStyle: TextStyle(
                    fontFamily: 'Spotify', fontWeight: FontWeight.w600),
              ),
              GButton(
                iconActiveColor: Color.fromARGB(255, 255, 34, 107),
                icon: Icons.search,
                text: 'Search',
                textStyle: TextStyle(
                    fontFamily: 'Spotify', fontWeight: FontWeight.w600),
              ),
              GButton(
                iconActiveColor: Color.fromARGB(255, 255, 34, 107),
                icon: Icons.feed_outlined,
                text: 'Feed',
                textStyle: TextStyle(
                    fontFamily: 'Spotify', fontWeight: FontWeight.w600),
              ),
              // GButton(
              //   iconActiveColor: Color.fromARGB(255, 255, 34, 107),
              //   icon: Icons.upgrade_outlined,
              //   text: 'Upgrade',
              //   textStyle: TextStyle(
              //       fontFamily: 'Spotify', fontWeight: FontWeight.w600),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
