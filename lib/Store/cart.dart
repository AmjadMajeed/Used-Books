import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Address/address.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:e_shop/Counters/totalMoney.dart';
import 'package:e_shop/Widgets/searchBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: ()=> Navigator.pop(context),
          ),
          title: Text("Cart Items"),
        ),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(pinned: true, delegate: SearchBoxDelegate()),
            StreamBuilder<QuerySnapshot>
              (

              stream: Firestore.instance.collection("items").orderBy("publishedDate",descending: true).snapshots(),
              builder: (context, dataSnapShot)
              {
                return !dataSnapShot.hasData
                    ? SliverToBoxAdapter(child: Center(child: circularProgress(),),)
                    : SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 1,
                  staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                  itemBuilder: (context, index)
                  {
                    ItemModel model= ItemModel.fromJson(dataSnapShot.data.documents[index].data);
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
    onTap: (){
      // Route routs = MaterialPageRoute(builder: (_) => ProductPage(itemModel: model));
      // Navigator.pushReplacement(context, routs);
    },
    splashColor: Colors.yellow,
    child: Padding(
      padding: EdgeInsets.all(6.0),
      child: Container(
        height: 190.0,
        width: width,
        child: Row(
          children: [
            Image.network(model.thumbnailUrl,height:140.0,width:140.0,),
            SizedBox(width: 4.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15.0,),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                            child: Text(model.title,style: TextStyle(fontSize: 14.0,color: Colors.black,),)
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0,),

                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                            child: Text(model.shortInfo,style: TextStyle(fontSize: 12.0,color: Colors.black54,),)
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    children: [
                      // Container(
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.rectangle,
                      //     color: Colors.green,
                      //   ),
                      //   alignment: Alignment.topLeft,
                      //   width: 43.0,
                      //   height: 40.0,
                      //   child: Center(
                      //     child: Column(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Text("Halal",style: TextStyle(fontSize: 15.0,color: Colors.white,fontWeight: FontWeight.normal),),
                      //
                      //       ],
                      //     ),
                      //
                      //   ),
                      // ),
                      SizedBox(width: 10.0,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.only(top: 0.0),
                            child: Row(
                              children: [
                                Text(r"Price $",style: TextStyle(fontSize: 14.0,color: Colors.grey),
                                ),
                                Text(
                                  (model.price ).toString(),
                                  style: TextStyle(fontSize: 15.0,color: Colors.grey),
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
                  // todo implement Cart item add/remove function;
                  Align(
                    alignment: Alignment.centerRight,
                    child: removeCartFunction == null
                        ? IconButton(
                      icon: Icon(Icons.add_shopping_cart,color: Colors.grey,),
                      onPressed: (){
                        //checkItemInCart(model.shortInfo, context);
                      },
                    )
                        : IconButton(
                      icon: Icon(Icons.delete,color: Colors.yellowAccent,),
                      onPressed: (){
                      },
                    ),
                  ),
                  Divider(height: 1.0,color: Colors.grey,)
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
