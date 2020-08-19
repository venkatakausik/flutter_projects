import 'package:cloud_firestore/cloud_firestore.dart';
class UserServices{
  final String uid;
  Firestore _firestore = Firestore.instance;
  String collection = "users";
  UserServices({this.uid});
  Future createUserData(String name,String email,String mobile)async{
    return await _firestore.collection(collection).document(uid).setData({
      "userId" : uid,
      "email":email,
      "name":name,
      "mobile":mobile
    });
  }
  Future<Map<String,dynamic>> getUserData() async {
    return await _firestore.collection(collection).document(uid).get().then((value) => value.data);
  }
  Future updateUserData(String mobile)async{
    return await _firestore.collection(collection).document(uid).updateData({
      "mobile":mobile
    });
  }
    Future setFav(String pid)async{
     return await _firestore.collection(collection).document(uid).collection("fav").document(pid).setData({
      "id":pid,
    });
  }
  Future<List<DocumentSnapshot>> getFav()async{
    return await _firestore.collection(collection).document(uid).collection("fav").getDocuments().then((value){return value.documents;});
  }
  Future removeFav(String pid)async{
     return await _firestore.collection(collection).document(uid).collection("fav").document(pid).delete();
  }
   Future addToCart(String pid,double quantity)async{
    return await _firestore.collection(collection).document(uid).collection("cart").document(pid).setData({
      "id":pid,
      "quantity":quantity
    });
  }
  Future<List<DocumentSnapshot>> getCart()async{
    return await _firestore.collection(collection).document(uid).collection("cart").getDocuments().then((value){return value.documents;});
  }
  Future removeFromCart(String pid)async{
    return await _firestore.collection(collection).document(uid).collection("cart").document(pid).delete();
  }
}