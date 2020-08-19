import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/db/users.dart';
import 'package:shoppingapp/provider/user_provider.dart';
class Single_cart_product extends StatelessWidget {
  final cart_prod_id;
  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_price;
  final cart_prod_quantity;
  Single_cart_product(
      {this.cart_prod_id,this.cart_prod_name,
      this.cart_prod_picture,
      this.cart_prod_quantity,
      this.cart_prod_price});
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Card(
      child: ListTile(
        leading: Image.network(
          cart_prod_picture,
          width: 80,
          height: 80,
        ),
        title: Text(cart_prod_name),
        subtitle: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text("Quantity"),
                ),
                Padding(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    cart_prod_quantity.toString()+"kg",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                IconButton(icon: Icon(Icons.clear), onPressed: ()async{
                  dynamic result = await UserServices(uid: user.uid).removeFromCart(cart_prod_id);
                  if(result!=null){
                    Fluttertoast.showToast(msg: "Failed to remove from favorites");
                  }
                  else{
                    Fluttertoast.showToast(msg: "Removed from favorites");
                  }
                }),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "\$"+cart_prod_price.toString(),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
