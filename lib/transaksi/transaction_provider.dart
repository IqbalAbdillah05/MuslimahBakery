import 'package:flutter/foundation.dart';
import 'transaction.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }

  void markOrderAsCompleted(Transaction transaction) {
    // Temukan indeks pesanan yang sesuai dalam daftar
    final index = _transactions.indexWhere((t) => t.orderId == transaction.orderId);
    
    // Periksa apakah pesanan ditemukan
    if (index != -1) {
      // Tandai pesanan sebagai selesai
      _transactions[index].status = 'Selesai';
      
      // Panggil notifyListeners untuk memberitahu widget bahwa ada perubahan dalam data
      notifyListeners();
    }
  }
}
