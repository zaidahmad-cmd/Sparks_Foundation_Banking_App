import 'dart:convert';

import 'package:Banking_App/data.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  GetStorage store = GetStorage('bank');

  late BankData clientData;

  num transferAmount = 0;

  TextEditingController transferAmountController = TextEditingController();

  late List<BankData> alluser;

  @override
  void initState() {
    Iterable keys = store.getKeys();
    alluser = keys.map((k) => BankData.fromString(store.read(k))).toList();

    clientData = alluser[widget.index];

    transferAmountController.text = "0";
    print(clientData);
    super.initState();
  }

  Future<int?> showBottomSheet() async {
    int selectedPerson = 0;
    bool? workSucessful = false;
    workSucessful = await showModalBottomSheet<bool>(
      context: context,
      isDismissible: false,
      builder: (context) {
        return Stack(
          alignment: Alignment.topRight,
          children: [
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: alluser.length,
              itemBuilder: (context, index) {
                if (index == widget.index) {
                  return const SizedBox();
                }
                return ListTile(
                  enabled: index != widget.index,
                  onTap: () {
                    selectedPerson = index;
                    Navigator.pop(context, true);
                  },
                  title: Text(alluser[index].name),
                  dense: true,
                );
              },
            ),
            IconButton(
              splashRadius: 18,
              iconSize: 32,
              padding: const EdgeInsets.all(0),
              onPressed: () {
                Navigator.pop(context, false);
              },
              icon: const Icon(Icons.cancel_outlined),
            ),
          ],
        );
      },
    );

    return workSucessful == null || !workSucessful ? null : selectedPerson;
  }

  void performTransfer() async {
    print("T = $transferAmount");
    int? receiver = await showBottomSheet();
    if (receiver == null) return;

    alluser[receiver].balance += transferAmount;
    store.write('c$receiver', alluser[receiver].toString());
    alluser[widget.index].balance -= transferAmount;
    store.write('c${widget.index}', alluser[widget.index].toString());

    setState(() {});
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            width: 300,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Transfer Sucessful",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.purple,
                    decoration: TextDecoration.none,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "From ${clientData.name.split(" ")[0]}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.indigoAccent,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const Icon(Icons.arrow_right_alt),
                    Text(
                      " To ${alluser[receiver].name.split(" ")[0]}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.green,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Amount"),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.person_rounded,
                    color: Colors.cyanAccent,
                    size: 300,
                  ),
                  Text(
                    clientData.name,
                    style: const TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.w500,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Acc no: ${clientData.accNo}",
                    style: const TextStyle(
                      color: Colors.indigoAccent,
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Balance: ${clientData.balance}",
                    style: const TextStyle(
                      color: Colors.cyan,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Enter The amount to Transfer",
                          ),
                          controller: transferAmountController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (value.isEmpty) {
                              setState(() {
                                transferAmount = 0;
                              });
                              return;
                            }
                            num amnt = num.parse(value);
                            if (amnt <= clientData.balance) {
                              setState(() {
                                transferAmount = amnt;
                              });
                            } else {
                              transferAmountController.text =
                                  clientData.balance.toString();
                              setState(() {
                                transferAmount = clientData.balance;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 5),
                        ElevatedButton(
                            onPressed: performTransfer,
                            child: const Text("Transfer"))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
