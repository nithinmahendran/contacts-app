import 'package:contactsapp/UI/fav_selected.dart';
import 'package:contactsapp/UI/intro_screen.dart';
import 'package:contactsapp/UI/settings.dart';
import 'package:contactsapp/global.dart';
import 'package:contactsapp/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:badges/badges.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:english_words/english_words.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  List<bool> isSelected = [false, false, false, false, false, false, false];
  Set<String> savedWords = Set<String>();
  List<String> words = nouns.take(40).toList();
 

  int _currentIndex = 1;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("widget.title"),
        actions: <Widget>[
          Badge(
            badgeContent: Text('${savedWords.length}'),
            toAnimate: false,
            position: BadgePosition.topStart(top: 0),
            child: IconButton(
              icon: Icon(Icons.bookmark),
              onPressed: () => pushToFavoriteWordsRoute(context),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0, left: 20.0, right: 20.0),
          child: Column(
            children: [
              Text(
                "Contacts",
                style: introScreen,
              ),
              Container(
                margin: EdgeInsets.only(top: 25.0),
                height: 40.0,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xffededed)),
              ),
              Container(
                  margin: EdgeInsets.only(top: 25.0, right: 260.0),
                  child: Text(
                    "Favorites",
                    style: sideHeaders,
                    textAlign: TextAlign.start,
                  )),
              Expanded(
                  child: ListView.builder(
                padding: EdgeInsets.only(top: 10),
                itemCount: words.length,
                itemBuilder: (BuildContext context, int index) {
                  String word = words[index];
                  bool isSaved = savedWords.contains(word);
                  return ListTile(
                    leading: Image.asset('assets/images/avatar.png'),
                    title: Text(word,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(word),
                    trailing: Icon(
                      
                      isSaved ? CupertinoIcons.star_fill : CupertinoIcons.star,
                      color: isSaved ? Color(0xffffe500) : null,
                    ),
                    onTap: () {
                      setState(() {
                        if (isSaved) {
                          savedWords.remove(word);
                        } else {
                          savedWords.add(word);
                        }
                      });
                    },
                  );
                },
              )),
            ],
          ),
        ),
      ),
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
  Future pushToFavoriteWordsRoute(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => FavoriteWordsRoute(
          favoriteItems: savedWords.toList(),
        ),
      ),
    );
  }
}
