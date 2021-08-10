import 'dart:ui';

import 'package:contactsapp/global.dart';
import 'package:contactsapp/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _value = true;
  
  String? _chosenValue;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 80.0, left: 20.0),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Text("Settings", style: introScreen)),
              SizedBox(
                height: 20.0,
              ),
              ListTile(
                title: Text(
                  'Branch',
                  style: settingsPage,
                ),
                trailing: Container(
                  margin: EdgeInsets.only(right: 10.0),
                  width: 120.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0xffB9FFB8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _chosenValue,
                      isExpanded: true,
                      //elevation: 5,
                      style: TextStyle(color: Color(0xffbcbcbc)),
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Icon(
                          CupertinoIcons.chevron_down,
                          color: Color(0xffbcbcbc),
                          size: 19.0,
                        ),
                      ),

                      items: <String>[
                        'CSE',
                        'ISE',
                        'ME',
                        'ECE',
                        'CE',
                        'AI',
                        'DS',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 12.0, right: 10.0),
                            child: Text(
                              value,
                              style: dropDownList,
                            ),
                          ),
                        );
                      }).toList(),
                      hint: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Text(
                          "Default",
                          style: dropDownList,
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _chosenValue = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 15,
                thickness: 1,
                indent: 16,
                endIndent: 16,
              ),
              ListTileSwitch(
                value: _value,
                onChanged: (value) {
                  setState(() {
                    _value = value;
                  });
                },
                visualDensity: VisualDensity.comfortable,
                switchType: SwitchType.cupertino,
                switchActiveColor: Colors.indigo,
                title: Text('Dark Mode', style: settingsPage),
              ),
              const Divider(
                height: 15,
                thickness: 1,
                indent: 16,
                endIndent: 16,
              ),
              ListTileSwitch(
                value: FirebaseAuth.instance.currentUser != null ? true : false,
                onChanged: (value) async {
                  if (FirebaseAuth.instance.currentUser == null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomDialog(),
                    );
                  }
                  if (value == false) {
                    await authService
                        .signOut()
                        .then((value) => print("Logged out"));
                  }
                  setState(() {
                    _value = value;
                  });
                },
                visualDensity: VisualDensity.comfortable,
                switchType: SwitchType.cupertino,
                switchActiveColor: Colors.indigo,
                title: Text(
                  'Admin Mode',
                  style: settingsPage,
                ),
              ),
              const Divider(
                height: 15,
                thickness: 1,
                indent: 16,
                endIndent: 16,
              ),
              ListTile(
                title: Text(
                  'About',
                  style: settingsPage,
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Icon(
                    CupertinoIcons.chevron_forward,
                    color: Colors.black,
                  ),
                ),
              ),
              const Divider(
                height: 15,
                thickness: 1,
                indent: 16,
                endIndent: 16,
              ),
              ListTile(
                title: Text(
                  'Contact Us',
                  style: settingsPage,
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Icon(
                    CupertinoIcons.chevron_forward,
                    color: Colors.black,
                  ),
                ),
              ),
              const Divider(
                height: 15,
                thickness: 1,
                indent: 16,
                endIndent: 16,
              ),
              ListTile(
                title: Text(
                  'Website',
                  style: settingsPage,
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Icon(
                    CupertinoIcons.square_arrow_right,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

dialogContent(BuildContext context) {
  TextEditingController _adminCred = TextEditingController();
  final authService = Provider.of<AuthService>(context);
  return Stack(
    children: [
      Container(
        padding: EdgeInsets.only(
          top: Consts.avatarRadius + Consts.padding,
          bottom: Consts.padding,
          left: Consts.padding,
          right: Consts.padding,
        ),
        margin: EdgeInsets.only(top: Consts.avatarRadius),
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(Consts.padding),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // To make the card compact
          children: <Widget>[
            Text(
              "Admin Login",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              height: 52.0,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xffededed)),
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: TextFormField(
                  controller: _adminCred,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || value.length <= 5) {
                      print("Nothing");
                      return 'Invalid Password';
                    }
                    return null;
                  },
                  // onSaved: (value) {
                  //   print(value);
                  // },
                  decoration: InputDecoration(
                      fillColor: Color(0xffededed),
                      hintText: 'Password',
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        CupertinoIcons.lock,
                        color: Colors.black,
                      )),
                ),
              ),
            ),
            SizedBox(height: 24.0),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () async {
                    await authService
                        .signInWithEmailAndPassword(
                            "abc@gmail.com", _adminCred.text)
                        .then((value) => print("Logged in"));

                    Navigator.of(context).pop(); // To close the dialog
                  },
                  child: Text(
                    "  Login  ",
                    style: allBtns,
                  )),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text("Cancel")
          ],
        ),
      ),
      Positioned(
          top: 10.0,
          left: Consts.padding + 100,
          right: Consts.padding + 100,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(20.0)),
            height: 100.0,
            width: 100.0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset('assets/images/adminlock.png', scale: 0.3),
            ),
          )),
    ],
  );
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Consts.padding),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context),
      ),
    );
  }
}
