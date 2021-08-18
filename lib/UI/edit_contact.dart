import 'dart:io';

import 'package:contactsapp/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';

class EditContact extends StatefulWidget {
  String? contactKey;
  EditContact({this.contactKey});

  @override
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? contactName;
  String? phone;
  String? email;
  String? designation;
  String? department;
  String? photo;
  String? isFav;
  String? deptId;
  File? imageFile;
  final picker = ImagePicker();
  DatabaseReference? _ref;
final snackBarEdit = SnackBar(
    content: const Text('Edited Contact Successfully'),
    backgroundColor: Colors.black,
  );
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _designationController = TextEditingController();
  TextEditingController _departmentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ref = FirebaseDatabase.instance.reference().child('ISE');
    getContactDetails();
  }

  chooseImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      imageFile = File(pickedFile!.path);
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    Map<String, String?> contactData = {
      'name': contactName,
      'phone': phone,
      'email': email,
      'designation': designation,
      'department': department,
      'photo': "",
      'isFav': "",
      'deptId': "null"
    };

    _ref!.child(widget.contactKey!).update(contactData).then((_) {
      print("Completed");
    });
     ScaffoldMessenger.of(context).showSnackBar(snackBarEdit);

    // _ref.child("1").set(contactData); updates the values in the database
  }

  getContactDetails() async {
    DataSnapshot snapshot = await _ref!.child(widget.contactKey!).once();
    Map contact = snapshot.value;
    _nameController.text = contact['name'];
    _phoneController.text = contact['phone'];
    _emailController.text = contact['email'];
    _designationController.text = contact['designation'];
    _departmentController.text = contact['department'];

    print(contact['name']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              CupertinoIcons.chevron_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: imageFile != null
                  ? InkWell(
                      onTap: () {
                        chooseImage(ImageSource.gallery);
                      },
                      child: Container(
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
                              child: Image(
                                  image: FileImage(
                                imageFile!,
                              ))),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        chooseImage(ImageSource.gallery);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 100.0, bottom: 50.0),
                        height: 190.0,
                        child: Image.asset('assets/images/addimage.png'),
                      ),
                    ),
              // child: Container(
              //   margin: EdgeInsets.only(top: 80.0),
              //   height: 250.0,
              //   child: Image.asset('assets/images/avatar.png'),
              // ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name", style: sideHeaders),
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a Name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        contactName = value;
                      },
                      decoration: InputDecoration(
                        fillColor: Color(0xffededed),
                        isDense: true,
                        border: InputBorder.none,
                      ),
                    ),
                    const Divider(
                      height: 25,
                      thickness: 1,
                    ),
                    Text("Department", style: sideHeaders),
                    TextFormField(
                      controller: _departmentController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a department';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        department = value;
                      },
                      decoration: InputDecoration(
                        fillColor: Color(0xffededed),
                        isDense: true,
                        border: InputBorder.none,
                      ),
                    ),
                    const Divider(
                      height: 25,
                      thickness: 1,
                    ),
                    Text("Designation", style: sideHeaders),
                    TextFormField(
                      controller: _designationController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a valid designation';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        designation = value;
                      },
                      decoration: InputDecoration(
                        fillColor: Color(0xffededed),
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
                      controller: _phoneController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 9) {
                          return 'Enter a valid phone number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        phone = value;
                      },
                      decoration: InputDecoration(
                        fillColor: Color(0xffededed),
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
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty || !(value.contains('@'))) {
                          return 'Invalid Email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        email = value;
                      },
                      decoration: InputDecoration(
                        fillColor: Color(0xffededed),
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
                            Navigator.pop(context);
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
