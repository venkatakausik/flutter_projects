import 'package:flutter/material.dart';
import 'package:shoppingapp/pages/product_details.dart';
class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var prod_list =[
    {
      "name":"Strawberry",
      "picture":"images/product-2.jpg",
      "old_price":120,
      "price":90,
    },
    {
      "name":"Tomato",
      "picture":"images/product-5.jpg",
      "old_price":100,
      "price":70,
    },
    {
      "name":"Carrot",
      "picture":"images/product-7.jpg",
      "old_price":150,
      "price":90,
    },
    {
      "name":"MilkShakes",
      "picture":"images/product-8.jpg",
      "old_price":150,
      "price":90,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: prod_list.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2
        ), itemBuilder: (BuildContext context,int index){
     return Single_prod(prod_name: prod_list[index]['name'],prod_picture: prod_list[index]['picture'],
       prod_price: prod_list[index]['price'],
     );
    });
  }
}
class Single_prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_price;
  Single_prod({this.prod_name,this.prod_picture,this.prod_price});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(tag: prod_name, child:Material(
        child: InkWell(
          onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductDetails(
            product_detail_name: prod_name,product_detail_picture: prod_picture,
            product_detail_price: prod_price,
          ))),
          child: GridTile(
            footer: Container(
              color: Colors.white70,
              child: ListTile(
                title: Text(prod_name,style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),),
                trailing: Text("\$$prod_price",style: TextStyle(
                  color: Colors.lightGreen,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),),
              ),
            ),
              child:Image.asset(prod_picture,
              fit: BoxFit.cover,),),
        )
      ) ),
    );
  }
}
