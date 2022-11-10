import 'dart:convert';

import 'package:Banking_App/my_app.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init('bank');
  await storeInitialData();
  runApp(const MyApp());
}

Future<void> storeInitialData() async {
  GetStorage store = GetStorage('bank');
  const List<Map<String, dynamic>> customers = [
    {
      'name': "Zaid Ahmad",
      'accNo': "2647865745",
      'balance': 33000,
    },
    {
      'name': "Nawar Ali",
      'accNo': "4867094587",
      'balance': 180,
    },
    {
      'name': "Adnan Asaad",
      'accNo': "4679868987",
      'balance': 22000,
    },
    {
      'name': "Azzam Mohamad",
      'accNo': "2376908734",
      'balance': 18000,
    },
    {
      'name': "Riad Haider",
      'accNo': "1198674657",
      'balance': 8000,
    },
    {
      'name': "Barnabas Zakaryia ",
      'accNo': "3679856704",
      'balance': 20000,
    },
    {
      'name': "Eeiman Mirzaey",
      'accNo': "5890347812",
      'balance': 10000,
    },
    {
      'name': "Mahmoud Hmidan",
      'accNo': "3557808997",
      'balance': 25000,
    },
    {
      'name': "Kheder Ibrahim",
      'accNo': "6589380887",
      'balance': 15000,
    },
    {
      'name': "Ankit Sihar",
      'accNo': "3579788990",
      'balance': 21000,
    },
  ];
  final List<String> dataToStore =
      customers.map((user) => jsonEncode(user)).toList();
  int count = 0;
  for (String element in dataToStore) {
    await store.writeIfNull('c${count++}', element);
  }
}
