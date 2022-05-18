import 'dart:convert';

import 'package:flutter/src/material/data_table.dart';

class UserFields {
  static const String id = 'id';
  static const String name = 'name';
  static const String email = 'email';
  //static final String isBeginner = 'isBeginner';

  static List<String> getFields() => [id, name, email];
}

class User {
  final int id;
  final String name;
  final String email;
  //final bool isBeginner;

  const User({
    required this.id,
    required this.name,
    required this.email,
    //required this.isBeginner
  });

  User copy({
    int? id,
    String? name,
    String? email,
    //bool? isBeginner,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        //isBeginner: isBeginner ?? this.isBeginner
      );

  static User fromJson(Map<String, dynamic> json) => User(
        id: jsonDecode(json[UserFields.id]),
        name: json[UserFields.name],
        email: json[UserFields.email],
      );

  Map<String, dynamic> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.email: email,
        //UserFields.isBeginner: isBeginner
      };

  map(DataRow Function(dynamic e) param0) {}
}
