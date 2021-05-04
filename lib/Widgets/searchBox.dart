import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SearchBoxDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent
      ) =>
      InkWell(
        onTap: ()
        {

        },
        child: Container(
          padding: EdgeInsets.only(left: 10.0,right: 10.0),
         color: Colors.green[200],
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: 80.0,
          child: InkWell(
            child: Container(

              width: MediaQuery.of(context).size.width,
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 10.0),
                  child: Icon(
                    Icons.search,
                    color: Colors.blueAccent,
                  ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Search book by Name,Auther Name...",style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0,
                  ),
                  ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );



  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}


