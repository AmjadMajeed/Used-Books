import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Store/myUploads.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class EditPage extends StatefulWidget {
  final ItemModel itemModel;
  final DocumentSnapshot ds;

  EditPage(BuildContext context, {this.itemModel, this.ds});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  bool uploading = false;
  TextEditingController _descriptionTextEditingController2 =
  TextEditingController();
  TextEditingController _priceTextEditingController2 =
  TextEditingController();
  TextEditingController _titleTextEditingController2 = TextEditingController();
  TextEditingController _shortInfoTextEditingController2 =
  TextEditingController();
  String productId = DateTime.now().millisecondsSinceEpoch.toString();

  TextEditingController _phoneNumberTextEditingController2 =
  TextEditingController();




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
    'Sialkot',
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

  @override
  Widget build(BuildContext context) {
    TextEditingController _priceTextEditingController =
    TextEditingController(text: widget.itemModel.price.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Container(
              height: 230.0,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Center(
                child: Image.network(
                  widget.itemModel.thumbnailUrl,
                  height: 140.0,
                  width: 140.0,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 12.0)),

            ListTile(
              title: Text("Title:",
                style: TextStyle(
                decoration: TextDecoration.underline,
              ),
              ),
              subtitle: Container(
                width: 250.0,
                child: TextField(
                  style: TextStyle(color: Colors.deepPurpleAccent),
                  controller: _titleTextEditingController2,
                  decoration: InputDecoration(
                    hintText: widget.itemModel.title,
                    // hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              // leading: Icon(
              //Icons.perm_device_info,
              // color: Colors.green[800],
              //),
              title:Text("Description:",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
              subtitle: Container(
                width: 300.0,
                height: 100,
                child: TextField(
                  style: TextStyle(color: Colors.deepPurpleAccent),
                  controller: _descriptionTextEditingController2,
                  decoration: InputDecoration(
                    hintText: widget.itemModel.longDescription,
                    // hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              // leading: Icon(
              //   Icons.perm_device_info,
              //   color: Colors.green[800],
              // ),
              title:Text("Author Name:",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
              subtitle: Container(
                width: 250.0,
                child: TextField(
                  style: TextStyle(color: Colors.deepPurpleAccent),
                  controller: _shortInfoTextEditingController2,
                  decoration: InputDecoration(
                    hintText: widget.itemModel.shortInfo,
                    // hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.pink,
            ),
            SizedBox(height: 15.0,),
            ListTile(
              leading: Icon(
                Icons.phone,
                color: Colors.green[800],
              ),
              title: Text("Seller Phone No:",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
              subtitle: Container(
                width: 250.0,
                child: TextField(
                    keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.deepPurpleAccent),
                  controller: _phoneNumberTextEditingController2,
                  decoration: InputDecoration(
                    hintText: widget.itemModel.UploaderPhoneNumber.toString(),
                    // hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(
                Icons.category,
                color: Colors.green[800],
              ),
              title: Container(
                width: 250.0,
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
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(
                Icons.category,
                color: Colors.green[800],
              ),
              title: Container(
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
            Divider(
              color: Colors.grey,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 2, 8, 0),
                child: Text(
                  "*Leave 0 for Free",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Text(
                'Price:',
                style: TextStyle(color: Colors.green[800]),
              ),
              title: Container(
                width: 250.0,
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.deepPurpleAccent),
                  controller: _priceTextEditingController,
                  decoration: InputDecoration(
                    hintText: widget.itemModel.price.toString(),
                    // hintStyle: TextStyle(color: Colors.deepPurpleAccent),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            TextButton(
              child: Text(
                "Save",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                _priceTextEditingController2.text.isEmpty ?? 0;
                print("save button pressed");
              uploadImageAndSaveItemInfo();
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
          ],
        ),
      ),
    );
  }

  uploadImageAndSaveItemInfo() async {
    print("Saving image link");
    setState(() {
      uploading = true;
    });

    String imageDownloadUrl = await widget.itemModel.thumbnailUrl;
    saveItemInfo(imageDownloadUrl);
  }

  saveItemInfo(String downloadUrl) {
    print("saveItem function run");
    final itemref = Firestore.instance.collection("items");
    itemref.document(widget.ds.documentID).updateData({
      "shortInfo": _shortInfoTextEditingController2.text.toString().trim(),
      "longDescription": _descriptionTextEditingController2.text.toString().trim(),
      "price": _priceTextEditingController2.text.toString().trim(),
      "publishedDate": DateTime.now(),
      "status": "available",
      "thumbnailUrl": downloadUrl,
      "title": _titleTextEditingController2.text.toString().trim(),
      "uploadBy":
          EcommerceApp.sharedPreferences.getString(EcommerceApp.userName),
      "uploaderUID":
          EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID),
      "UploaderPhoneNumber": _phoneNumberTextEditingController2.text.toString().trim(),
      "location": _selectedCity,
      "category": _selectedCategory,
    });
    ToastMsg("Book Updated");

    Route route = MaterialPageRoute(builder: (c) => MyUploads());
    Navigator.pushReplacement(context, route);
  }
}
