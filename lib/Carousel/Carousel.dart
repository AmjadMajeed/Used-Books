import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          CarouselSlider(
            items: [

              //1st Image of Slider
              Container(
                margin: EdgeInsets.all(6.0),
                child: Image(image: AssetImage('graphics/bok2.jpg',)),
              ),

              //2nd Image of Slider
              Container(
                margin: EdgeInsets.all(6.0),
                  child: Image(image: AssetImage('graphics/bok1.jpg',)),
              ),


            ],

            //Slider Container properties
            options: CarouselOptions(
              height: 180.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          ),
        ],
      ),

    );
  }
}
