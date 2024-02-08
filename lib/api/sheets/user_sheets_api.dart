import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';

import '../../model/user.dart';

class UserSheetsApi {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "gsheets-348404",
  "private_key_id": "bf5dd1c47d7f410ba62bc0b9483c2fc5e7a13fe3",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC1Ym116Z62UH8E\nTfRSzEDjkgjYzH7DcRm/WGTZQiTqY4HS+TJqJRbijDcZ5z/8WS8erSXbKfkezRla\nQtjRwjkgbcSDicgd2/45TKUfQRrhL1az0DmoLOuWH0xpOy6Jj9XRzPeNqMz1TNnm\nJFysdvUF3ujLwrvxzEnrXIazLWJizShdeBa08OOl3n9kOvHikf1GaP3JsZFXaaPo\n28+x9MmSbcL9kwNWJjLsGeBq0QJtHGdOjfK4ZVGq2fMT4P66pf1vSZGxUeHu3z53\nXZNCeWuiH22aNBDNzt7FjwXk6ydeeN/RCUAHcxha8TB4GihhsDQnTLpGoSx00MNj\npX71ZiRnAgMBAAECggEAQRe8joczZNwIaSQMnTYdx01eDWd9ymepRMjVED6zfsYN\nDghN9levGcgV8h7SEJ500X5zym4Kr+oMwh6hLs2TsLaTwlzMyyJq3mdKDqhPnCZf\n6BG+z0KnnO1If680aTuMEUmMQXMlcpaM0BGWjHH4Ro4TXyRYTFLy6BsBYAXWe/vm\nBPMSx+pTBxIHts+P3j4e+IYSlG+7TCZdqzXCvgu5VlFIhS8sBu3o9ZN2vfGbIOZ/\ntcNQC6ovxqj6O+eFmEC5+KSo3ppDq5D0iP5tTWl14N2MaGeYm5Q16GpHt6OI7d21\nILO5m598TG2C9R7AkXrs51tuwAyh7JFQS9E+/xyV4QKBgQD2aYhFmw35Vdf9iEHK\n6chz7lEH1PD2BNttDPjKNYudqIKnrV7o0Ggcd86O+MKmwmPxeAybku3gGIdyttrT\n9MDgjGL45MXfJrWjOKlGR5lYzhK3RgYkp+ehJsSp1CUhXr47pW5oUDmCMvDki1Oe\n68l0GdlC77TbTS/vNRSKNMf7MQKBgQC8cSpkFDQP7R1Nav8qBY4liMJW9Lzzy6nl\nd4YsqZxCvR7ga919pjwBJbvf5AQuE2SboIyINyFOqmb0hDveCZsdi9kYGBYJyyYn\no0qSwN9oCsCJjJhokgvBA9UJQ/6mpMH6TCQj7Wtf4rBPjbXw5Xy0xdYPRoP5twLn\nCzpsfg0DFwKBgCUYWgVwhDgG7k8ilhUAAMdDFzvAmM3QiV/vVfzK9suzNIgdl24h\nAatXdeccF+GW3gjZ87vv8JON3cYtNOA3tlmXiMbDWe5wG2QJAaKs4K73xuWESyR1\nim8+MNkIMNbHNogwLWDSwvWQyab+OoZwJJGv2n8zKtzgz9iI+yCbNYfhAoGBAKYR\npSYll+whLx23GcBSvP7fE0XG0W6ZIdUUDK73mrpGKRvmc3/0LBVmx7d8HyLr/FIa\nnz68NyI4khsTHh+Dn6vePyg4sdNXsPxlr6a9SyVJtHyD5xzg+HLVib1sqtL5h+mp\niIARD/ukr3SskpcF52z4nLlBj7VWT7yF7KsIOzdpAoGBAL7pslkiwnqMilz7UW/X\nEF1JU1szlWv9ld+HAzYT09hNMZMNhQkAOmjPdU5+uEtzmYabrh7PxZd5EmOUd1WZ\nDoCPmkOCN6QFdv+8JFHRR48GMnpxYiVuoB+vSdyzI8JUSC+BP5zG/TvAcXNxDdgo\nk3TudOECIvZKegs/alcNTupe\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-348404.iam.gserviceaccount.com",
  "client_id": "108884113615989372542",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-348404.iam.gserviceaccount.com"
}
''';

  static const _spreadsheetID = '1uw3wvR8qVXXeaAnbMJIZCOzjspckLtcZ7jWhsRfEHko';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetID);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'Users');

      final firstRow = UserFields.getFields();
      _userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      // print('Init Error: $e');
    }
  }

  static Future<Worksheet?> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title);
    }
  }

  static Future<int> getRowCount() async {
    if (_userSheet == null) return 0;
    final lastRow = await _userSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }

  static Future<User?> getById(int id) async {
    if (_userSheet == null) return null;

    final json = await _userSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : User.fromJson(json);
  }

  /*static Future<User?> getAllId() async {
    if (_userSheet == null) return null;

    final json = await _userSheet!.values.map.allRows();
    return json == null ? null : User.fromJson(json);
  }*/

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_userSheet == null) return;
    _userSheet!.values.map.appendRows(rowList);
  }
}
