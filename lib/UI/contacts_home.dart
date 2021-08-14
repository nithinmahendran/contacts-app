import 'package:contactsapp/UI/edit_contact.dart';
import 'package:contactsapp/UI/view_profile.dart';
import 'package:contactsapp/models/user_model.dart';
import 'package:contactsapp/services/auth.dart';
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
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ndialog/ndialog.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class ContactsHome extends StatefulWidget {
  const ContactsHome({Key? key}) : super(key: key);

  @override
  _ContactsHomeState createState() => _ContactsHomeState();
}

class _ContactsHomeState extends State<ContactsHome> {
  List<bool> isSelected = [false, false, false, false, false, false, false];
  Query? _ref;
  DatabaseReference reference =
      FirebaseDatabase.instance.reference().child('CSE');
  List<String> depts = ['CSE', 'ISE', 'ME', 'ECE', 'CV', 'DS', 'AI'];
  String? deptPointer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref =
        FirebaseDatabase.instance.reference().child('CSE').orderByChild('name');
  }

  void readData() {
    _ref =
        FirebaseDatabase.instance.reference().child('CSE').orderByChild('name');
    _ref!.once().then((DataSnapshot snapshot) {
      Map contact = snapshot.value;
    });
  }

  Widget _buildItem({Map? contact}) {
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
      child: ListTile(
          leading: image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: FittedBox(
                      fit: BoxFit.cover,
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(contact['photo'])))
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
              : InkWell(
                  onTap: () async {
                    var number = contact['phone']; //set the number here
                    bool? res =
                        await FlutterPhoneDirectCaller.callNumber(number);
                  },
                  child: Container(
                      height: 35.0,
                      width: 35.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Color(0xffB9FFB8),
                      ),
                      child: Icon(
                        Icons.phone,
                        size: 24.0,
                        color: Colors.black,
                      )),
                )),
    );
  }

//   Widget _buildItem({Map? contact}) {
//     final authService = Provider.of<AuthService>(context);

//     return StreamBuilder<User?>(
//       stream: authService.user,
//       builder: (_, AsyncSnapshot<User?> snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           final User? user = snapshot.data;
//           //print("${user!.email} \n\n\n\n\n\n");
//           return user == null
//               ? _buildContactList(contact)
//               : _buildAdminContactList(contact);
//         } else {
//           return Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }
//       },
//     );
//   }

