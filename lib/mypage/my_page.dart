import 'package:book_list_sample/mypage/my_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyModel>(
      create: (_) => MyModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'マイページ',
          ),
        ),
        body: Center(
          child: Consumer<MyModel>(builder: (context, model, child) {
            return Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '名前',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text('メールアドレス'),
                    Text('自己紹介'),
                  ],
                ),
                if (model.isLoading)
                  Container(
                    color: Colors.black54,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
              ],
            );
          }),
        ),
      ),
    );
  }
}
