import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:muslimahbakery/screens/order%20screen/order_screen.dart';
import 'package:muslimahbakery/transaksi/transaction.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:provider/provider.dart';
import 'transaction_provider.dart';
//import 'transaction.dart';


class TransactionScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cart;
  final String namaPenerima;
  final String noTelp;
  final String alamat;
  final String catatan;
  final int orderId;
  final VoidCallback onOrderPlaced;

  const TransactionScreen({
    Key? key,
    required this.cart,
    required this.namaPenerima,
    required this.noTelp,
    required this.alamat,
    required this.catatan,
    required this.orderId,
    required this.onOrderPlaced,
  }) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final List<String> _paymentMethods = ['Bank Transfer'];
  String? _selectedPaymentMethod;
  File? _proofOfPayment;
  Uint8List? _webProofOfPayment;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      if (kIsWeb) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _webProofOfPayment = bytes;
        });
      } else {
        setState(() {
          _proofOfPayment = File(pickedFile.path);
        });
      }
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

  void _placeOrder(BuildContext context) {
    // Validate payment method selection and proof of payment if required
    if (_selectedPaymentMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Silakan pilih metode pembayaran")),
      );
      return;
    }
    if (_selectedPaymentMethod == 'Bank Transfer' && _proofOfPayment == null && _webProofOfPayment == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Silakan upload bukti pembayaran")),
      );
      return;
    }

    final transaction = Transaction(
      orderId: widget.orderId,
      name: widget.namaPenerima,
      phone: widget.noTelp,
      address: widget.alamat,
      note: widget.catatan,
      cart: widget.cart,
      total: calculateSubtotal(),
      proofOfPayment: kIsWeb ? _webProofOfPayment : _proofOfPayment?.readAsBytesSync(), status: '',
    );

    // Add transaction to provider
    Provider.of<TransactionProvider>(context, listen: false).addTransaction(transaction);

    // Notify user
    widget.onOrderPlaced();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Pesanan Berhasil"),
          content: Text("Pesanan Anda dengan ID: ${widget.orderId} berhasil dilakukan."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => OrdersScreen()),
                );
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Details'),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Detail Pemesanan",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Nama Kue')),
                    DataColumn(label: Text('Qty')),
                    DataColumn(label: Text('Total')),
                  ],
                  rows: widget.cart.map((item) {
                    final namaKue = item['name'];
                    final qty = item['qty'];
                    final harga = item['price'];
                    final total = qty * harga;
                    return DataRow(cells: [
                      DataCell(Text(namaKue)),
                      DataCell(Text(qty.toString())),
                      DataCell(Text("Rp$total")),
                    ]);
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Nama Penerima: ${widget.namaPenerima}",
                style: GoogleFonts.poppins(),
              ),
              SizedBox(height: 5),
              Text(
                "No. Telp: ${widget.noTelp}",
                style: GoogleFonts.poppins(),
              ),
              SizedBox(height: 5),
              Text(
                "Alamat: ${widget.alamat}",
                style: GoogleFonts.poppins(),
              ),
              SizedBox(height: 5),
              Text(
                "Catatan: ${widget.catatan}",
                style: GoogleFonts.poppins(),
              ),
              SizedBox(height: 20),
              Text(
                "Total: Rp${calculateSubtotal().toStringAsFixed(0)}",
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedPaymentMethod,
                items: _paymentMethods.map((method) {
                  return DropdownMenuItem(
                    value: method,
                    child: Text(method),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Pilih Metode Pembayaran',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              _selectedPaymentMethod != null && _selectedPaymentMethod == 'Bank Transfer'
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Instruksi Pembayaran",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Silakan transfer ke rekening berikut:",
                          style: GoogleFonts.poppins(),
                        ),
                        Text(
                          "Bank BRI: 0021 5678 9012 403 a/n Diana Sarifah",
                          style: GoogleFonts.poppins(),
                        ),
                        SizedBox(height: 10),
                        TextButton(
                          onPressed: _pickImage,
                          child: Text("Upload Bukti Pembayaran"),
                        ),
                        if (_proofOfPayment != null || _webProofOfPayment != null)
                          Column(
                            children: [
                              SizedBox(height: 10),
                              if (kIsWeb && _webProofOfPayment != null)
                                Image.memory(
                                  _webProofOfPayment!,
                                  width: 100,
                                  height: 100,
                                ),
                              if (!kIsWeb && _proofOfPayment != null)
                                Image.file(
                                  _proofOfPayment!,
                                  width: 100,
                                  height: 100,
                                ),
                            ],
                          ),
                      ],
                    )
                  : Container(),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () => _placeOrder(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Place Order',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
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
