import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sheets/api/sheets/user_sheets_api.dart';
import 'package:sheets/model/user.dart';
import 'package:sheets/widget/user_form_widget.dart';
import 'package:http/http.dart' as http;

class ModifySheetPage extends StatefulWidget {
  const ModifySheetPage({Key? key}) : super(key: key);

  @override
  State<ModifySheetPage> createState() => _ModifySheetPageState();
}

class _ModifySheetPageState extends State<ModifySheetPage> {
  List lst = [];
  List result = [];
  // https://docs.google.com/spreadsheets/d/e/2PACX-1vRrZ4AalTxoyDC-ZYEPlFRNRp2BEDDf1sZ8Xp7hxnVfU2lqO0SMNIkjxZn6YU0XKcoVjx12lIuMuNpG/pubhtml

  Future<void> getUsers() async {
    http.Response res = await http.get(
      Uri.parse(
          "https://script.google.com/macros/s/AKfycbyd33hfkgDhT-MAyEAtPqPWaiyQ-pTH5pMYM1I26mebh2fnAaX-sr2BX1Mi7mDnqzM1/exec"),
// headers: {'Content-Type':'application/json',
// "Access-Control-Allow-Origin": "*",
//   "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
//   "Access-Control-Allow-Methods": "POST, OPTIONS"},
      //  body: jsonEncode(<String, String>{
      //         'name': name,
      //         'email': email,
      //       }
      //  )
    );

    lst = jsonDecode(res.body.toString());
    //print(lst);
    result = jsonDecode(res.body);
    Map ress = result[0];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Sheet API'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.extended(
                  // backgroundColor: const Color(0xff03dac6),
                  foregroundColor: Colors.white,
                  onPressed: () {
                    getUsers();
                  },
                  label: const Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "SEARCH",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: SizedBox(
                        width: 5,
                        child: Text(
                          'Id:',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 5,
                        child: Text(
                          'Name:',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 5,
                        child: Text(
                          'Email:',
                          style: TextStyle(),
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                  rows: lst
                      .map(
                        (e) => DataRow(
                          cells: <DataCell>[
                            DataCell(SizedBox(
                                width: 5,
                                child: Text(
                                  '${e['id']}',
                                  style: const TextStyle(
                                    fontSize: 9,
                                  ),
                                  textAlign: TextAlign.center,
                                ))),
                            DataCell(SizedBox(
                                width: 5,
                                child: Text(
                                  '${e['name']}',
                                  style: const TextStyle(
                                    fontSize: 9,
                                  ),
                                  textAlign: TextAlign.center,
                                ))),
                            DataCell(SizedBox(
                                width: 150,
                                child: Text(
                                  '${e['email']}',
                                  style: const TextStyle(
                                    fontSize: 9,
                                  ),
                                  textAlign: TextAlign.center,
                                ))),
                          ],
                        ),
                      )
                      .toList()),
            ),
          ),
        ],
      ),
    );
  }
}
