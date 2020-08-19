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
  Future<Map<String,dynamic>> getUserData(String uid) async {
    return await _firestore.collection(collection).document(uid).get().then((value) => value.data);
  }
  Future<QuerySnapshot> getCountOfUsers()async{
    return await _firestore.collection(collection).getDocuments();
  }
}