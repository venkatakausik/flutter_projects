import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/pages/home.dart';
import 'package:shoppingapp/pages/login.dart';
import 'package:shoppingapp/provider/user_provider.dart';

void main(){
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
      ),home:MyApp()));
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: UserProvider().user,
      child: MaterialApp(
        home: ScreenController(),
      ),
    );
  }
}
class ScreenController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user =Provider.of<User>(context);
    if(user==null){
      return Login();
    }
    else{
      return HomePage();
    }
  }
}
