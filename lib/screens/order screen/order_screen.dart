import 'package:flutter/material.dart';

enum OrderStatus { processed, shipped, unpaid }

class Order {
  final String id;
  final String Nama;
  final double price;
  final OrderStatus status;

  Order({
    required this.id,
    required this.Nama,
    required this.price,
    required this.status,
  });
}

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Order> orders = [
    Order(id: '1', Nama: 'Iqbal', price: 125000, status: OrderStatus.processed),
    //Order(id: '2', Nama: 'Item 2', price: 30.0, status: OrderStatus.shipped),
    //Order(id: '3', Nama: 'Item 3', price: 20.0, status: OrderStatus.unpaid),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Nama: ${orders[index].Nama}'),
            subtitle: Text('Price: \Rp${orders[index].price.toString()}'),
            trailing: _buildStatusIndicator(orders[index].status),
          );
        },
      ),
    );
  }

  Widget _buildStatusIndicator(OrderStatus status) {
    Color statusColor;
    String statusText;

    switch (status) {
      case OrderStatus.processed:
        statusColor = Colors.green;
        statusText = 'Proses';
        break;
      case OrderStatus.shipped:
        statusColor = Colors.blue;
        statusText = 'Dikirim';
        break;
      case OrderStatus.unpaid:
        statusColor = Colors.red;
        statusText = 'Belum Bayar';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        statusText,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: OrderScreen(),
  ));
}