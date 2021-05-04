//1st working storehome
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/uploadItems.dart';
import 'package:e_shop/Store/product_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import '../Widgets/myDrawer.dart';
import '../Models/item.dart';

double width;

class StoreHome extends StatefulWidget {
  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  TextEditingController Searchcontroller = new TextEditingController();
  var selectedItem = "items";
  var search = 0;
  var value = 0;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: InkWell(
                    onTap: () {
                      setState(() {
                        value = 0;
                        print(value);
                      });
                    },
                    child: Image.asset(
                      "images/books.jpg",
                      fit: BoxFit.cover,
                    ),
                  )),
              floating: true,
              expandedHeight: 130.0,
              actions: <Widget>[
                Row(
                  children: [
                    value == 0
                        ? InkWell(
                            child: Icon(Icons.search),
                            onTap: () {
                              setState(() {
                                value = 1;
                              });
                            },
                          )
                        : Container(
                            child: Center(
                              child: Container(
                                //height: 50,
                                width: MediaQuery.of(context).size.width / 2,
                                // margin: EdgeInsets.only(left: 2, right: 2),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      search = 2;
                                    });
                                  },
                                  child: CupertinoTextField(
                                    keyboardType: TextInputType.text,
                                    placeholder: 'Search',
                                    controller: Searchcontroller,
                                    prefix: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          2.0, 0.0, 0.0, 0.0),
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      width: 6,
                    ),
                    value == 0
                        ? TextButton(
                            child: Text(
                              "Add Book".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.all(10)),
                                foregroundColor: MaterialStateProperty.all<Color>(
                                    Colors.white),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side:
                                            BorderSide(color: Colors.white)))),
                            onPressed: () {
                              Route route = MaterialPageRoute(
                                  builder: (c) => UploadPage());
                              Navigator.push(context, route);
                            })
                        : TextButton(
                            child: Text(
                              "Search".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.all(10)),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(Colors.white),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Colors.white)))),
                            onPressed: () {
                              setState(() {
                                search = 2;
                              });
                            }),
                  ],
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(
                    height: 5.0,
                  ),
                  Center(
                    child: Text("Browse Categories"),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    height: 33.0,
                    child: new ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          SizedBox(
                            width: 5.0,
                          ),
                          Container(
                            child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    selectedItem = "items";
                                    search = 0;
                                  });
                                },
                                child: Text("All Books"),
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Colors.red))))),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                selectedItem = 'Academic';
                                search = 1;
                              });
                            },
                            child: Text("Academic"),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedItem = 'Art';
                                  search = 1;
                                });
                              },
                              child: Text("Arts & Photography"),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side:
                                              BorderSide(color: Colors.red))))),
                          SizedBox(
                            width: 10.0,
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                selectedItem = 'Biographies';
                                search = 1;
                              });
                            },
                            child: Text("Biographies & Memoire"),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedItem = 'Business';
                                  search = 1;
                                });
                              },
                              child: Text("Business & Investing"),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side:
                                              BorderSide(color: Colors.red))))),
                          SizedBox(
                            width: 10.0,
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedItem = 'History';
                                  search = 1;
                                });
                              },
                              child: Text("History"),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side:
                                              BorderSide(color: Colors.red))))),
                          SizedBox(
                            width: 10.0,
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedItem = 'Cookbooks,Foods';
                                  search = 1;
                                });
                              },
                              child: Text("Cookbooks, Foods"),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side:
                                              BorderSide(color: Colors.red))))),
                          SizedBox(
                            width: 10.0,
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedItem = "Religions";
                                  search = 1;
                                });
                              },
                              child: Text("Religions"),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side:
                                              BorderSide(color: Colors.red))))),
                          SizedBox(
                            width: 10.0,
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedItem = "Sci-fi";
                                  search = 1;
                                });
                              },
                              child: Text("Sci-fi"),
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side:
                                              BorderSide(color: Colors.red))))),
                        ]),
                  );
                },
                childCount: 1,
              ),
            ),
            search == 1
                ? StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection('items')
                        .where('category', isEqualTo: selectedItem)
                        .orderBy("publishedDate", descending: true)
                        .snapshots(),
                    builder: (context, dataSnapShot) {
                      return !dataSnapShot.hasData
                          ? SliverToBoxAdapter(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : SliverStaggeredGrid.countBuilder(
                              crossAxisCount: 2,
                              staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                              itemBuilder: (context, index) {
                                ItemModel model = ItemModel.fromJson(
                                    dataSnapShot.data.documents[index].data);
                                return sourceInfo(model, context);
                              },
                              itemCount: dataSnapShot.data.documents.length,
                            );
                    },
                  )
                : search == 0
                    ? StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection('items')
                            .orderBy("publishedDate", descending: true)
                            .snapshots(),
                        builder: (context, dataSnapShot) {
                          return !dataSnapShot.hasData
                              ? SliverToBoxAdapter(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : SliverStaggeredGrid.countBuilder(
                                  crossAxisCount: 2,
                                  staggeredTileBuilder: (c) =>
                                      StaggeredTile.fit(1),
                                  itemBuilder: (context, index) {
                                    ItemModel model = ItemModel.fromJson(
                                        dataSnapShot
                                            .data.documents[index].data);
                                    return sourceInfo(model, context);
                                  },
                                  itemCount: dataSnapShot.data.documents.length,
                                );
                        },
                      )
                    : StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection('items')
                            .where('title',
                                isGreaterThanOrEqualTo: Searchcontroller.text)
                            // .orderBy(Firebase.Firestore.FieldPath.documentId())
                            .snapshots(),
                        builder: (context, dataSnapShot) {
                          return !dataSnapShot.hasData
                              ? SliverToBoxAdapter(
                                  child: Center(
                                    child: Center(
                                      child: Text("No Book found"),
                                    ),
                                  ),
                                )
                              : SliverStaggeredGrid.countBuilder(
                                  crossAxisCount: 2,
                                  staggeredTileBuilder: (c) =>
                                      StaggeredTile.fit(1),
                                  itemBuilder: (context, index) {
                                    ItemModel model = ItemModel.fromJson(
                                        dataSnapShot
                                            .data.documents[index].data);
                                    return sourceInfo(model, context);
                                  },
                                  itemCount: dataSnapShot.data.documents.length,
                                );
                        },
                      ),
          ],
        ),
      ),
    );
  }
}

Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
 return InkWell(
          onTap: () {
            //print(diffrence);print("dsghdjghhhhhhhhhhhhhhhhhhlllllllllllllllllllllllllllllllll");
            Route routs = MaterialPageRoute(
                builder: (_) => ProductPage(itemModel: model));
            Navigator.push(context, routs);
          },
          splashColor: Colors.yellow,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            elevation: 10.0,
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: Container(
                height: 200.0,
                width: width,
                child: Column(
                  children: [
                    Image.network(
                      model.thumbnailUrl,
                      height: 130.0,
                      width: width / 2,
                    ),
                    // SizedBox(
                    //   width: 4.0,
                    // ),
                    Expanded(
                        child: Text(
                      model.title,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    )),
                    Expanded(
                        child: Text(
                      "By:" + model.shortInfo,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        );

}
