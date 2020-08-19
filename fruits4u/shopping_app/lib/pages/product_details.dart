import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/db/users.dart';
import 'package:shoppingapp/pages/cart.dart';
import 'package:shoppingapp/pages/home.dart';
import 'package:shoppingapp/provider/user_provider.dart';
class ProductDetails extends StatefulWidget {
  final product_detail_name;
  final product_detail_picture;
  final product_detail_price;
  final product_detail_available;
  final product_detail_category;
  final product_detail_id;
  var prod_fav;
  ProductDetails(
      {this.product_detail_name,
      this.product_detail_picture,
      this.product_detail_price,this.product_detail_available,this.product_detail_category,this.product_detail_id,this.prod_fav});
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _formKey = GlobalKey<FormState>();
  double _currentQuantity;
  List<DropdownMenuItem>  quantityDropDown = <DropdownMenuItem<double>>[
    DropdownMenuItem(child: Text("500g"),value:0.5,),DropdownMenuItem(child:Text("1kg"),value: 1,),DropdownMenuItem(child: Text("2kg"),value:2,),DropdownMenuItem(child: Text("3kg"),value: 3)
  ];
  @override
  void initState(){
    super.initState();
    setState(() {
      _currentQuantity = quantityDropDown[0].value;
    });
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        backgroundColor: Colors.green[500],
        title: InkWell(
          onTap: (){Navigator.of(context).push(MaterialPageRoute(builder:(context)=>HomePage()));},
          child:Center(child: Text('Fruits4U')),
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
      body: ListView(
        children: <Widget>[
          Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.network(widget.product_detail_picture),
              ),
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(
                    widget.product_detail_name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "\$${widget.product_detail_price}/kg",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  trailing: Text(widget.product_detail_available?"Available":"Not Available",style: TextStyle(color: Colors.deepOrangeAccent,fontWeight: FontWeight.bold),),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Quantity',style: TextStyle(color: Colors.deepOrangeAccent,),),
              ),
              Form(
                key:_formKey,
                child: DropdownButton<double>(items: quantityDropDown, onChanged: changeSelectedQuantity,value: _currentQuantity,),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: MaterialButton(
                onPressed: () {},
                color: Colors.deepOrangeAccent,
                textColor: Colors.white,
                elevation: 0.2,
                child: Text("Buy now"),
              )),
              IconButton(icon: Icon(Icons.add_shopping_cart), onPressed: ()async{
                if(_formKey.currentState.validate()){
                  dynamic result = await UserServices(uid: user.uid).addToCart(widget.product_detail_id,_currentQuantity);
                  if(result != null){
                    Fluttertoast.showToast(msg: "Failed to add to cart");
                  }
                  else{
                    Fluttertoast.showToast(msg: "Added to cart");
                  }
                }
              }),
              IconButton(onPressed:()async{
                setState(() {
                  widget.prod_fav = !widget.prod_fav;
                });
                if(widget.prod_fav){
                  dynamic result = await UserServices(uid: user.uid).setFav(widget.product_detail_id,);
                  if(result != null){
                    Fluttertoast.showToast(msg: "Failed to add to favorites");
                  }
                  else{
                    Fluttertoast.showToast(msg: "Added to favorites");
                  }
                }
                else{
                  dynamic result = await UserServices(uid: user.uid).removeFav(widget.product_detail_id);
                  if(result!=null){
                    Fluttertoast.showToast(msg: "Failed to remove from favorites");
                  }
                  else{
                    Fluttertoast.showToast(msg: "Removed from favorites");
                  }
                }
              },
                  icon:widget.prod_fav?Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border,color: Colors.red,)
              )
            ],
          ),
          Divider(
            color: Colors.green,
          ),
          ListTile(
            title: Text("Product Details"),
            subtitle: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages"),
          ),
          Divider(),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 5, 5, 5),
                child: Text(
                  "Product name",
                  style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(widget.product_detail_name,style: TextStyle(fontWeight: FontWeight.bold),),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 5, 5, 5),
                child: Text(
                  "Product category",
                  style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(widget.product_detail_category,style: TextStyle(fontWeight: FontWeight.bold),),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 5, 5, 5),
                child: Text(
                  "Product id",
                  style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Text(widget.product_detail_id.toString().substring(0,10)+"...",style: TextStyle(fontWeight: FontWeight.bold),),
              )
            ],
          ),
        ],
      ),
    );
  }
  changeSelectedQuantity(double selectedQuantity) {
    setState(()=>_currentQuantity = selectedQuantity);
  }
  
}