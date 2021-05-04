import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class adminHome extends StatefulWidget {
  @override
  _adminHomeState createState() => _adminHomeState();
}

class _adminHomeState extends State<adminHome> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Admin Home"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu_book,
                color: Colors.black54,
                size: 200.0,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.0)),
                    child: Text(
                      "Upload Logo",
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                    color: Colors.green,
                    onPressed: () {
                      Fluttertoast.showToast(
                          msg: "Yet Working on it",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0);}
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.0)),
                  child: Text(
                    "Upload Banner",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  color: Colors.green,
                  onPressed: () {
                    Fluttertoast.showToast(
                        msg: "Yet Working on it",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);}
                ),
              ),

            ],

          ),
        ),
      ),
    );
  }
}
