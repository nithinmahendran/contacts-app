import 'package:contactsapp/UI/edit_contact.dart';
import 'package:contactsapp/global.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewContact extends StatefulWidget {
  String? contactKey;
  ViewContact({this.contactKey});

  @override
  _ViewContactState createState() => _ViewContactState();
}

class _ViewContactState extends State<ViewContact> {
  DatabaseReference? _ref;
  DatabaseReference? _favRef;
  String? contactName;
  String? phone;
  String? email;
  String? designation;
  String? department;
  String? editKey;
  bool isSaved = false;
  String? photo;
  String? photoUrl;
  List<bool> favList = [];
  bool? isFav;

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance.reference().child('CSE');
    _favRef = FirebaseDatabase.instance.reference().child('FAVS');
    getContactViewDetails();
  }

  void getContactViewDetails() async {
    DataSnapshot snapshot = await _ref!.child(widget.contactKey!).once();
    Map contact = snapshot.value;
    contactName = contact['name'];
    phone = contact['phone'];
    email = contact['email'];
    designation = contact['designation'];
    department = contact['department'];
    editKey = contact['key'];
    photo = contact['photo'];
    isFav = contact['isFav'];
    print(isFav);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditContact(
                              contactKey: widget.contactKey!,
                            )));
              },
              child: Icon(
                Icons.edit_rounded,
                size: 24.0,
                color: Colors.black,
              ),
            ),
          )
        ],
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              CupertinoIcons.chevron_back,
              color: Colors.black,
            )),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.center,
                child: Container(
                    // margin: EdgeInsets.only(top: 80.0),
                    // height: 250.0,
                    child: photo != null
                        ? Container(
                            margin: EdgeInsets.only(top: 100.0, bottom: 20.0),
                            height: 190.0,
                            width: 190.0,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: FittedBox(
                                  fit: BoxFit.cover,
                                  clipBehavior: Clip.hardEdge,
                                  child: Image.network(photo!)),
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.only(top: 100.0, bottom: 50.0),
                            height: 190.0,
                            child: Image.asset('assets/images/avatar.png'),
                          ))),
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(contactName.toString(),
                          style: introScreen, textAlign: TextAlign.center),
                      Text(phone.toString())
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: StarButton(
                        isStarred: isFav,
                        iconSize: 50.0,
                        valueChanged: (value) {
                          print(value);
                          if (value) {
                            favFunc();
                          } else {
                            delFav();
                          }
                        },
                      )
                      // child: InkWell(
                      //   onTap: () {
                      //     print("Favorite Function");
                      //     favFunc();
                      //   },
                      //   child: Icon(
                      //     CupertinoIcons.star_fill,
                      //     color: Color(0xffffe500),
                      //   ),
                      // ),
                      )
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap: () {
                      _callNumber(phone.toString());
                    },
                    child:
                        Icon(CupertinoIcons.phone_fill, color: Colors.black)),
                Icon(
                  CupertinoIcons.bubble_left_fill,
                  color: Colors.black,
                ),
                FaIcon(
                  FontAwesomeIcons.whatsapp,
                  color: Colors.black,
                ),
                FaIcon(
                  FontAwesomeIcons.solidEnvelope,
                  color: Colors.black,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    height: 25,
                    thickness: 1,
                  ),
                  Text("Department", style: sideHeaders),
                  Text(department.toString()),
                  const Divider(
                    height: 25,
                    thickness: 1,
                  ),
                  Text("Designation", style: sideHeaders),
                  Text(designation.toString()),
                  const Divider(
                    height: 25,
                    thickness: 1,
                  ),
                  Text("Phone", style: sideHeaders),
                  Text(phone.toString()),
                  const Divider(
                    height: 25,
                    thickness: 1,
                  ),
                  Text("Email", style: sideHeaders),
                  Text(email.toString()),
                  SizedBox(
                    height: 20.0,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  delFav() async {
    _ref!.child(widget.contactKey!).update({'isFav': 'false'});
    _favRef!.child(widget.contactKey!).remove();
  }

  favFunc() async {
    DataSnapshot snapshot = await _ref!.child(widget.contactKey!).once();
    Map contact = snapshot.value;
    contactName = contact['name'].toString();
    designation = contact['designation'].toString();
    photo = contact['photo'].toString();
    editKey = widget.contactKey.toString();

    Map<String?, String?> favContacts = {
      'name': contactName,
      'key': editKey,
      'designation': designation,
      'photo': photo,
      'isFav': 'true'
    };
    _ref!.child(widget.contactKey!).update({'isFav': 'true'});
    _favRef!.child(widget.contactKey!).set(favContacts);
  }
}

void _callNumber(phone) async {
  var number = phone; //set the number here
  bool? res = await FlutterPhoneDirectCaller.callNumber(number);
}
