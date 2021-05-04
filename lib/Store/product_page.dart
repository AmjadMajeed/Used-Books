import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:e_shop/Models/item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:e_shop/Store/storehome.dart';

class ProductPage extends StatefulWidget {
  final ItemModel itemModel;

  ProductPage({this.itemModel});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int quantityOfItems = 1;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(

          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: ()=> Navigator.pop(context),
            ),
            title: Center(child: Text("Detailed Page")),
          ),
          //drawer: MyDrawer(),
          body: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: Image.network(widget.itemModel.thumbnailUrl),
                        ),
                        Container(
                          color: Colors.grey[300],
                          child: SizedBox(
                            height: 1.0,
                            width: double.infinity,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.itemModel.price == '0' || widget.itemModel.price == 0 ?
                            Container(
                              color: Colors.red,
                              height: 30.0,
                              width: 50.0,
                              child: Center(
                                //width: MediaQuery.of(context).size.width/2,
                                child: Text(
                                  "Free",
                                  style: boldTextStyle,
                                ),
                              ),
                            ):
                            Text("Price: "+
                                widget.itemModel.price.toString() + " Rs" ,
                              style: boldTextStyle,
                            ),
                            Divider(color: Colors.green,),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              widget.itemModel.title,
                              style: boldTextStyle,
                            ),
                            Divider(color: Colors.green,),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text("Author: "+ widget.itemModel.shortInfo,
                              style: boldTextStyle,
                            ),
                            Divider(color: Colors.green,),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                             "Description: "+ widget.itemModel.longDescription,
                            ),
                            Divider(color: Colors.green,),
                            SizedBox(
                              height: 10.0,
                            ),
                            widget.itemModel.uploadBy.toString() == "null"?
                            Text("Seller Name: "+ "Added In Testing"):
                            Text("Seller Name: "+ widget.itemModel.uploadBy),
                            SizedBox(
                              height: 10.0,
                            ),

                           widget.itemModel.UploaderPhoneNumber.toString() == "null" ?
                               Text("Seller Contact: No Number Given") :
                               Text("Seller Contact: "+ widget.itemModel.UploaderPhoneNumber.toString()),

                            SizedBox(
                              height: 10.0,
                            ),
                            widget.itemModel.location.toString() == "null" ?
                            Text("Seller City: No city") :
                            Text("Seller City: "+ widget.itemModel.location.toString()),
                          ],
                        ),
                      ),
                    ),
                   // Padding(
                    //   padding: EdgeInsets.all(8.0),
                    //   child: Center(
                    //     child: InkWell(
                    //       onTap: (){
                    //
                    //       },
                    //      // onTap: ()=> checkItemInCart(widget.itemModel.shortInfo, context),
                    //       child: Container(
                    //         color: Colors.green,
                    //         width: MediaQuery.of(context).size.width -40.0,
                    //         height: 50.0,
                    //         child: Center(
                    //           child: Text("Add to request Queue",style: TextStyle(color: Colors.white),),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}

const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);
