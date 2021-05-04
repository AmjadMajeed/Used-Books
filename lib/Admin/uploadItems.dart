import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Config/userInfoFromFIrebase.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as ImD;

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage>
    with AutomaticKeepAliveClientMixin<UploadPage> {
  bool get wantKeepAlive => true;
  File file;

  //DropDown Menu
  List<String> _categories = [
    'Academic',
    'Art',
    'Biographies',
    'Business',
    'History',
    'Cookbooks,Foods',
    'Religions',
    'Sci-fi'
  ]; // Option 2
  String _selectedCategory; // Option 2
  String _selectedCity;

  //Getting data refrence;
  List<String> _location = [
    'Azad Kashmir',
    'Bahawalpur',
    'Bannu',
    'Dera Ghazi Khan',
    'Dera Ismail Khan',
    'Faisalabad',
    'F.A.T.A.',
    'Gujranwala',
    'Hazara',
    'Hyderabad',
    'Islamabad',
    'Kalat',
    'Karachi',
    'Kohat',
    'Lahore',
    'Larkana',
    'Makran',
    'Malakand',
    'Mardan',
    'Mirpur Khas',
    'Multan',
    'Nasirabad',
    'Gilgit-Baltistan',
    'Peshawar',
    'Quetta',
    'Rawalpindi',
    'Sargodha',
    'Sahiwal',
    'Shaheed Benazirabad',
    'Sibi',
    'Sukkur',
    'Zhob',
  ];

  TextEditingController _descriptionTextEditingController =
      TextEditingController();
  TextEditingController _priceTextEditingController =
      TextEditingController(text: 0.toString());

  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _shortInfoTextEditingController =
      TextEditingController();
  String productId = DateTime.now().millisecondsSinceEpoch.toString();
  bool uploading = false;
  TextEditingController _phoneNumberTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return file == null ? displayAdminHomeScreen() : displayAdminUploadScreen();
  }

  displayAdminHomeScreen() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          color: Colors.green,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        // actions: [
        //   FlatButton(
        //     child: Text(
        //       "Log out",
        //       style: TextStyle(
        //           color: Colors.yellow,
        //           fontSize: 16.0,
        //           fontWeight: FontWeight.bold),
        //     ),
        //     onPressed: () {
        //       Route route = MaterialPageRoute(builder: (c) => SplashScreen());
        //       Navigator.pushReplacement(context, route);
        //     },
        //   ),
        // ],
      ),
      body: getAdminHomeScreenBody(),
    );
  }

  getAdminHomeScreenBody() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.green,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu_book,
                color: Colors.white,
                size: 200.0,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0)),
                  child: Text(
                    "Upload Book",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  color: Colors.green,
                  onPressed: () => takeImage(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///Working code
  takeImage(mContext) {
    return showDialog(
        context: mContext,
        builder: (con) {
          return SimpleDialog(
            title: Text(
              "Item Image",
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
            children: [
              SimpleDialogOption(
                child: Text(
                  "Capture with Camera",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
                onPressed: capturePhotoWithCamera,
              ),
              SimpleDialogOption(
                child: Text(
                  "Select From Gallery",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
                onPressed: pickUImageFromGallery,
              ),
              SimpleDialogOption(
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  capturePhotoWithCamera() async {
    Navigator.pop(context);
    File imagefile = await ImagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 680.0, maxHeight: 970.0);

    setState(() {
      file = imagefile;
    });
  }

  pickUImageFromGallery() async {
    Navigator.pop(context);
    File imagefile = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      file = imagefile;
    });
  }

  displayAdminUploadScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          color: Colors.green,
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: clearFormInfo),
        title: Text(
          "List Your Book",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24.0),
        ),
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            uploading ? linearProgress() : Text(""),

            Container(
              height: 230.0,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Center(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(file), fit: BoxFit.cover)),
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 12.0)),
            Container(
              color: Colors.white,
              child: ListTile(
                title: Text("Title",style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Container(
                  width: 250.0,
                  child: TextField(
                    style: TextStyle(color: Colors.deepPurpleAccent),
                    controller: _titleTextEditingController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                // leading: Icon(
                //Icons.perm_device_info,
                // color: Colors.green[800],
                //),
                title: Text("Description",style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Container(
                  width: 300.0,
                  height: 100,
                  child: TextField(
                    style: TextStyle(color: Colors.deepPurpleAccent),
                    controller: _descriptionTextEditingController,
                    decoration: InputDecoration(
                      //hintText: "Description",
                      // hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                // leading: Icon(
                //   Icons.perm_device_info,
                //   color: Colors.green[800],
                // ),
                title: Text("Author Name",style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Container(
                  width: 250.0,
                  child: TextField(
                    style: TextStyle(color: Colors.deepPurpleAccent),
                    controller: _shortInfoTextEditingController,
                    decoration: InputDecoration(
                      //hintText: "Author Name",
                      // hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            // //SizedBox(height: 4.0,),
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   child: Padding(
            //     padding: const EdgeInsets.fromLTRB(8,2,8,0),
            //     child: Text("* Default phone Number will show on Ad,Edit to change number",style: TextStyle(
            //       color: Colors.red,
            //     ),),
            //   ),),
            Container(
              color:Colors.white,
              child: ListTile(
                // leading: Icon(
                //   Icons.phone,
                //   color: Colors.green[800],
                //),
                title: Text("Seller Number",style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Container(
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.deepPurpleAccent),
                    controller: _phoneNumberTextEditingController,
                    decoration: InputDecoration(
                     // hintText: "Number to contact for buyers",
                      // hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                // leading: Icon(
                //   Icons.category,
                //   color: Colors.green[800],
                // ),
               // title: Text("C",style: TextStyle(fontWeight: FontWeight.bold),),
                title: Text("Choose City",style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Container(
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButton(
                    hint: Text('Category'),
                    // Not necessary for Option 1
                    value: _selectedCategory,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCategory = newValue;
                      });
                    },
                    items: _categories.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                // leading: Icon(
                //   Icons.location_city,
                //   color: Colors.green[800],
                // ),
                title: Text("Choose City",style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Container(
                  width: 250.0,
                  child: DropdownButton(
                    hint: Text('City'),
                    // Not necessary for Option 1
                    value: _selectedCity,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCity = newValue;
                      });
                    },
                    items: _location.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),

            Container(
              color: Colors.white,
              child: ListTile(
                leading: Text(
                  'Price:',
                  style: TextStyle(color: Colors.grey),
                ),
                title: Text("*Leave 0 for Free",style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Container(
                  width: 250.0,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.deepPurpleAccent),
                    controller: _priceTextEditingController,
                    decoration: InputDecoration(
                      hintText: "Default Price set: 0",
                      // hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                child: TextButton(
                  child: Text(
                    "Save",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    _priceTextEditingController.text.isEmpty ?? 0;
                    uploading ? null : uploadImageAndSaveItemInfo();
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.green),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  clearFormInfo() {
    setState(() {
      _priceTextEditingController.clear();
      _descriptionTextEditingController.clear();
      _titleTextEditingController.clear();
      _shortInfoTextEditingController.clear();
      _phoneNumberTextEditingController.clear();
      Route route = MaterialPageRoute(builder: (c) => UploadPage());
      Navigator.pushReplacement(context, route);
    });
  }

  uploadImageAndSaveItemInfo() async {
    setState(() {
      uploading = true;
    });

    String imageDownloadUrl = await uploadItemImage(file);

    //saveItemInfo(imageDownloadUrl);
    saveItemInfoCategory(imageDownloadUrl);
    //saveItemInfoPersonaly(imageDownloadUrl);
  }

  Future<String> uploadItemImage(mImageFile) async {
    final StorageReference storageReference =
        FirebaseStorage.instance.ref().child("Items");
    StorageUploadTask uploadTask =
        storageReference.child("product_$productId.jpg").putFile(mImageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //
  // saveItemInfo(String downloadUrl) {
  //   final itemref = Firestore.instance.collection(_selectedCategory);
  //   itemref.document(productId).setData({
  //     "shortInfo": _shortInfoTextEditingController.text.trim(),
  //     "longDescription": _descriptionTextEditingController.text.trim(),
  //     "price": int.parse(_priceTextEditingController.text),
  //     "publishedDate": DateTime.now(),
  //     "status": "available",
  //     "thumbnailUrl": downloadUrl,
  //     "title": _titleTextEditingController.text.trim(),
  //     "uploadBy": EcommerceApp.sharedPreferences.getString(EcommerceApp.userName),
  //     "uploaderUID": EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID),
  //     "UploaderPhoneNumber": _phoneNumberTextEditingController.text,
  //     "location": _selectedCity,
  //     "category" : _selectedCategory,
  //   });
  // }

  saveItemInfoCategory(String downloadUrl) {
    final itemref = Firestore.instance.collection('items');
    itemref.document().setData({
      "shortInfo": _shortInfoTextEditingController.text.trim(),
      "longDescription": _descriptionTextEditingController.text.trim(),
      "price": int.parse(_priceTextEditingController.text),
      "publishedDate": DateTime.now(),
      "status": "available",
      "thumbnailUrl": downloadUrl,
      "title": _titleTextEditingController.text.trim(),
      "uploadBy":
          EcommerceApp.sharedPreferences.getString(EcommerceApp.userName),
      "uploaderUID":
          EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID),
      "UploaderPhoneNumber": _phoneNumberTextEditingController.text,
      "location": _selectedCity,
      "category": _selectedCategory,
    });
    setState(() {
      file = null;
      uploading = false;
      productId = DateTime.now().millisecondsSinceEpoch.toString();
      _titleTextEditingController.clear();
      _priceTextEditingController.clear();
      _descriptionTextEditingController.clear();
      _shortInfoTextEditingController.clear();
      _phoneNumberTextEditingController.clear();
      Route route = MaterialPageRoute(builder: (c) => StoreHome());
      Navigator.pushReplacement(context, route);
      // Navigator.pop(context);
    });

    Fluttertoast.showToast(
        msg: "Book Uploaded Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

// saveItemInfoPersonaly(String downloadUrl) {
//   final itemrefpersonal = Firestore.instance
//       .collection("personalitems")
//       .document(
//           EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
//       .collection('items');
//   itemrefpersonal.document().setData({
//     "shortInfo": _shortInfoTextEditingController.text.trim(),
//     "longDescription": _descriptionTextEditingController.text.trim(),
//     "price": int.parse(_priceTextEditingController.text),
//     "publishedDate": DateTime.now(),
//     "status": "available",
//     "thumbnailUrl": downloadUrl,
//     "title": _titleTextEditingController.text.trim(),
//     "uploadBy":
//         EcommerceApp.sharedPreferences.getString(EcommerceApp.userName),
//     "uploaderUID":
//         EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID),
//     "UploaderPhoneNumber": _phoneNumberTextEditingController.text,
//     "location": _selectedCity,
//   });
//
//   setState(() {
//     file = null;
//     uploading = false;
//     productId = DateTime.now().millisecondsSinceEpoch.toString();
//     _titleTextEditingController.clear();
//     _priceTextEditingController.clear();
//     _descriptionTextEditingController.clear();
//     _shortInfoTextEditingController.clear();
//     _phoneNumberTextEditingController.clear();
//     Route route = MaterialPageRoute(builder: (c) => StoreHome());
//     Navigator.pushReplacement(context, route);
//     // Navigator.pop(context);
//   });
//
//   Fluttertoast.showToast(
//       msg: "Book Uploaded Successfully",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.CENTER,
//       timeInSecForIosWeb: 1,
//       backgroundColor: Colors.green,
//       textColor: Colors.white,
//       fontSize: 16.0);
// }
//}
