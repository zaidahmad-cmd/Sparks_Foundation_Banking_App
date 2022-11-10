import 'package:Banking_App/Pages/transaction.dart';
import 'package:Banking_App/data.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class BankPage extends StatefulWidget {
  const BankPage({Key? key}) : super(key: key);

  @override
  State<BankPage> createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  final GetStorage store = GetStorage('bank');
  late List<BankData> objList;

  @override
  void initState() {
    objList = getDataAndStore();
    print(objList);

    super.initState();
  }

  List<BankData> getDataAndStore() {
    Iterable keys = store.getKeys();
    return keys.map((e) => BankData.fromString(store.read(e))).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("Select Account")),
      ),
      body: SafeArea(
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: ListView.builder(
              itemCount: objList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TransactionPage(
                          index: index,
                        ),
                      ),
                    );
                    setState(() {
                      objList = getDataAndStore();
                    });
                  },
                  child: UserList(
                    name: objList[index].name,
                    accNo: objList[index].accNo,
                    balance: objList[index].balance,
                  ),
                );
              },
            )),
      ),
    );
  }
}

class UserList extends StatelessWidget {
  const UserList(
      {Key? key,
      required this.name,
      required this.accNo,
      required this.balance})
      : super(key: key);
  final String name, accNo;
  final num balance;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.cyan,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: const Icon(
              Icons.person_rounded,
              color: Colors.white,
              size: 100,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.indigoAccent,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Acc No. $accNo"),
                    Text("Bal: $balance"),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
