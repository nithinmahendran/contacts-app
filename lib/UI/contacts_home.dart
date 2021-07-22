import 'package:contactsapp/UI/edit_contact.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:contactsapp/UI/add_contact.dart';
import 'package:contactsapp/UI/fav_screen.dart';
import 'package:contactsapp/UI/intro_screen.dart';
import 'package:contactsapp/UI/settings.dart';
import 'package:contactsapp/global.dart';
import 'package:contactsapp/main.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ndialog/ndialog.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ContactsHome extends StatefulWidget {
  const ContactsHome({Key? key}) : super(key: key);

  @override
  _ContactsHomeState createState() => _ContactsHomeState();
}

class _ContactsHomeState extends State<ContactsHome> {
  List<bool> isSelected = [false, false, false, false, false, false, false];
  Query? _ref;
  DatabaseReference reference=FirebaseDatabase.instance.reference().child('Cse');


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref =
        FirebaseDatabase.instance.reference().child('Cse').orderByChild('name');
  }

  void readData() {
    _ref =
        FirebaseDatabase.instance.reference().child('Cse').orderByChild('name');
    _ref!.once().then((DataSnapshot snapshot) {
      Map contact = snapshot.value;
    });
  }

  Widget _buildContactItem({Map? contact}) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        leading: Image.asset('assets/images/avatar.png'),
        title: Text(contact!['name'],
            style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(contact['designation']),
        trailing: Wrap(
          spacing: 20.0,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditContact(
                              contactKey: contact['key'],
                            )));
              },
              child: Container(
                  height: 35.0,
                  width: 35.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Color(0xfff1f1f1),
                  ),
                  child: Icon(
                    Icons.edit_rounded,
                    size: 24.0,
                    color: Color(0xff666666),
                  )),
            ),
            InkWell(
              onTap: () async {
                NAlertDialog( //Dialog Box
                  blur: 2.0,
                  dialogStyle: DialogStyle(titleDivider: true),
                  title: Text("Delete Contact"),
                  content: Text("Do you want to delete ${contact['name']} "),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                      reference.child(contact['key']).remove().whenComplete(() => Navigator.pop(context));
                      },
                    ),
                    TextButton(
                      child: Text("Cancel"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ).show(context);
              },
              child: Container(
                  height: 35.0,
                  width: 35.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Color(0xfff1f1f1),
                  ),
                  child: Icon(
                    CupertinoIcons.trash,
                    size: 23.0,
                    color: Colors.red[600],
                  )),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
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
                            readData();
                            setState(() {
                              for (int indexBtn = 0;
                                  indexBtn < isSelected.length;
                                  indexBtn++) {
                                if (indexBtn == index) {
                                  print(index);
                                  isSelected[indexBtn] = !isSelected[indexBtn];
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
                child: FirebaseAnimatedList(
                    query: _ref!,
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      Map contact = snapshot.value;

                      contact['key'] = snapshot.key;

                      return _buildContactItem(contact: contact);
                    })),
            // Expanded(
            //     child: ListView(padding: EdgeInsets.only(top: 10), children: [
            //   ListTile(
            //     leading: Image.asset('assets/images/avatar.png'),
            //     title: Text('Alexa Bezos',
            //         style: TextStyle(fontWeight: FontWeight.bold)),
            //     subtitle: Text('Assistant Professor'),
            //     trailing: Icon(Icons.call),
            //   ),
            //   ListTile(
            //     leading: Image.asset('assets/images/avatar.png'),
            //     title: Text('Two-line ListTile'),
            //     subtitle: Text('Here is a second line'),
            //     trailing: Icon(Icons.more_vert),
            //   ),
            //   ListTile(
            //     leading: Image.asset('assets/images/avatar.png'),
            //     title: Text('Two-line ListTile'),
            //     subtitle: Text('Here is a second line'),
            //     trailing: Icon(Icons.more_vert),
            //   ),
            //   ListTile(
            //     leading: Image.asset('assets/images/avatar.png'),
            //     title: Text('Two-line ListTile'),
            //     subtitle: Text('Here is a second line'),
            //     trailing: Icon(Icons.more_vert),
            //   ),
            //   ListTile(
            //     leading: Image.asset('assets/images/avatar.png'),
            //     title: Text('Two-line ListTile'),
            //     subtitle: Text('Here is a second line'),
            //     trailing: Icon(Icons.more_vert),
            //   ),
            //   ListTile(
            //     leading: Image.asset('assets/images/avatar.png'),
            //     title: Text('Two-line ListTile'),
            //     subtitle: Text('Here is a second line'),
            //     trailing: Icon(Icons.more_vert),
            //   ),
            //   ListTile(
            //     leading: Image.asset('assets/images/avatar.png'),
            //     title: Text('Two-line ListTile'),
            //     subtitle: Text('Here is a second line'),
            //     trailing: Icon(Icons.more_vert),
            //   ),
            //   ListTile(
            //     leading: Image.asset('assets/images/avatar.png'),
            //     title: Text('Two-line ListTile'),
            //     subtitle: Text('Here is a second line'),
            //     trailing: Icon(Icons.more_vert),
            //   ),
            // ])),
          ],
        ),
      ),
    );
  }
}
