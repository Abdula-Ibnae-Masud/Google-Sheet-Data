import 'package:flutter/material.dart';

import '../api/sheets/user_sheets_api.dart';
import '../model/user.dart';
import 'homepage.dart';

class FeedbackData extends StatefulWidget {
  const FeedbackData({Key? key}) : super(key: key);

  @override
  State<FeedbackData> createState() => _FeedbackDataState();
}

class _FeedbackDataState extends State<FeedbackData> {
  List lst = [];
  List<User> list_user = [];

  Future<void> getUsers() async {
    //list_user.clear();
    final rowCount = await UserSheetsApi.getRowCount();
    //print(row_count.toString()); // Total row number

    for (int i = 0; i < rowCount.toInt(); i++) {
      final user = await UserSheetsApi.getById(i + 1);

      list_user.add(user!);
    }

    //  final user = await UserSheetsApi.getById();
    //print(list_user.elementAt(3).name);
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Sheet Feedback Data'),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FloatingActionButton.extended(
              foregroundColor: Colors.white,
              onPressed: () {
                setState(() {
                  getUsers();
                });
              },
              label: const Padding(
                padding: EdgeInsets.all(0.0),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "SEARCH FEEDBACK",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: h * 0.7,
            child: ListView.builder(
              itemCount: list_user.length,
              itemBuilder: (context, index) {
                final lst = list_user[index];
                return Column(
                  children: [
                    Card(
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Id: " + lst.id.toString(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Name: " + lst.name,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Email: " + lst.email,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.green),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


/*


  Future<void> getUsers() async {
    final row_count = await UserSheetsApi.getRowCount();
    //print(row_count.toString()); // Total row number

    for (int i = 0; i < row_count.toInt(); i++) {
      final user = await UserSheetsApi.getById(i);

      list_user.add(user!);
    }
    //list_user.clear();
    //  final user = await UserSheetsApi.getById();
    //print(list_user.elementAt(3).name);
  }
  */
