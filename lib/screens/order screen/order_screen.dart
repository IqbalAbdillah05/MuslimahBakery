import 'package:flutter/material.dart';
import 'package:muslimahbakery/transaksi/transaction_provider.dart';
import 'package:provider/provider.dart';


class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, transactionProvider, child) {
          final transactions = transactionProvider.transactions;

          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return ListTile(
                title: Text('Order ID: ${transaction.orderId}'),
                subtitle: Text('Total: Rp${transaction.total.toStringAsFixed(2)}'),
                trailing: transaction.proofOfPayment != null
                    ? Image.memory(transaction.proofOfPayment!, width: 50, height: 50)
                    : null,
                onTap: () {
                  // Handle tap if needed
                },
              );
            },
          );
        },
      ),
    );
  }
}
