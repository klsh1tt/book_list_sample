import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'edit_profile_model.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage(this.name, this.description);
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditProfileModel>(
      create: (_) => EditProfileModel(
        name,
        description,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'プロフィール編集',
          ),
        ),
        body: Center(
          child: Consumer<EditProfileModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: model.nameController,
                    decoration: InputDecoration(
                      hintText: '名前',
                    ),
                    onChanged: (text) {
                      model.setName(text);
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: model.descriptionController,
                    decoration: InputDecoration(
                      hintText: '自己紹介',
                    ),
                    onChanged: (text) {
                      model.setDescription(text);
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: model.isUpdated()
                        ? () async {
                            //追加の処理
                            try {
                              await model.update();
                              Navigator.of(context).pop();
                            } catch (e) {
                              //エラー時、SnackBarを表示
                              final snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(e.toString()),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          }
                        : null,
                    child: Text('更新する'),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
