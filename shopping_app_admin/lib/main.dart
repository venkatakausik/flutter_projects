import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingappadmin/db/user_provider.dart';
import 'package:shoppingappadmin/screens/admin.dart';
import 'package:shoppingappadmin/screens/login.dart';

void main(){
  runApp(MaterialApp(debugShowCheckedModeBanner: false,
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
      return Admin();
    }
  }
}
