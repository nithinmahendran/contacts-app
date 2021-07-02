import 'package:contactsapp/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

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
                  style:settingsPage,
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
                title: Text('Dark Mode',style:settingsPage),
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
                title: Text('Admin Mode',style:settingsPage,),
              ),
              const Divider(
                height: 15,
                thickness: 1,
                indent: 16,
                endIndent: 16,
              ),
              ListTile(
                title: Text('About',style:settingsPage,),
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
                title: Text('Contact Us',style:settingsPage,),
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
                title: Text('Website',style:settingsPage,),
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
