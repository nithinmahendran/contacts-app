import 'package:contactsapp/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddContact extends StatefulWidget {
  const AddContact({Key? key}) : super(key: key);

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
  }

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
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0),
              child: Form(
                autovalidate: true,
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name", style: sideHeaders),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty || !(value.contains('@'))) {
                          return 'Invalid Email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        print(value);
                      },
                      decoration: InputDecoration(
                        fillColor: Color(0xffededed),
                        isDense: true,
                        hintText: 'Name',
                        border: InputBorder.none,
                      ),
                    ),
                    const Divider(
                      height: 25,
                      thickness: 1,
                    ),
                    Text("Department", style: sideHeaders),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty || !(value.contains('@'))) {
                          return 'Invalid Email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        print(value);
                      },
                      decoration: InputDecoration(
                        fillColor: Color(0xffededed),
                        isDense: true,
                        hintText: 'Department',
                        border: InputBorder.none,
                      ),
                    ),
                    const Divider(
                      height: 25,
                      thickness: 1,
                    ),
                    Text("Designation", style: sideHeaders),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty || !(value.contains('@'))) {
                          return 'Invalid Email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        print(value);
                      },
                      decoration: InputDecoration(
                        fillColor: Color(0xffededed),
                        hintText: 'Designation',
                        isDense: true,
                        border: InputBorder.none,
                      ),
                    ),
                    const Divider(
                      height: 25,
                      thickness: 1,
                    ),
                    Text("Phone", style: sideHeaders),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty || !(value.contains('@'))) {
                          return 'Invalid Email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        print(value);
                      },
                      decoration: InputDecoration(
                        fillColor: Color(0xffededed),
                        hintText: 'Phone',
                        isDense: true,
                        border: InputBorder.none,
                      ),
                    ),
                    const Divider(
                      height: 25,
                      thickness: 1,
                    ),
                    Text("Email", style: sideHeaders),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty || !(value.contains('@'))) {
                          return 'Invalid Email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        print(value);
                      },
                      decoration: InputDecoration(
                        fillColor: Color(0xffededed),
                        hintText: 'Email Address',
                        isDense: true,
                        border: InputBorder.none,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _submit();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Proceed',
                              style: allBtns,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Cancel',
                              style: cancelBtn,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
