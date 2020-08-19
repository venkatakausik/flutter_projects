import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoppingapp/db/auth.dart';
import 'package:shoppingapp/db/users.dart';
class UserProvider{
  final Auth gAuth = Auth();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid,):null;
  }
  Stream<User> get user{
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }
  Future signInAnon()async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  Future registerWithEmailAndPass(String email,String pass,String name,String mobile)async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = result.user;
      await UserServices(uid:user.uid).createUserData(name,user.email,mobile);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  Future signOut()async{
    try{
      return await _auth.signOut();}
    catch(e){
      print(e.toString());
    }
  }

  Future loginWithEmailAndPass(String email, String password)async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  Future googleSignIn()async{
    try{
      FirebaseUser user = await gAuth.googleSignIn();
      await UserServices(uid: user.uid).createUserData(user.displayName, user.email, user.phoneNumber);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
    }
  }
}

class User {
  final String uid;
  User({this.uid});
}