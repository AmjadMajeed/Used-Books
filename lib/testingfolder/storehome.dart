import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Carousel/Carousel.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Store/product_page.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:e_shop/Config/config.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/myDrawer.dart';
import '../Widgets/searchBox.dart';
import '../Models/item.dart';

double width;

class StoreHome extends StatefulWidget {
  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {



  TextEditingController Searchcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.yellow, Colors.black12],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          title: Text(
            "Books",
            style: TextStyle(
              fontSize: 55.0,
              color: Colors.white,
              fontFamily: "Signatra",
            ),
          ),
          centerTitle: true,
          actions: [
            Stack(
              children: [
                IconButton(
                    icon: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.yellow,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => CartPage()));
                    }),
                Positioned(
                  child: Stack(
                    children: [
                      Icon(
                        Icons.brightness_1,
                        size: 20.0,
                        color: Colors.green,
                      ),
                      Positioned(
                        top: 3.0,
                        bottom: 4.0,
                        left: 4.0,
                        child: Consumer<CartItemCounter>(
                          builder: (context, counter, _) {
                            return Text("",
                              //counter.count.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        drawer: MyDrawer(),
        body:  SingleChildScrollView(
          child: Column(
            children: [
            StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection("items")
                      .orderBy("publishedDate", descending: true)
                      .snapshots(),
                  builder: (context, dataSnapShot) {
                    return !dataSnapShot.hasData
                        ? Container(height: 0.0,width: 0.0,):
        StaggeredGridView.countBuilder(
    crossAxisCount: 2,
    staggeredTileBuilder: (c)=> StaggeredTile.fit(1),
              itemBuilder: (context, index) {
      ItemModel model = ItemModel.fromJson(
          dataSnapShot.data.documents[index].data);
      return sourceInfo(model, context);
    },
          itemCount: dataSnapShot.data.documents.length,
      );
    },
    ),
            ],
          ),
        ),

      ),
    );
  }
}

Widget sourceInfo(ItemModel model, BuildContext context,
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
        child: Column(
          children: [
            Image.network(
              model.thumbnailUrl,
              height: 140.0,
              width: width / 2,
            ),
            SizedBox(
              width: 4.0,
            ),
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
        // child: Row(
        //   children: [
        //     Image.network(model.thumbnailUrl,height:140.0,width:140.0,),
        //     SizedBox(width: 4.0,),
        //     Expanded(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           SizedBox(height: 15.0,),
        //           Container(
        //             child: Row(
        //               mainAxisSize: MainAxisSize.max,
        //               children: [
        //                 Expanded(
        //                     child: Text(model.title,style: TextStyle(fontSize: 14.0,color: Colors.black,),)
        //                 ),
        //               ],
        //             ),
        //           ),
        //           SizedBox(height: 5.0,),
        //
        //           Container(
        //             child: Row(
        //               mainAxisSize: MainAxisSize.max,
        //               children: [
        //                 Expanded(
        //                     child: Text(model.shortInfo,style: TextStyle(fontSize: 12.0,color: Colors.black54,),)
        //                 ),
        //               ],
        //             ),
        //           ),
        //           SizedBox(height: 20.0,),
        //           Row(
        //             children: [
        //               Container(
        //                 decoration: BoxDecoration(
        //                   shape: BoxShape.rectangle,
        //                   color: Colors.green,
        //                 ),
        //                 alignment: Alignment.topLeft,
        //                 width: 43.0,
        //                 height: 40.0,
        //                 child: Center(
        //                   child: Column(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [
        //                       Text("Halal",style: TextStyle(fontSize: 15.0,color: Colors.white,fontWeight: FontWeight.normal),),
        //
        //                     ],
        //                   ),
        //
        //                 ),
        //               ),
        //               SizedBox(width: 10.0,),
        //               Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Padding(padding: EdgeInsets.only(top: 0.0),
        //                     child: Row(
        //                       children: [
        //                         Text(r"Price $",style: TextStyle(fontSize: 14.0,color: Colors.grey),
        //                         ),
        //                         Text(
        //                           (model.price ).toString(),
        //                           style: TextStyle(fontSize: 15.0,color: Colors.grey),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ],
        //           ),
        //           Column(
        //             children: [
        //               Container(
        //                 decoration: BoxDecoration(
        //                   shape: BoxShape.rectangle,
        //                   color: Colors.red,
        //                 ),
        //                 alignment: Alignment.topLeft,
        //                 width: 43.0,
        //                 height: 26.0,
        //                 child: Center(
        //                   child: Column(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [
        //                       Text("%off",style: TextStyle(fontSize: 15.0,color: Colors.white,fontWeight: FontWeight.normal),),
        //
        //                     ],
        //                   ),
        //
        //                 ),
        //               ),
        //             ],
        //           ),
        //           Flexible(
        //             child: Container(),
        //           ),
        //           // todo implement Cart item add/remove function;
        //           Align(
        //             alignment: Alignment.centerRight,
        //             child: removeCartFunction == null
        //                 ? IconButton(
        //               icon: Icon(Icons.add_shopping_cart,color: Colors.grey,),
        //               onPressed: (){
        //                 checkItemInCart(model.shortInfo, context);
        //               },
        //             )
        //                 : IconButton(
        //               icon: Icon(Icons.delete,color: Colors.yellowAccent,),
        //               onPressed: (){
        //               },
        //             ),
        //           ),
        //           Divider(height: 1.0,color: Colors.grey,)
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
    ),
  );
}

Widget card({Color primaryColor = Colors.redAccent, String imgPath}) {
  return Container();
}

void checkItemInCart(String shortInfoAsId, BuildContext context) {
  EcommerceApp.sharedPreferences
      .getStringList(EcommerceApp.userCartList)
      .contains(shortInfoAsId)
      ? Fluttertoast.showToast(msg: "Item is Already in cart")
      : addItemToCart(shortInfoAsId, context);
}

addItemToCart(String shortInfoAsId, BuildContext context) {
  List tempCartList =
  EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
  tempCartList.add(shortInfoAsId);

  EcommerceApp.firestore
      .collection(EcommerceApp.collectionUser)
      .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
      .updateData({
    EcommerceApp.userCartList: tempCartList,
  }).then((v) {
    Fluttertoast.showToast(msg: "Item Added in cart successfully");

    EcommerceApp.sharedPreferences
        .setStringList(EcommerceApp.userCartList, tempCartList);

   // Provider.of<CartItemCounter>(context, listen: false).displayResult();
  });
}
