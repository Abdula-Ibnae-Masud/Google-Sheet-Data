import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../api/sheets/user_sheets_api.dart';
import '../model/user.dart';
import '../page/homepage.dart';

class SheetData extends StatefulWidget {
  const SheetData({Key? key}) : super(key: key);

  @override
  State<SheetData> createState() => _SheetDataState();
}

class _SheetDataState extends State<SheetData> {
  List lst = [];
  List<User> list_user = [];
  bool isloading = false;

  Future<void> getUsers() async {
    setState(() {
      isloading = true;
    });

    final rowCount = await UserSheetsApi.getRowCount();
    //print(rowCount.toString()); // Total row number

    for (int i = 0; i < rowCount.toInt(); i++) {
      final user = await UserSheetsApi.getById(i + 1);

      list_user.add(user!);
      // print(user.toJson());
    }

    setState(() {
      isloading = false;
    });
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
        body: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              if (isloading) {
                return buildSpinKitPouringHourGlass();
              } else {
                return buildSheetData();
              }
            }));
  }

  Widget buildSpinKitPouringHourGlass() => const Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 200),
            child: Center(
              child: (SpinKitPouringHourGlass(
                color: Colors.blue,
                size: 70.0,
              )),
            ),
          ),
          Text(
            "Please wait!",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 50,
            ),
          )
        ],
      );

  Widget buildSheetData() => (SingleChildScrollView(
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
                            Text(e.name),
                          ),
                          DataCell(
                            Text(e.email),
                          ),
                          // DataCell(Text('${e['body']}'),
                          // ),
                        ]))
                    .toList()),
          ),
        ),
      ));
}
