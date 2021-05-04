import 'package:e_shop/Admin/admin_home.dart';
import 'package:e_shop/Admin/uploadItems.dart';
import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Store/myUploads.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      //Drawer header with pic and name
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 25.0, bottom: 10.0),
            color: Colors.green,
            child: Column(
              children: [
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(80.0)),
                  elevation: 8.0,
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/logo1.png'),
                    // backgroundImage: NetworkImage(
                    //   EcommerceApp.sharedPreferences.getString(EcommerceApp.userAvatarUrl),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  EcommerceApp.sharedPreferences
                      .getString(EcommerceApp.userName),
                  style: TextStyle(
                      fontSize: 35.0,
                      fontFamily: "Signatra",
                      color: Colors.white),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Container(
            padding: EdgeInsets.only(top: 1.0),
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.white, Colors.black12],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Column(
              children: [
                //Drawer list items
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.black54,
                  ),
                  title: Text(
                    "Home",
                    style: TextStyle(color: Colors.black54),
                  ),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => StoreHome());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(
                  height: 10.0,
                  color: Colors.black54,
                  thickness: 6.0,
                ),

                ListTile(
                  leading: Icon(
                    Icons.book,
                    color: Colors.black54,
                  ),
                  title: Text(
                    "Upload New Book",
                    style: TextStyle(color: Colors.black54),
                  ),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => UploadPage());
                    Navigator.push(context, route);
                  },
                ),
                Divider(
                  height: 10.0,
                  color: Colors.black54,
                  thickness: 6.0,
                ),

                ListTile(
                  leading: Icon(
                    Icons.list_alt_outlined,
                    color: Colors.black54,
                  ),
                  title: Text(
                    "My Uploads",
                    style: TextStyle(color: Colors.black54),
                  ),
                  onTap: () {
                    Route route =
                        MaterialPageRoute(builder: (c) => MyUploads());
                    Navigator.push(context, route);
                  },
                ),
                Divider(
                  height: 10.0,
                  color: Colors.black54,
                  thickness: 6.0,
                ),

                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.black54,
                  ),
                  title: Text(
                    "Log Out",
                    style: TextStyle(color: Colors.black54),
                  ),
                  onTap: () {
                    EcommerceApp.auth.signOut().then((c) {
                      Route route =
                          MaterialPageRoute(builder: (c) => AuthenticScreen());
                      Navigator.pushReplacement(context, route);
                    });
                  },
                ),
                Divider(
                  height: 10.0,
                  color: Colors.black54,
                  thickness: 6.0,
                ),

                // ListTile(
                //  // leading: Icon(Icons.logout,color: Colors.black54,),
                //   title: Text("Admin Testing",style: TextStyle(color: Colors.black54),),
                //   onTap: (){
                //     EcommerceApp.auth.signOut().then((c){
                //       Route route = MaterialPageRoute(builder: (c) => adminHome());
                //       Navigator.push(context, route);
                //     });
                //
                //   },
                // ),
                // Divider(height: 10.0,color: Colors.black54,thickness: 6.0,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
