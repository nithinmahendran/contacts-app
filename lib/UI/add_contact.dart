import 'dart:async';
import 'dart:io';

import 'package:contactsapp/global.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

class AddContact extends StatefulWidget {
  const AddContact({Key? key}) : super(key: key);

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
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

  Timer? _timer;
  late double _progress;

  final _ref = FirebaseDatabase.instance.reference();

  chooseImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      imageFile = File(pickedFile!.path);
      print("Image path $imageFile");
    });
  }

  // Future uploadPic(BuildContext context) async {

  // }

  Future<void> _submit(context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    String fileName = basename(imageFile!.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile!);
    EasyLoading.show(status: "Uploading");
    TaskSnapshot taskSnapshot = await uploadTask
        .whenComplete(() => EasyLoading.showSuccess('Great Success!'));

    final String photo = await taskSnapshot.ref.getDownloadURL();

    // setState(() {

    //   print("Profile Picture uploaded");
    //   Scaffold.of(context)
    //       .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
    // });

    Map<String?, String?> contactData = {
      'name': contactName,
      'phone': phone,
      'email': email,
      'designation': designation,
      'department': department,
      'photo': photo,
      'isFav': "",
      'deptId': "null"
    };

    _ref.child(department!).push().set(contactData).then((_) {
      print("Completed Adding Contact");
      EasyLoading.dismiss();
    });

    Navigator.pop(context);

    // _ref.child("1").set(contactData); updates the values in the database
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
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
                        email = value;
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
                            _submit(context);
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
