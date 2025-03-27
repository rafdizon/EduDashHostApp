import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edudash_admin/services/auth.dart';
import 'dart:math';

import 'package:logger/logger.dart';

class FireStoreService {
  final CollectionReference quizzes = FirebaseFirestore.instance.collection('custom_quiz');
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final logger = Logger();

  Future<DocumentSnapshot> getUserData() async {
    final id = await Auth().getCurrentUserID();

    final userData = await users.doc(id).get();

    return userData;
  }
  // create
  Future<String?> addCustomGame(Map<String,dynamic> customQuiz) async {
    try {
      String quizId = Random().nextInt(1000000).toString().padLeft(6, '0');
      
      customQuiz['host_id'] = (await Auth().getCurrentUserID()).toString();
      customQuiz.putIfAbsent('date_modified', () => Timestamp.fromDate(DateTime.now()));

      logger.d(customQuiz);

      await quizzes.doc(quizId).set(customQuiz);
      return null;
    } on Exception catch (e) {
      // TODO
      logger.e(e.toString());
      return e.toString();
    }
  }
  
  // read
  Stream<QuerySnapshot> getCustomQuizzes(String userId) {
    final quizzesStream = quizzes.where('host_id', isEqualTo: userId).snapshots();

    return quizzesStream;
  }
  // update
  Future<String?> editCustomeGame(Map<String,dynamic> customQuiz, {required String docId}) async {
    try {
      customQuiz.putIfAbsent('date_modified', () => Timestamp.fromDate(DateTime.now()));

      logger.d(customQuiz);

      await quizzes.doc(docId).set(customQuiz, SetOptions(merge: true));
      return null;
    } on Exception catch (e) {
      // TODO
      logger.e(e.toString());
      return e.toString();
    }
  }
  // delete
  Future<String?> deleteGame({required String docId}) async {
    try {
      await quizzes.doc(docId).delete();

      return null;
    } on Exception catch (e) {
      return e.toString();
    }
  }
}