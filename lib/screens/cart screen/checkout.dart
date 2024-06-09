import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muslimahbakery/transaksi/transaction.dart';
import 'package:muslimahbakery/transaksi/transaction_provider.dart';
import 'package:muslimahbakery/transaksi/transaction_screen.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cart;

  const CheckoutScreen({Key? key, required this.cart, required Null Function() onTransactionSuccess}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  void _processPayment(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text;
      final String phone = _phoneController.text;
      final String address = _addressController.text;
      final String note = _noteController.text;

      // Simulate inserting order data into the database
      Future.delayed(Duration(seconds: 2), () {
        // Example response from backend
        final int orderId = 1234;
        final double total = calculateSubtotal();

        // Add transaction to provider
        final transaction = Transaction(
          orderId: orderId,
          name: name,
          phone: phone,
          address: address,
          note: note,
          cart: widget.cart,
          total: total, status: '',
        );
        Provider.of<TransactionProvider>(context, listen: false).addTransaction(transaction);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionScreen(
              cart: widget.cart,
              namaPenerima: name,
              noTelp: phone,
              alamat: address,
              catatan: note,
              orderId: orderId,
              onOrderPlaced: () {
                setState(() {
                  widget.cart.clear(); // Clear the cart
                });
              },
            ),
          ),
        );
      });
    }
  }

  double calculateSubtotal() {
    double subtotal = 0;
    widget.cart.forEach((item) {
      final qty = item['qty'];
      final harga = item['price'];
      subtotal += qty * harga;
    });
    return subtotal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Detail Penerima',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nama Penerima',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Penerima tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'No. Telepon',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'No. Telepon tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Alamat Pengiriman',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat Pengiriman tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _noteController,
                decoration: InputDecoration(
                  labelText: 'Catatan',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _processPayment(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Lanjutkan ke Pembayaran',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}