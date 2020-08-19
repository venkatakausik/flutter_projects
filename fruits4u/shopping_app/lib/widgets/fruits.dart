import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/db/products.dart';
import 'package:shoppingapp/pages/cart.dart';
import 'package:shoppingapp/pages/home.dart';

import 'available_card.dart';

class Fruits extends StatefulWidget {
  @override
  _FruitsState createState() => _FruitsState();
}

class _FruitsState extends State<Fruits> {
  ProductService _productService = ProductService();
  List<DocumentSnapshot> productsList = <DocumentSnapshot>[];
  List<String> list = <String>[];
  void initState(){
    _getProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.2,
          backgroundColor: Colors.green[500],
          title: InkWell(
            onTap: (){Navigator.of(context).push(MaterialPageRoute(builder:(context)=>HomePage()));},
            child:Center(child: Text('Fruits')),
          ),
          actions: <Widget>[
            new IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
                }),
          ],
        ),
        body:Container(
            height: double.infinity,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: productsList.length,
                itemBuilder: (_, index) {
                  return FeaturedCard(
                    name: productsList[index].data['name'],
                    price: productsList[index].data['price'],
                    picture: productsList[index].data['image'],
                    available: productsList[index].data['available'],
                    category: productsList[index].data['category'],
                    id: productsList[index].data['id'],
                    fav: false,
                  );
                })));
  }

  _getProducts() async{
    List<DocumentSnapshot> data = await _productService.getFruits();
    setState(() {
      productsList = data;
    });
  }

}