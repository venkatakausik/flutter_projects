import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
class CategoryService{
  Firestore _firestore = Firestore.instance;
  String ref="categories";
  MaterialColor active = Colors.red;
  void createCategory(String name){
    var id = Uuid();
    String categoryId  = id.v1();
      _firestore.collection(ref).document(categoryId).setData({'name':name});
  }
  Future<List<DocumentSnapshot>> getCategories() =>
     _firestore.collection(ref).getDocuments().then((snaps){
      return snaps.documents;
    });
  Future<QuerySnapshot> categoryCount() async =>
      _firestore.collection(ref).getDocuments();
}