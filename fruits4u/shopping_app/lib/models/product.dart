import 'package:cloud_firestore/cloud_firestore.dart';
class Product{
  static const  NAME ="name";
  static const  ID ="id";
  static const  CATEGORY ="category";
  static const  PRICE ="price";
  static const  PICTURE ="image";
  static const  AVAILABLE ="available";

  String _name;
  double _price;
  String _id;
  String _category;
  String _picture;
  bool _available;

  String get name => _name;
  String get id => _id;
  String get category => _category;
  String get picture => _picture;
  bool get available => _available;
  double get price => _price;

  Product.fromSnapShot(DocumentSnapshot snapshot){
    _name = snapshot.data[NAME];
    _id = snapshot.data[ID];
    _category = snapshot.data[CATEGORY];
    _picture = snapshot.data[PICTURE];
    _price = snapshot.data[PRICE];
    _available = snapshot.data[AVAILABLE];
  }
}