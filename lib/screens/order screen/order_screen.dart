import 'package:flutter/material.dart';

enum OrderStatus { processed, shipped, unpaid }

class Order {
  final String id;
  final String itemName;
  final double price;
  final OrderStatus status;

  Order({
    required this.id,
    required this.itemName,
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
    Order(id: '1', itemName: 'Item 1', price: 50.0, status: OrderStatus.processed),
    Order(id: '2', itemName: 'Item 2', price: 30.0, status: OrderStatus.shipped),
    Order(id: '3', itemName: 'Item 3', price: 20.0, status: OrderStatus.unpaid),
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
            title: Text('Item: ${orders[index].itemName}'),
            subtitle: Text('Price: \$${orders[index].price.toString()}'),
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
        statusText = 'Processed';
        break;
      case OrderStatus.shipped:
        statusColor = Colors.blue;
        statusText = 'Shipped';
        break;
      case OrderStatus.unpaid:
        statusColor = Colors.red;
        statusText = 'Unpaid';
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