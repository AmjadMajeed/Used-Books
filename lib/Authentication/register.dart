import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:e_shop/DialogBox/loadingDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Store/storehome.dart';
import 'package:e_shop/Config/config.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

final TextEditingController _nametextEditingController =
    TextEditingController();
final TextEditingController _emailtextEditingController =
    TextEditingController();
final TextEditingController _passwordtextEditingController =
    TextEditingController();
final TextEditingController _cpasswordtextEditingController =
    TextEditingController();
final TextEditingController _phonenumbertextEditingController =
    TextEditingController();
final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
String userImageUrl = "";
File _imageFile;

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 10.0,
            ),
            InkWell(
              onTap: _selectAndPickImage,
              child: CircleAvatar(
                radius: _screenWidth * 0.15,
                backgroundColor: Colors.white,
                backgroundImage:
                    _imageFile == null ? null : FileImage(_imageFile),
                child: _imageFile == null
                    ? Icon(
                        Icons.add_a_photo,
                        size: _screenWidth * 0.15,
                        color: Colors.grey,
                      )
                    : null,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _nametextEditingController,
                    data: Icons.person,
                    hintText: "Name",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _emailtextEditingController,
                    data: Icons.email,
                    hintText: "Email",
                    isObsecure: false,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Colors.green[800],
                    ),
                    title: Container(
                      width: 250.0,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.deepPurpleAccent),
                        controller: _phonenumbertextEditingController,
                        decoration: InputDecoration(
                          hintText: "Phone No:",
                          // hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  // CustomTextField(
                  //   //keyboardType: TextInputType.number,
                  //   controller: _phonenumbertextEditingController,
                  //   data: Icons.phone,
                  //   hintText: "Phone Number",
                  //   isObsecure: false,
                  // ),
                  CustomTextField(
                    controller: _passwordtextEditingController,
                    data: null,
                    hintText: "Password",
                    isObsecure: true,
                  ),
                  CustomTextField(
                    controller: _cpasswordtextEditingController,
                    data: null,
                    hintText: "Confirm Password",
                    isObsecure: true,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              onPressed: () {
                uploadAndSaveImage();
              },
              color: Colors.pink,
              child: Text(
                "Sing Up",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 4.0,
              width: _screenWidth * 0.8,
              color: Colors.pink,
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectAndPickImage() async {
    _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  Future<void> uploadAndSaveImage() {
    if (_imageFile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: "Please Select an Image",
            );
          });
    } else {
      _passwordtextEditingController.text ==
              _cpasswordtextEditingController.text
          ? _nametextEditingController.text.isNotEmpty &&
                  _emailtextEditingController.text.isNotEmpty &&
                  _passwordtextEditingController.text.isNotEmpty &&
                  _cpasswordtextEditingController.text.isNotEmpty &&
                  _phonenumbertextEditingController.text.isNotEmpty
              ? uploadToStorage()
              : displayDialog("Please fill up all the feilds")
          : displayDialog("Password and Confirm password is not matched");
    }
  }

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            message: msg,
          );
        });
  }

  uploadToStorage() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(
            message: "Registering, Please wait.....",
          );
        });
    String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();

    StorageReference storageReference =
        FirebaseStorage.instance.ref().child(imageFileName);

    StorageUploadTask storageUploadTask = storageReference.putFile(_imageFile);

    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;

    await taskSnapshot.ref.getDownloadURL().then((urlImage) {
      userImageUrl = urlImage;
      _registerUser();
    });
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  void _registerUser() async {
    FirebaseUser firebaseUser;
    await _auth
        .createUserWithEmailAndPassword(
            email: _emailtextEditingController.text.trim(),
            password: _passwordtextEditingController.text.trim())
        .then((auth) {
      firebaseUser = auth.user;
    }).catchError((error) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: error.message.toString(),
            );
          });
    });

    if (firebaseUser != null) {
      saveUserInfoToFireStore(firebaseUser).then((value) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c) => StoreHome());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future saveUserInfoToFireStore(FirebaseUser fuser) async {
    Firestore.instance.collection("users").document(fuser.uid).setData({
      "uid": fuser.uid,
      "email": fuser.email,
      "name": _nametextEditingController.text.toString(),
      "url": userImageUrl,
      "PhoneNumber": _phonenumbertextEditingController.text.toString(),
      EcommerceApp.userCartList: ["garbageValue"],
    });
    print("user saved to memory success");
    await EcommerceApp.sharedPreferences.setString("uid", fuser.uid);
    await EcommerceApp.sharedPreferences.setString(
        EcommerceApp.userName, _nametextEditingController.text.toString());
    await EcommerceApp.sharedPreferences.setString(
        EcommerceApp.PhoneNumber, _phonenumbertextEditingController.text.toString());
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userEmail, fuser.email);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userAvatarUrl, userImageUrl);
    await EcommerceApp.sharedPreferences
        .setStringList(EcommerceApp.userCartList, ["garbageValue"]);
  }
}
