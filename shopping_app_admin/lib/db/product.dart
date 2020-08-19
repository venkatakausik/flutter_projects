import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
class ProductService{
  Firestore _firestore = Firestore.instance;
  String ref="products";
  MaterialColor active = Colors.red;
  void uploadProduct({String productName,String category,String image,double price, bool available}){
    var id = Uuid();
    String productId  = id.v1();
    _firestore.collection(ref).document(productId).setData({
      "name":productName,
      "id":productId,
      "category":category,
      "price":price,
      "available":available,
      "image":image
    });
  }
  Future<QuerySnapshot> productCount() async =>
      _firestore.collection(ref).getDocuments();
}