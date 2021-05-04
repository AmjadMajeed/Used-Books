import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Store/EditPage.dart';
import 'package:e_shop/Store/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:e_shop/Config/config.dart';
import '../Models/item.dart';

double width;

class MyUploads extends StatefulWidget {
  @override
  _MyUploadsState createState() => _MyUploadsState();
}

class _MyUploadsState extends State<MyUploads> {
  TextEditingController Searchcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          title: Center(child: Text("My Uploads")),
        ),
        // drawer: MyDrawer(),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 10.00,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 1.2,
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: StreamBuilder<QuerySnapshot>(
                      stream:Firestore.instance
                          .collection('items')
                          .where('uploaderUID', isEqualTo: EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
                          .orderBy("publishedDate", descending: true)
                          .snapshots(),
                      builder: (context, dataSnapShot) {
                        return !dataSnapShot.hasData
                            ? Container(
                                color: Colors.red,
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text("No Record Found"),
                                ),
                              )
                            : StaggeredGridView.countBuilder(
                                crossAxisCount: 2,
                                staggeredTileBuilder: (c) =>
                                    StaggeredTile.fit(2),
                                itemBuilder: (context, index) {
                                  DocumentSnapshot ds =
                                      dataSnapShot.data.documents[index];
                                  ItemModel model = ItemModel.fromJson(
                                      dataSnapShot.data.documents[index].data);
                                  return sourceInfo(model, context, ds);
                                },
                                itemCount: dataSnapShot.data.documents.length,
                              );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget sourceInfo(ItemModel model, BuildContext context, DocumentSnapshot ds,
    {Color background, removeCartFunction}) {
  return InkWell(
    onTap: () {
      Route routs =
          MaterialPageRoute(builder: (_) => ProductPage(itemModel: model));
      Navigator.push(context, routs);
    },
    splashColor: Colors.yellow,
    child: Padding(
      padding: EdgeInsets.all(6.0),
      child: Container(
        height: 190.0,
        width: width,
        child: Row(
          children: [
            Image.network(
              model.thumbnailUrl,
              height: 140.0,
              width: 140.0,
            ),
            SizedBox(
              width: 4.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                            child: Text(
                          model.title,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                          ),
                        )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                  model.longDescription.length <= 30
                      ? Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  child: Text(
                                model.longDescription,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black54,
                                ),
                              )),
                            ],
                          ),
                        )
                      : Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  child: Text(
                                model.longDescription.substring(0, 30) + "...",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black54,
                                ),
                              )),
                            ],
                          ),
                        ),

                  SizedBox(
                    height: 10.0,
                  ),

                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                            child: Text(
                          "Author: " + model.shortInfo,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black54,
                          ),
                        )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //SizedBox(height: 20.0,),
                          Padding(
                            padding: EdgeInsets.only(top: 0.0),
                            child: Row(
                              children: [
                                Text(
                                  r"Price Rs ",
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.grey),
                                ),
                                Text(
                                  (model.price).toString(),
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Flexible(
                    child: Container(),
                  ),
                  // todo implement remove item function;
                  Row(
                    children: [
                      Align(
                          alignment: Alignment.bottomLeft,
                          child:  IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.red,
                              size: 28,
                            ),
                            onPressed: () {
                              // List listData= [model.title,model.price,model.uploadBy,model.thumbnailUrl,model.location,model.UploaderPhoneNumber,model.longDescription,
                              // model.shortInfo,model.status,model.publishedDate];
                              showAlertDialogEdit(context, ds,model);
                              //checkItemInCart(model.shortInfo, context);
                            },
                          )
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: removeCartFunction == null
                            ? IconButton(
                          icon: Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                            size: 28,
                          ),
                          onPressed: () {
                            showAlertDialog(context, ds);
                            //checkItemInCart(model.shortInfo, context);
                          },
                        )
                            : IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.yellowAccent,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),

                  Divider(
                    height: 1.0,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void showAlertDialog(BuildContext context, DocumentSnapshot ds) {
  // set up the buttons
  Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      });
  Widget continueButton = FlatButton(
    child: Text("Delete"),
    onPressed: () {

      DeleteItemFromFirebasePersonly(context, ds);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Center(
        child: Text(
      "Alert",
      style: TextStyle(color: Colors.red),
    )),
    content: Text("Would You Want to permanently Delete Your Book?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


// ignore: non_constant_identifier_names
Future DeleteItemFromFirebasePersonly(context, DocumentSnapshot ds) async {
  await Firestore.instance
      .collection("items")
      .document(ds.documentID)
      .delete()
      .then((value) {
        print("success");
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Book deleted"),
        ));
        Route route = MaterialPageRoute(builder: (c) => MyUploads());
        Navigator.pushReplacement(context, route);

  });
}


void showAlertDialogEdit(BuildContext context, DocumentSnapshot ds,ItemModel model) {
  // set up the buttons
  Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      });
  Widget continueButton = FlatButton(
    child: Text("Edit"),
    onPressed: () {
      Route route = MaterialPageRoute(builder: (c) => EditPage(context, ds: ds,itemModel:model),);
      Navigator.push(context, route);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Center(
        child: Text(
          "Alert",
          style: TextStyle(color: Colors.red),
        )),
    content: Text("Edit Book?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future EditItemView(BuildContext context,DocumentSnapshot ds) async{


}

