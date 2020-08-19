import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/components/loading.dart';
import 'package:shoppingapp/db/products.dart';
import 'package:shoppingapp/models/product.dart';
import 'package:shoppingapp/pages/cart.dart';
import 'package:shoppingapp/pages/home.dart';

import 'available_card.dart';

class AllProducts extends StatefulWidget {
  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  ProductService _productService = ProductService();
  List<Product> productsList = <Product>[];
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
    child:Center(child: Text('All products')),
    ),
    actions: <Widget>[
      new IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {
            showSearch(context: context, delegate: DataSearch(prod_list: productsList));
          }),
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
    body:productsList.length==0?Loading():Container(
        height: double.infinity,
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: productsList.length,
            itemBuilder: (_, index) {
              return FeaturedCard(
                name: productsList[index].name,
                price: productsList[index].price,
                picture: productsList[index].picture,
                available: productsList[index].available,
                category: productsList[index].category,
                id: productsList[index].id,
                fav: false,
              );
            })));
  }

  _getProducts() async{
    List<DocumentSnapshot> data = await _productService.getAvailableProducts();
    List<Product> plist = <Product>[];
    for(int i=0;i<data.length;i++){
      DocumentSnapshot snapshot = await _productService.getProducts(data[i].data['id']);
      plist.add(Product.fromSnapShot(snapshot));
    }
    setState(() {
      productsList = plist;
    });
  }

}
class DataSearch extends SearchDelegate{
  final List<Product> prod_list;
  List<String> names_list = <String>[];
  DataSearch({this.prod_list});
  @override
  void initState(){
    for(int i=0;i<prod_list.length;i++){
      names_list.add(prod_list[i].name);
    }
  }
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: (){
        query = "";
      })
    ];
    throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation), onPressed: (){
      close(context, null);
    });
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    List<Product> list = prod_list.where((element) => element.name.startsWith(query)).toList();
    return Container(
        height: double.infinity,
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: list.length,
            itemBuilder: (_, index) {
              return FeaturedCard(
                name: list[index].name,
                price: list[index].price,
                picture: list[index].picture,
                available: list[index].available,
                category: list[index].category,
                id: list[index].id,
                fav: false,
              );
            }));
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<Product> suggestionList = query.isEmpty?[]:prod_list.where((element) => element.name.startsWith(query[0].toUpperCase()+query.substring(1))).toList();
    return ListView.builder(
    itemCount: suggestionList.length,
    itemBuilder: (context,index)=>
    ListTile(
      onTap: (){
        showResults(context);
      },
      title: Text(suggestionList[index].name),
    )
    );
    throw UnimplementedError();
  }
}