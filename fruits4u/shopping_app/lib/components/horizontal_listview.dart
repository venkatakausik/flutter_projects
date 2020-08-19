import 'package:flutter/material.dart';
import 'package:shoppingapp/widgets/fruits.dart';
import 'package:shoppingapp/widgets/vegetables.dart';
class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            image_location: 'images/category-1.jpg',
            image_caption: 'Vegetables',
          ),
          Category(
            image_location: 'images/category-2.jpg',
            image_caption: 'Fruits',
          ),
          Category(
            image_location: 'images/category-3.jpg',
            image_caption: 'Juices',
          ),
          Category(
            image_location: 'images/category-4.jpg',
            image_caption: 'Dry-Fruits',
          ),
        ],
      ),
    );
  }
}
class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;
  Category({this.image_location,this.image_caption});
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(2.0),
    child: InkWell(
      onTap: (){
          switch(image_caption){
            case "Fruits":
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Fruits()));break;
            case "Vegetables":
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Vegetables()));break;
          }},
      child: Container(
        width: 100.0,
        child: ListTile(
          title: Image.asset(image_location,width: 80,height: 80,),
          subtitle: Container(
            alignment: Alignment.topCenter,
            child: Text(image_caption),
          ) ,
        ),
      ),
    ),
    );
  }
}

