import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasedemo/Resources/Models/User_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<UserCredential?> registerUser(UserModel user) async {
    UserCredential userData = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: user.emial.toString(), password: user.password.toString());

    if (userData != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userData.user!.uid)
          .set({
        'uid': userData.user!.uid,
        'email': userData.user!.email,
        'name': user.name,
        'createdAt': user.createdAt,
        'status': user.status
      });
      return userData;
    }
  }

  Future<DocumentSnapshot?> loginUser(UserModel user) async {
    DocumentSnapshot? snap;
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: user.emial.toString(), password: user.password.toString());

    String? token = await userCredential.user!.getIdToken();

    if (userCredential != null) {
      snap = await _userCollection.doc(userCredential.user!.uid).get();

      await _prefs.setString("token", token!);
      await _prefs.setString("name", snap['name']);
      await _prefs.setString("email", snap['email']);
      await _prefs.setString("uid", snap['uid']);

      return snap;
    }
  }



  Future<void>logout()async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    await _prefs.clear();
    await _auth.signOut();

  }


  Future<bool>isLoggedIn()async{

    SharedPreferences _prefs =await SharedPreferences.getInstance();
    String? _token =_prefs.getString('token');

    if(_token == null){
      return false;
    }else {
      return true;
    }

  }


}
