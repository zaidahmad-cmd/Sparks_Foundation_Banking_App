import 'dart:convert';

class BankData {
  late String name;
  late String accNo;
  late num balance;

  fromJson(Map<String, dynamic> obj) {
    name = obj['name'];
    accNo = obj['accNo'];
    balance = obj['balance'];
  }

  BankData.fromString(string) {
    Map<String, dynamic> obj = jsonDecode(string);
    fromJson(obj);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'accNo': accNo,
      'balance': balance,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
