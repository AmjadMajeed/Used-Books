import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';

class UserInfoFromFirebase {

  static DocumentSnapshot snapshot; //Define snapshot

  static Future<DocumentSnapshot> getData() async {
    //use a Async-await function to get the data
    // print("this is testing");
    // print(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID));
    final data = await Firestore.instance.collection("users").document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID)).get(); //get the data
    snapshot = data;
    print(snapshot);
    return snapshot;
  }
}