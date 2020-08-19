import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/db/products.dart';
import 'package:shoppingapp/db/users.dart';
import 'package:shoppingapp/models/product.dart';
import 'package:shoppingapp/pages/cart.dart';
import 'package:shoppingapp/pages/home.dart';
import 'package:shoppingapp/provider/user_provider.dart';
import 'available_card.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  ProductService _productService = ProductService();
  List<Product> favList = <Product>[];
//  List<String> list = <String>[];
  User user;
  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    _getFavorites();
    return Scaffold(
        appBar: AppBar(
          elevation: 0.2,
          backgroundColor: Colors.green[500],
          title: InkWell(
            onTap: (){Navigator.of(context).push(MaterialPageRoute(builder:(context)=>HomePage()));},
            child:Center(child: Text('Favorites')),
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
        body:favList.length==0?Container(
          child:Center(
            child: Text("No favorites",style: TextStyle(color: Colors.deepOrangeAccent),),
          )
        ):Container(
            height: double.infinity,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: favList.length,
                itemBuilder: (_, index) {
                  return FeaturedCard(
                    name: favList[index].name,
                    price: favList[index].price,
                    picture: favList[index].picture,
                    available: favList[index].available,
                    category: favList[index].category,
                    id: favList[index].id,
                    fav: true,
                  );
                })));
  }

  _getFavorites() async{
    List<DocumentSnapshot> data = await UserServices(uid:user.uid).getFav();
    List<Product> plist = <Product>[];
    for(int i=0;i<data.length;i++){
     DocumentSnapshot snapshot = await _productService.getProducts(data[i].data['id']);
     plist.add(Product.fromSnapShot(snapshot));
    }
    setState(() {
      favList = plist;
    });
  }

}