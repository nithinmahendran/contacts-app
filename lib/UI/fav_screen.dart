import 'package:contactsapp/UI/edit_contact.dart';
import 'package:contactsapp/UI/view_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:contactsapp/UI/add_contact.dart';

import 'package:contactsapp/UI/intro_screen.dart';
import 'package:contactsapp/UI/settings.dart';
import 'package:contactsapp/global.dart';
import 'package:contactsapp/main.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ndialog/ndialog.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  _FavScreenState createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  List<bool> isSelected = [false, false, false, false, false, false, false];
  Query? _ref;
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('FAVS');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance
        .reference()
        .child('FAVS')
        .orderByChild('name');
    
  }

  Widget _buildContactItem({Map? contact}) {
    String? image = contact!['photo'];
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ViewContact(
                      contactKey: contact['key'],
                    )));
      },
      child: Card(
        color: Colors.white,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          leading: image != null
              ? Image.network(contact['photo'])
              : Image.asset('assets/images/avatar.png'),
          title: Text(contact['name'],
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(contact['designation']),
          trailing: FirebaseAuth.instance.currentUser != null
              ? Wrap(
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
                        NAlertDialog(
                          //Dialog Box
                          blur: 2.0,
                          dialogStyle: DialogStyle(titleDivider: true),
                          title: Padding(
                            padding:
                                const EdgeInsets.only(top: 12.0, left: 12.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 30.0,
                                  backgroundColor: Color(0xffF8F3F3),
                                  child: Icon(
                                    CupertinoIcons.trash,
                                    color: Colors.red,
                                    size: 30.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text("Delete this contact?")
                              ],
                            ),
                          ),
                          content: Padding(
                            padding: const EdgeInsets.only(
                                top: 4.0, left: 10.0, right: 10.0),
                            child: Text(
                              "Are you sure you want to remove ${contact['name']} from the directory?",
                              textAlign: TextAlign.center,
                              style: dialogDelete,
                            ),
                          ),
                          actions: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 20.0, bottom: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      reference
                                          .child(contact['key'])
                                          .remove()
                                          .whenComplete(
                                              () => Navigator.pop(context));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.red,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 17.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                )
              : Icon(
                  CupertinoIcons.star_fill,
                  color: Colors.yellow,
                ),
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
              "Favorites",
              style: introScreen,
            ),
            Container(
              margin: EdgeInsets.only(top: 25.0),
              height: 40.0,
              width: 400.0,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xffededed)),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12.0, left: 12.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(CupertinoIcons.search),
                  )
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 25.0, right: 260.0),
                child: Text(
                  "Favorites",
                  style: sideHeaders,
                  textAlign: TextAlign.start,
                )),
            Expanded(
                child: FirebaseAnimatedList(
                    query: _ref!,
                    defaultChild: Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      Map contact = snapshot.value;
                      //print(contact);

                      return _buildContactItem(contact: contact);
                    })),
          ],
        ),
      ),
    );
  }
}
