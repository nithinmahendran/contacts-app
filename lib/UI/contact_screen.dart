import 'package:cnav/cnav.dart';
import 'package:contactsapp/global.dart';
import 'package:flutter/material.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({Key? key}) : super(key: key);

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  @override
  List<bool> isSelected = [false, false, false, false, false, false, false];
  int _currentIndex = 1;
  Widget build(BuildContext context) {
    return Scaffold(
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
                  margin: EdgeInsets.only(top: 25.0, right: 270.0),
                  child: Text(
                    "Branch",
                    style: sideHeaders,
                    textAlign: TextAlign.start,
                  )),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                height: 75.0,
                width: 350,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: const Offset(
                        0.0,
                        4.0,
                      ),
                      blurRadius: 8.0,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, left: 20.0, right: 20.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ToggleButtons(
                            fillColor: Color(0xffB9FFB8),
                            highlightColor: Color(0xffB9FFB8),
                            splashColor: Color(0xffB9FFB8),
                            renderBorder: false,
                            borderRadius: BorderRadius.circular(8.0),
                            children: [
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 20.0, right: 20.0),
                                  child: Text('CSE', style: homePageBtn)),
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 25.0, right: 25.0),
                                  child: Text('ISE', style: homePageBtn)),
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 25.0, right: 25.0),
                                  child: Text('ME', style: homePageBtn)),
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 20.0, right: 25.0),
                                  child: Text('ECE', style: homePageBtn)),
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 20.0, right: 25.0),
                                  child: Text('CV', style: homePageBtn)),
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 25.0, right: 25.0),
                                  child: Text('DS', style: homePageBtn)),
                              Padding(
                                  padding:
                                      EdgeInsets.only(left: 25.0, right: 25.0),
                                  child: Text('AI', style: homePageBtn)),
                            ],
                            isSelected: isSelected,
                            onPressed: (int index) {
                              setState(() {
                                for (int indexBtn = 0;
                                    indexBtn < isSelected.length;
                                    indexBtn++) {
                                  if (indexBtn == index) {
                                    print(index);
                                    isSelected[indexBtn] =
                                        !isSelected[indexBtn];
                                  } else {
                                    isSelected[indexBtn] = false;
                                  }
                                }
                              });
                            }),
                      ),
                    )

                    // color: pressAttention! ? Colors.grey : Colors.blue,
                    // onPressed: () =>
                    //     setState(() => pressAttention = !pressAttention!),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 25.0, right: 260.0),
                  child: Text(
                    "Contacts",
                    style: sideHeaders,
                    textAlign: TextAlign.start,
                  )),
              Expanded(
                  child: ListView(padding: EdgeInsets.only(top: 10), children: [
                ListTile(
                  leading: FlutterLogo(size: 56.0),
                  title: Text('Alexa Bezos',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('Assistant Professor'),
                  trailing: Icon(Icons.call),
                ),
                ListTile(
                  leading: FlutterLogo(size: 56.0),
                  title: Text('Two-line ListTile'),
                  subtitle: Text('Here is a second line'),
                  trailing: Icon(Icons.more_vert),
                ),
                ListTile(
                  leading: FlutterLogo(size: 56.0),
                  title: Text('Two-line ListTile'),
                  subtitle: Text('Here is a second line'),
                  trailing: Icon(Icons.more_vert),
                ),
                ListTile(
                  leading: FlutterLogo(size: 56.0),
                  title: Text('Two-line ListTile'),
                  subtitle: Text('Here is a second line'),
                  trailing: Icon(Icons.more_vert),
                ),
                ListTile(
                  leading: FlutterLogo(size: 56.0),
                  title: Text('Two-line ListTile'),
                  subtitle: Text('Here is a second line'),
                  trailing: Icon(Icons.more_vert),
                ),
                ListTile(
                  leading: FlutterLogo(size: 56.0),
                  title: Text('Two-line ListTile'),
                  subtitle: Text('Here is a second line'),
                  trailing: Icon(Icons.more_vert),
                ),
                ListTile(
                  leading: FlutterLogo(size: 56.0),
                  title: Text('Two-line ListTile'),
                  subtitle: Text('Here is a second line'),
                  trailing: Icon(Icons.more_vert),
                ),
                ListTile(
                  leading: FlutterLogo(size: 56.0),
                  title: Text('Two-line ListTile'),
                  subtitle: Text('Here is a second line'),
                  trailing: Icon(Icons.more_vert),
                ),
              ])),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CNav(
        iconSize: 30.0,
        selectedColor: Colors.white,
        unSelectedColor: Color(0xffacacac),
        backgroundColor: Colors.black,
        items: [
          CNavItem(
            icon: Icon(Icons.home),
          ),
          CNavItem(
            icon: Icon(Icons.shopping_cart),
          ),
          CNavItem(
            icon: Icon(Icons.lightbulb_outline),
          ),
          CNavItem(
            icon: Icon(Icons.search),
          ),
        ],
        onTap: (value) {
          print(value);
        },
      ),
    );
  }
}
