import 'package:contactsapp/UI/edit_contact.dart';
import 'package:contactsapp/global.dart';
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
  String? contactName;
  String? phone;
  String? email;
  String? designation;
  String? department;
  String? editKey;
  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance.reference().child('Cse');
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
                margin: EdgeInsets.only(top: 80.0),
                height: 250.0,
                child: Image.asset('assets/images/avatar.png'),
              ),
            ),
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
                    child: Icon(
                      CupertinoIcons.star_fill,
                      color: Color(0xffFFE500),
                    ),
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
                onTap:(){
                _callNumber(phone.toString());
                                },
                                child: Icon(CupertinoIcons.phone_fill, color: Colors.black)),
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
                }
                
                void _callNumber(phone) async{
                var number = phone; //set the number here
  bool? res = await FlutterPhoneDirectCaller.callNumber(number);
}
