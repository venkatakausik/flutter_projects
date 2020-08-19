import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/components/cart_product.dart';
import 'package:shoppingapp/db/products.dart';
import 'package:shoppingapp/db/users.dart';
import 'package:shoppingapp/models/product.dart';
import 'package:shoppingapp/provider/user_provider.dart';
class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<Product> Products_on_cart = <Product>[];
  List<double> qList = <double>[];
  User user;
  double total_price;
  ProductService _productService = ProductService();
  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    _getCartproducts();
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        backgroundColor: Colors.green[500],
        title: Center(child: Text('Cart')),
      ),
      body: Products_on_cart.length==0?Container(
          child:Center(
            child: Text("No Items in Cart",style: TextStyle(color: Colors.deepOrangeAccent),),
          )
      ):ListView.builder(
          itemCount: Products_on_cart.length,
          itemBuilder: (context, index) {
            return Single_cart_product(
              cart_prod_id : Products_on_cart[index].id,
              cart_prod_name: Products_on_cart[index].name,
              cart_prod_picture: Products_on_cart[index].picture,
              cart_prod_quantity: qList[index],
              cart_prod_price: Products_on_cart[index].price*qList[index],
            );
          }),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
                child: ListTile(
              title: Text(
                'Total',
              ),
              subtitle: Products_on_cart.length==0?Text("\$0"):Text("\$"+total_price.toString()),
            )),
            Expanded(
                child: MaterialButton(
              onPressed: () {},
              child: Text(
                "Check out",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
                  color: Colors.green,
            ),
            )
          ],
        ),
      ),
    );
  }
  _getCartproducts()async{
    List<DocumentSnapshot> data = await UserServices(uid:user.uid).getCart();
    double sum=0;
    List<Product> plist = <Product>[];
    List<double> quantityList = <double>[];
    for(int i=0;i<data.length;i++){
      quantityList.add(data[i].data['quantity']);
      DocumentSnapshot snapshot = await _productService.getProducts(data[i].data['id']);
      Product p=Product.fromSnapShot(snapshot);
    plist.add(p);
      sum+=p.price*data[i].data['quantity'];
    }
    setState(() {
      Products_on_cart = plist;
      qList = quantityList;
      total_price = sum;
    });
  }
}
