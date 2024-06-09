import 'dart:typed_data';

class Transaction {
  final int orderId;
  final String name;
  final String phone;
  final String address;
  final String note;
  final List<Map<String, dynamic>> cart;
  final double total;
  final Uint8List? proofOfPayment;
  String status;

  Transaction({
    required this.orderId,
    required this.name,
    required this.phone,
    required this.address,
    required this.note,
    required this.cart,
    required this.total,
    this.proofOfPayment,
    required this.status,
  });
}
