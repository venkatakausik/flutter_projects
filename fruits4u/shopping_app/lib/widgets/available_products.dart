import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/db/products.dart';
import 'available_card.dart';

class AvailableProducts extends StatefulWidget {
  @override
  _AvailableProductsState createState() => _AvailableProductsState();
}

class _AvailableProductsState extends State<AvailableProducts> {
  ProductService _productService = ProductService();
  List<DocumentSnapshot> productsList = <DocumentSnapshot>[];
  List<String> list = <String>[];
  void initState(){
    super.initState();
    _getProducts();
  }
  @override
  Widget build(BuildContext context) {
      return productsList.length==0?Container(
          child:Center(
            child: Text("Loading",style: TextStyle(color: Colors.deepOrangeAccent),),
          )
      ):Container(
          height: 200,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (_, index) {
                return FeaturedCard(
                    name: productsList[index].data['name'],
                    price: productsList[index].data['price'],
                    picture: productsList[index].data['image'],
                    available: productsList[index].data['available'],
                    category: productsList[index].data['category'],
                    id: productsList[index].data['id'],
                    fav: false
                );
              }));
  }

  _getProducts() async{
    List<DocumentSnapshot> data = await _productService.getAvailableProducts();
    setState(() {
      productsList = data;
    });
  }

}