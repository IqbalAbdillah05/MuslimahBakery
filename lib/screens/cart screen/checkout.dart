import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';

class CheckoutScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cart;
  final VoidCallback onTransactionSuccess;

  const CheckoutScreen({
    Key? key,
    required this.cart,
    required this.onTransactionSuccess,
  }) : super(key: key);

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
                  widget.cart.clear();  // Clear the cart
                });
              },
              onTransactionSuccess: widget.onTransactionSuccess,
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.amber,
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
                    backgroundColor: Colors.amber,
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

class TransactionScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cart;
  final String namaPenerima;
  final String noTelp;
  final String alamat;
  final String catatan;
  final int orderId;
  final VoidCallback onOrderPlaced;
  final VoidCallback onTransactionSuccess;

  const TransactionScreen({
    Key? key,
    required this.cart,
    required this.namaPenerima,
    required this.noTelp,
    required this.alamat,
    required this.catatan,
    required this.orderId,
    required this.onOrderPlaced,
    required this.onTransactionSuccess,
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
    Future.delayed(Duration(seconds: 2), () {
      final int orderId = widget.orderId;
      widget.onOrderPlaced();
      widget.onTransactionSuccess();  // Call this to indicate transaction success
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Order Placed"),
            content: Text("Your order has been successfully placed with Order ID: $orderId"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    });
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
                "Total: Rp${calculateSubtotal().toStringAsFixed(2)}",
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
                    'Tambah Pesanan',
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

void main() {
  runApp(MaterialApp(
    home: CheckoutScreen(
      cart: [],
      onTransactionSuccess: () {},
    ),
  ));
}
