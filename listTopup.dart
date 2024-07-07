import 'package:dana_kedua/screens/history.dart';
import 'package:dana_kedua/screens/pay.dart';
import 'package:dana_kedua/screens/send.dart';
import 'package:dana_kedua/screens/topup/topup.dart';
import 'package:flutter/material.dart';

class MyTopups extends StatelessWidget {
  MyTopups({super.key});

  final Map<IconData, String> nama = {
    Icons.arrow_upward: "Top up",
    Icons.payment: "Pay",
    Icons.send: "Send",
    Icons.history: "History"
  };

  @override
  Widget build(BuildContext context) {
    List<VoidCallback> actions = [
      () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MyTopUps()));
      },
      () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MyPayments()));
      },
      () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MySends()));
      },
      () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const MyHistorys()));
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: nama.entries.map((e) {
        int index = nama.keys.toList().indexOf(e.key);
        return Column(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey[500],
              child: IconButton(
                  onPressed: actions[index],
                  icon: Icon(
                    e.key,
                    color: Colors.white,
                    size: 24,
                  )),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              e.value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            )
          ],
        );
      }).toList(),
    );
  }
}