// // unecessary widget used refer fav screen for shorter code implementation
//   Widget _buildAdminContactList(contact) {
//     String? image = contact!['photo'];
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => ViewContact(
//                       contactKey: contact['key'],
//                     )));
//       },
//       child: Card(
//         color: Colors.white,
//         shadowColor: Colors.black,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//         child: ListTile(
//           leading: image != null
//               ? Image.network(contact['photo'])
//               : Image.asset('assets/images/avatar.png'),
//           title: Text(contact['name'],
//               style: TextStyle(fontWeight: FontWeight.bold)),
//           subtitle: Text(contact['designation']),
//           trailing: Wrap(
//             spacing: 20.0,
//             children: [
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => EditContact(
//                                 contactKey: contact['key'],
//                               )));
//                 },
//                 child: Container(
//                     height: 35.0,
//                     width: 35.0,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8.0),
//                       color: Color(0xfff1f1f1),
//                     ),
//                     child: Icon(
//                       Icons.edit_rounded,
//                       size: 24.0,
//                       color: Color(0xff666666),
//                     )),
//               ),
//               InkWell(
//                 onTap: () async {
//                   NAlertDialog(
//                     //Dialog Box
//                     blur: 2.0,
//                     dialogStyle: DialogStyle(titleDivider: true),
//                     title: Padding(
//                       padding: const EdgeInsets.only(top: 12.0, left: 12.0),
//                       child: Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 30.0,
//                             backgroundColor: Color(0xffF8F3F3),
//                             child: Icon(
//                               CupertinoIcons.trash,
//                               color: Colors.red,
//                               size: 30.0,
//                             ),
//                           ),
//                           SizedBox(
//                             width: 10.0,
//                           ),
//                           Text("Delete this contact?")
//                         ],
//                       ),
//                     ),
//                     content: Padding(
//                       padding: const EdgeInsets.only(
//                           top: 4.0, left: 10.0, right: 10.0),
//                       child: Text(
//                         "Are you sure you want to remove ${contact['name']} from the directory?",
//                         textAlign: TextAlign.center,
//                         style: dialogDelete,
//                       ),
//                     ),
//                     actions: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             top: 8.0, right: 20.0, bottom: 10.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             InkWell(
//                               onTap: () {
//                                 Navigator.pop(context);
//                               },
//                               child: Text(
//                                 'Cancel',
//                                 style: TextStyle(
//                                     fontSize: 18.0,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 10.0,
//                             ),
//                             ElevatedButton(
//                               onPressed: () {
//                                 reference
//                                     .child(contact['key'])
//                                     .remove()
//                                     .whenComplete(() => Navigator.pop(context));
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 primary: Colors.red,
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Text(
//                                   'Delete',
//                                   style: TextStyle(
//                                       fontFamily: "Poppins",
//                                       fontSize: 17.0,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ).show(context);
//                 },
//                 child: Container(
//                     height: 35.0,
//                     width: 35.0,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8.0),
//                       color: Color(0xfff1f1f1),
//                     ),
//                     child: Icon(
//                       CupertinoIcons.trash,
//                       size: 23.0,
//                       color: Colors.red[600],
//                     )),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildContactList(contact) {
//     String? image = contact!['photo'];
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => ViewContact(
//                       contactKey: contact['key'],
//                     )));
//       },
//       child: Card(
//         color: Colors.white,
//         shadowColor: Colors.black,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//         child: ListTile(
//             leading: image != null
//                 ? Image.network(contact['photo'])
//                 : Image.asset('assets/images/avatar.png'),
//             title: Text(contact['name'],
//                 style: TextStyle(fontWeight: FontWeight.bold)),
//             subtitle: Text(contact['designation']),
//             trailing: InkWell(
//               onTap: () async {
//                 var number = contact['phone']; //set the number here
//                 bool? res = await FlutterPhoneDirectCaller.callNumber(number);
//               },
//               child: Container(
//                   height: 35.0,
//                   width: 35.0,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8.0),
//                     color: Color(0xffB9FFB8),
//                   ),
//                   child: Icon(
//                     CupertinoIcons.phone_fill,
//                     size: 24.0,
//                     color: Colors.black,
//                   )),
//             )),
//       ),
//     );
//   }

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
                                  print(depts[index]);
                                  deptPointer = depts[index];
                                  isSelected[indexBtn] = !isSelected[indexBtn];
                                } else {
                                  isSelected[indexBtn] = false;
                                }
                              }
                            });
                          }),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20.0),
            FirebaseAuth.instance.currentUser != null
                ? Expanded(
                  child: Container(
                    height: 80.0,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                          Text("Add Contacts", style: sideHeaders),
                          SizedBox(height: 10.0),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddContact()));
                            },
                            child: Container(
                                height: 40.0,
                                width: 40.0,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Icon(
                                  CupertinoIcons.add,
                                  color: Colors.white,
                                )),
                          )
                        ])),
                )
                : Container(
                    
                  ),
            Container(
                margin: EdgeInsets.only(top: 10.0, right: 260.0),
                child: Text(
                  "Contacts",
                  style: sideHeaders,
                  textAlign: TextAlign.start,
                )),
            Expanded(
                child: FirebaseAnimatedList(
                    defaultChild: Center(
                        child: CircularProgressIndicator(color: Colors.black)),
                    query: _ref!,
                    padding: EdgeInsets.only(bottom: 12.0),
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      Map contact = snapshot.value;

                      contact['key'] = snapshot.key;

                      return _buildItem(contact: contact);
                    })),
          ],
        ),
      ),
    );
  }
}
