import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/components/horizontal_listview.dart';
import 'package:shoppingapp/components/loading.dart';
import 'package:shoppingapp/db/users.dart';
import 'package:shoppingapp/pages/cart.dart';
import 'package:shoppingapp/pages/myAccount.dart';
import 'package:shoppingapp/provider/user_provider.dart';
import 'package:shoppingapp/widgets/allProducts.dart';
import 'package:shoppingapp/widgets/available_products.dart';
import 'package:shoppingapp/widgets/favorites.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserProvider _provider = UserProvider();
  String name;
  String email;
  User user;
  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    _getUserinfo();
    Widget image_carousel = Container(
      height: 150.0,
      child: Carousel(
        boxFit: BoxFit.cover,
        images:[
          AssetImage('images/bg_1.jpg'),
          AssetImage('images/bg_2.jpg'),
          AssetImage('images/bg_3.jpg'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        dotBgColor: Colors.transparent,
        dotColor: Colors.green,
        indicatorBgPadding: 2.0,
      ),
    );
    return (name==null && email == null)?Loading():Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.green,
        title: Center(child: Text('Fruits4U'),),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart())))
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
//            header
            new UserAccountsDrawerHeader(
              accountName: Text(name),
              accountEmail: Text(email),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white,),
                ),
              ),
              decoration: new BoxDecoration(
                  color: Colors.green[500]
              ),
            ),

//            body

            InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage())),
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(Icons.home,color:Colors.green),
              ),
            ),

            InkWell(
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));},
              child: ListTile(
                title: Text('My account'),
                leading: Icon(Icons.person,color:Colors.green),
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('My Orders'),
                leading: Icon(Icons.shopping_basket,color:Colors.green),
              ),
            ),

            InkWell(
              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Favorites()));},
              child: ListTile(
                title: Text('Favourites'),
                leading: Icon(Icons.favorite,color:Colors.green),
              ),
            ),
            InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart())),
              child: ListTile(
                title: Text('My cart'),
                leading: Icon(Icons.shopping_cart,color:Colors.green),
              ),
            ),

            Divider(),

            InkWell(
              onTap: ()async{
              _provider.signOut();
              },
              child: ListTile(
                title: Text('Log out'),
                leading: Icon(Icons.transit_enterexit, color: Colors.grey,),
              ),
            ),

          ],
        ),
      ),

      body: new ListView(
        children: <Widget>[
          //image carousel begins here
          image_carousel,

          //padding widget
          new Padding(padding: const EdgeInsets.all(10.0),
            child: Container(
                alignment: Alignment.centerLeft,
                child: new Text('Categories')),),

          //Horizontal list view begins here
          HorizontalList(),

          //padding widget
          new Padding(padding: const EdgeInsets.all(8.0),
            child: Container(
                alignment: Alignment.centerLeft,
                child: new Text('Available products')),),
          AvailableProducts(),
          Material(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.transparent,
              elevation: 0.0,
              child: MaterialButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AllProducts()));
                },
                child: Text(
                  "More Products",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              )),
        ],
      ),
    );
  }

  void _getUserinfo()async{
    await UserServices(uid: user.uid).getUserData().then((value){
      setState(() {
        name = value['name'];
        email = value['email'];
      });
    });
  }
}
