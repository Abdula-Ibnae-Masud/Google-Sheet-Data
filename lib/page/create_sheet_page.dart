import 'package:flutter/material.dart';

import '../api/sheets/user_sheets_api.dart';
import '../widget/user_form_widget.dart';
import 'homepage.dart';

class CreateSheetPage extends StatelessWidget {
  const CreateSheetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Your Data'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const HomeScreen()));
          },
          icon: const Icon(
            Icons.backspace_rounded,
            size: 40,
          ),
          color: Colors.blueGrey,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(32.0),
        child: UserForm(
          onSavedUser: (user) async {
            final id = await UserSheetsApi.getRowCount() + 1;
            final newUser = user.copy(id: id);
            await UserSheetsApi.insert([newUser.toJson()]);
          },
        ),
      ),
    );
  }
}
