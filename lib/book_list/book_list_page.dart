import 'package:book_list_sample/add_book/add_book_page.dart';
import 'package:book_list_sample/book_list/book_list_model.dart';
import 'package:book_list_sample/domain/book.dart';
import 'package:book_list_sample/edit_book/edit_book_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class BookListPage extends StatelessWidget {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('books').snapshots();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBookList(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            '本一覧',
          ),
        ),
        body: Center(
          child: Consumer<BookListModel>(builder: (context, model, child) {
            final List<Book>? books = model.books;

            if (books == null) {
              return CircularProgressIndicator();
            }

            final List<Widget> widgets = books
                .map(
                  // flutter_slidableの実装
                  (book) => Slidable(
                    //更新したい本を左へスワイプして表示されるメニュー
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          // An action can be bigger than the others.

                          backgroundColor: Colors.black45,
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: '編集',
                          onPressed: (BuildContext context) async {
                            //編集画面に遷移

                            final String? title = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditBookPage(book),
                              ),
                            );

                            if (title != null) {
                              _showConfirmSnackBar(book.title, context);
                            }
                            model.fetchBookList();
                          },
                        ),
                        SlidableAction(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: '削除',
                          onPressed: (BuildContext context) async {
                            //削除をするか聞いてから削除
                          },
                        ),
                      ],
                    ),
                    // The child of the Slidable is what the user sees when the
                    // component is not dragged.
                    child: ListTile(
                      title: Text(book.title),
                      subtitle: Text(book.author),
                    ),
                  ),
                )
                .toList();
            return ListView(
              children: widgets,
            );
          }),
        ),
        floatingActionButton: Consumer<BookListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            onPressed: () async {
              //画面遷移
              final bool? added = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookPage(),
                  fullscreenDialog: true, //遷移先の画面が下から上へ登ってくるように表示される
                ),
              );

              if (added != null && added) {
                final snackBar = SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("本を追加しました"),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }

              model.fetchBookList();
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          );
        }),
      ),
    );
  }
}

void _showConfirmSnackBar(title, BuildContext context) {
  final snackBar = SnackBar(
    backgroundColor: Colors.green,
    content: Text("$titleを編集しました"),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
