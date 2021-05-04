import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Counters/ItemQuantity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Authentication/authenication.dart';
import 'package:e_shop/Config/config.dart';
import 'Authentication/authenication.dart';
import 'Config/config.dart';
import 'Config/config.dart';
import 'Counters/cartitemcounter.dart';
import 'Counters/changeAddresss.dart';
import 'Counters/totalMoney.dart';
import 'Store/storehome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  EcommerceApp.auth = FirebaseAuth.instance;
  EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();
  EcommerceApp.firestore = Firestore.instance;

  runApp(MyApp());


}
ToastMsg(String Msg) {
  Fluttertoast.showToast(
      msg: Msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => CartItemCounter()),
        ChangeNotifierProvider(create: (c) => CartItemCounter()),
        ChangeNotifierProvider(create: (c) => AddressChanger()),
        ChangeNotifierProvider(create: (c) => TotalAmount()),
      ],
      child: MaterialApp(
          title: 'e-Shop',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.green,
          ),
          home: SplashScreen()),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    displaySplash();
    print(EcommerceApp.userUID);
    print(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID));
    print(EcommerceApp.userUID);
  }

  displaySplash() {
    Timer(Duration(milliseconds: 5000), () async {
      if (await EcommerceApp.auth.currentUser() != null) {
        Route routs = MaterialPageRoute(builder: (_) => StoreHome());
        Navigator.pushReplacement(context, routs);
      } else {
        Route routs = MaterialPageRoute(builder: (_) => AuthenticScreen());
        Navigator.pushReplacement(context, routs);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        // decoration: new BoxDecoration(
        //     gradient: new LinearGradient(
        //   colors: [Colors.yellow, Colors.black12],
        //   begin: const FractionalOffset(0.0, 0.0),
        //   end: const FractionalOffset(1.0, 0.0),
        //   stops: [0.0, 1.0],
        //   tileMode: TileMode.clamp,
        // )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Used Books e-Shop",
                style: TextStyle(
                  color: Colors.green[400],
                  fontSize: 32.0,
                  //fontWeight: FontWeight.bold,
                  fontFamily: "Signatra",
                ),
              ),
              SizedBox(
                height: 10.0,
              ),

                 Image.asset("images/logo1.png"),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Search Used Books",
                style: TextStyle(
                  color: Colors.red[400],
                  fontSize: 32.0,
                  //fontWeight: FontWeight.bold,
                  fontFamily: "Signatra",
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Or",
                style: TextStyle(
                  color: Colors.blueAccent[200],
                  fontSize: 24.0,
                  fontFamily: "Signatra",
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "sell Your Books",
                style: TextStyle(
                  color: Colors.red[400],
                  fontSize: 32.0,
                  fontFamily: "Signatra",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
