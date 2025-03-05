import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edudash_admin/pages/dashboard_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get onAuthStateChange => _firebaseAuth.authStateChanges();
  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      await Future.delayed(Duration(seconds: 1));
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (BuildContext context) => DashboardPage()
        )
      );
    } on FirebaseAuthException catch (e) {
      String msg = '';
      if(e.code == 'user-not-found') {
        msg = 'No user found for email, you can sign up';
      }
      else if(e.code == 'wrong-password') {
        msg = 'Wrong password';
      }
      else {
        msg = e.code;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
    
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String role,
    required String username
  }) async {
    try{
      String timeNow = DateTime.now().toString();
      String id = timeNow.replaceAll(RegExp(r"[ \-:]"), "").substring(2, 14);
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      users.doc(id).set({
        'email' : email,
        'role' : role,
        'username' : username,
        'history' : []  
      });
    } on FirebaseAuthException catch (e) {
      String msg = '';
      if(e.code == 'weak-password') {
        msg = 'Password is too weak';
      }
      else if(e.code == 'email-already-in-use') {
        msg = 'Email is already in use in another account';
      }
      
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 12,
      );
    }
    
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> getCurrentUserID() async {
    String? email = currentUser?.email;
    if (email == null) return null;

    var querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .limit(1)
      .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    }
    
    return null;
  }
}