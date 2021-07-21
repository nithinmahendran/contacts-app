import 'package:contactsapp/UI/add_contact.dart';
import 'package:contactsapp/UI/contacts_home.dart';
import 'package:contactsapp/UI/fav_screen.dart';
import 'package:contactsapp/UI/intro_screen.dart';
import 'package:contactsapp/UI/settings.dart';
import 'package:contactsapp/UI/view_profile.dart';
import 'package:contactsapp/global.dart';
import 'package:contactsapp/main.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  List<bool> isSelected = [false, false, false, false, false, false, false];
  int _currentIndex = 0;
  List<Widget> tabs=[
    ContactsHome(),
    FavScreen(),
    AddContact(),
    ViewContact()
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddContact()));
        },
      ),
      backgroundColor: Colors.white,
      body: tabs[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              backgroundColor: Colors.black,
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.white,
              color: Colors.white,
              tabs: [
                GButton(
                  icon: CupertinoIcons.person_2,
                  text: 'Home',
                ),
                GButton(
                  icon: CupertinoIcons.clock,
                  text: 'Recents',
                ),
                GButton(
                  icon: CupertinoIcons.star,
                  text: 'Favourites',
                ),
                GButton(
                  icon: CupertinoIcons.settings,
                  text: 'Settings',
                ),
              ],
              selectedIndex: _currentIndex,
              onTabChange: (index) {
                setState(() {
                  _currentIndex = index;
                  
                  print("${_currentIndex}NavBar");
                });
              },
            ),
          ),
        ),
      ),
    );
  }

 
}
