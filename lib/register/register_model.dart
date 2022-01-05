import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisterModel extends ChangeNotifier {
  final titleController = TextEditingController();
  final authorController = TextEditingController();

  String? email;
  String? password;

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  Future signUp() async {
    this.email = titleController.text;
    this.password = authorController.text;

    // firebase authでユーザ作成

    // firestoreに追加

    // await FirebaseFirestore.instance.collection('books').doc(book.id).update({
    //   'title': email,
    //   'author': password,
    // });
  }
}
