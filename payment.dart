import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dana_kedua/providers/saldoProvider.dart';

class PaymentScreen extends StatelessWidget {
  final String category;

  PaymentScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    final balanceProvider = Provider.of<MySaldoProviders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text(category),
              subtitle: Text("Rp 50000.0"),
              trailing: Checkbox(
                value: false,
                onChanged: (value) {},
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Logic to deduct the balance and proceed with the payment
                balanceProvider.decreaseBalance(50000.0);
                Navigator.of(context).pop();
              },
              child: Text("Bayar"),
            ),
          ],
        ),
      ),
    );
  }
}
