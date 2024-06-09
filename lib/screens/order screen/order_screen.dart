import 'package:flutter/material.dart';
import 'package:muslimahbakery/transaksi/transaction.dart'; // Import Transaction
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
                subtitle: Text('Total: Rp${transaction.total.toStringAsFixed(0)}'),
                trailing: ElevatedButton( // Mengubah trailing menjadi tombol "Pesanan Selesai"
                  onPressed: () {
                    _markOrderAsCompleted(transaction, transactionProvider);
                  },
                  child: Text('Pesanan Selesai'),
                ),
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

// Fungsi untuk menandai pesanan sebagai selesai dan menghapusnya
void _markOrderAsCompleted(Transaction transaction, TransactionProvider transactionProvider) {
  // Temukan indeks pesanan yang sesuai dalam daftar
  final index = transactionProvider.transactions.indexWhere((t) => t.orderId == transaction.orderId);
  
  // Periksa apakah pesanan ditemukan
  if (index != -1) {
    // Hapus pesanan dari daftar
    transactionProvider.transactions.removeAt(index);
    
    // Panggil notifyListeners untuk memberitahu widget bahwa ada perubahan dalam data
    transactionProvider.notifyListeners();
  }
}
}
