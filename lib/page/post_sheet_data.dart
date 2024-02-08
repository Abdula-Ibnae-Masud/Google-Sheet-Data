import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../api/sheets/user_sheets_api.dart';
import '../model/user.dart';
import 'homepage.dart';

class ModifyFeedbackData extends StatefulWidget {
  const ModifyFeedbackData({Key? key}) : super(key: key);

  @override
  State<ModifyFeedbackData> createState() => _ModifyFeedbackDataState();
}

class _ModifyFeedbackDataState extends State<ModifyFeedbackData> {
  List lst = [];
  List<User> list_user = [];

  Future<void> getUsers() async {
    //list_user.clear();

    final rowCount = await UserSheetsApi.getRowCount();
    //print(rowCount.toString()); // Total row number

    for (int i = 0; i < rowCount.toInt(); i++) {
      final user = await UserSheetsApi.getById(i + 1);

      list_user.add(user!);
      // print(user.toJson());
    }

    /*if (rowCount == list_user) {
      dispose();
    } else {
      const SpinKitPouringHourGlass(
        color: Colors.blue,
        size: 50.0,
      );
    }*/
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
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FloatingActionButton.extended(
              foregroundColor: Colors.white,
              onPressed: () {
                setState(() {
                  //getUsers();
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
          const SpinKitPouringHourGlass(
            color: Colors.blue,
            size: 50.0,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'Id Number',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'User Name',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'User Email',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                      rows: list_user
                          .map((e) => DataRow(cells: [
                                DataCell(
                                  Text('${e.id}'),
                                ),
                                DataCell(
                                  Text('${e.name}'),
                                ),
                                DataCell(
                                  Text('${e.email}'),
                                ),
                                // DataCell(Text('${e['body']}'),
                                // ),
                              ]))
                          .toList()),
                ),
              ),
            ),
          ),
        ]));
  }
}
