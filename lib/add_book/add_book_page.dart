import 'package:book_list_sample/add_book/add_book_model.dart';
import 'package:book_list_sample/domain/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBookPage extends StatelessWidget {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('books').snapshots();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '本を追加',
          ),
        ),
        body: Center(
          child: Consumer<AddBookModel>(builder: (context, model, child) {
            return Text('本を追加');
          }),
        ),
      ),
    );
  }
}
