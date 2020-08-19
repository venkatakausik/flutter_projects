import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoppingapp/models/product.dart';

class ProductService {
  Firestore _firestore = Firestore.instance;
  String collection = "products";

  Future<List<DocumentSnapshot>> getAvailableProducts() =>
    _firestore.collection(collection).where("available",isEqualTo: true).getDocuments().then((snapshot){
      return snapshot.documents;});
  Future<List<DocumentSnapshot>> getVegetables() =>
      _firestore.collection(collection).where("category",isEqualTo: "vegetables").getDocuments().then((snapshot){
        return snapshot.documents;});
  Future<List<DocumentSnapshot>> getFruits() =>
      _firestore.collection(collection).where("category",isEqualTo: "fruits").getDocuments().then((snapshot){
        return snapshot.documents;});
 Future<DocumentSnapshot> getProducts(String pid) async =>
      _firestore.collection(collection).document(pid).get().then((value) => value);
}