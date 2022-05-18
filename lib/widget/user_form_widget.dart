import 'package:flutter/material.dart';
import 'package:sheets/model/user.dart';
import 'package:sheets/widget/button_widget.dart';

class UserForm extends StatefulWidget {
  final ValueChanged<User> onSavedUser;

  const UserForm({Key? key, required this.onSavedUser}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final formkey = GlobalKey<FormState>();
  late TextEditingController controllerName;
  late TextEditingController controllerEmail;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  void initUser() {
    controllerName = TextEditingController();
    controllerEmail = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildName(),
          const SizedBox(
            height: 20,
          ),
          buildEmail(),
          const SizedBox(
            height: 20,
          ),
          buildSubmit(),
        ],
      ),
    );
  }

  Widget buildName() => TextFormField(
        controller: controllerName,
        decoration: const InputDecoration(
            labelText: "Name", border: OutlineInputBorder()),
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter Name' : null,
      );

  Widget buildEmail() => TextFormField(
        controller: controllerEmail,
        decoration: const InputDecoration(
            labelText: "Email", border: OutlineInputBorder()),
        validator: (value) =>
            value != null && !value.contains('@') ? "Enter Email" : null,
      );

  Widget buildSubmit() => Button(
      text: 'Save',
      onClicked: () {
        final form = formkey.currentState;
        final isValid = form!.validate();

        if (isValid) {
          final user = User(
            id: 0,
            name: controllerName.text,
            email: controllerEmail.text,
          );
          widget.onSavedUser(user);
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Submitted Successfully"),
                  content: const Text(
                      "You input data has been recorded successfully"),
                  actions: [
                    Center(
                      child: ElevatedButton(
                        child: const Text(
                          "Ok",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        onPressed: () {
                          controllerName.clear();
                          controllerEmail.clear();
                          Navigator.pop(context, true);
                        },
                      ),
                    ),
                  ],
                  backgroundColor: Colors.green,
                );
              });
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Data Not Submitted"),
                  content: const Text(
                      "You input data has not been recorded successfully, submit again?"),
                  actions: [
                    Center(
                      child: ElevatedButton(
                        child: const Text(
                          "Ok",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context, true);
                          });
                        },
                      ),
                    ),
                  ],
                  backgroundColor: Colors.redAccent,
                );
              });
        }
      });
}
