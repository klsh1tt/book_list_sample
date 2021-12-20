import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditBookModel extends ChangeNotifier {
  String? title;
  String? author;

  Future update() async {
    //null or 空文字なら例外処理を実行する
    if (title == null || title == "") {
      throw '本のタイトルが入力されていません';
    }

    if (author == null || author!.isEmpty) {
      throw '著者が入力されていません';
    }

    // firestoreに追加
    // https://firebase.flutter.dev/docs/firestore/usage/#adding-documents
    await FirebaseFirestore.instance.collection('books').add({
      'title': title,
      'author': author,
    });
  }
}
