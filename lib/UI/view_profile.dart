import 'package:contactsapp/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewContact extends StatefulWidget {
  const ViewContact({Key? key}) : super(key: key);

  @override
  _ViewContactState createState() => _ViewContactState();
}

class _ViewContactState extends State<ViewContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Text("Alexa Bezoz",
                          style: introScreen, textAlign: TextAlign.center),
                      Text('+91 9902876487')
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
                Icon(CupertinoIcons.phone_fill, color: Colors.black),
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
                  Text("Computer Science and Engineering"),
                  const Divider(
                    height: 25,
                    thickness: 1,
                  ),
                  Text("Designation", style: sideHeaders),
                  Text("Assistant Professor"),
                  const Divider(
                    height: 25,
                    thickness: 1,
                  ),
                  Text("Phone", style: sideHeaders),
                  Text("+91 9902876487"),
                  const Divider(
                    height: 25,
                    thickness: 1,
                  ),
                  Text("Email", style: sideHeaders),
                  Text("alexabezos@sample.com"),
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
