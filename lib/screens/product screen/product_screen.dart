import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslimahbakery/models/product_model.dart';
import 'package:muslimahbakery/provider/cart_provider.dart';
import 'package:muslimahbakery/provider/product_provider.dart';
import 'package:provider/provider.dart';


class ProductScreen extends StatefulWidget {
  final ProductModel product;
  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Color selectedColor = Colors.redAccent;
  int selectedSize = 6;
  
  String formatCurrency(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
  }
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  widget.product.isAvailable
                      ? GestureDetector(
                          onTap: () {
                            // add or remove form favorite
                            productProvider.toggleFavorite(widget.product);
                          },
                          child: Icon(
                            widget.product.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: size.width * 0.07,
                            color: widget.product.isFavorite
                                ? Colors.redAccent
                                : Colors.black,
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    widget.product.image,
                    height: size.height / 3,
                  ),
                ),
                SizedBox(height: size.height * 0.015),
                Text(
                  "Deskripsi",
                  style: GoogleFonts.poppins(
                    fontSize: size.height * 0.023,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Text(
                  widget.product.desc,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.037,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: size.height * 0.08,
          margin: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    "Harga:",
                  style: GoogleFonts.poppins(
                    color: Colors.black54,
                    fontSize: size.width * 0.04,
                  ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    "Rp ${formatCurrency(widget.product.price)}",
                  style: GoogleFonts.poppins(
                    fontSize: size.width * 0.055,
                    fontWeight: FontWeight.w600,
                  ),
                  ),
                ],
              ),
             widget.product.isAvailable 
             ? Container(
                width: size.width / 2,
                height: size.height * 0.06,
                child: ElevatedButton(
                  onPressed: () {
                    context
                    .read<CartProvider>()
                    .addToCart(widget.product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("Item Added",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      ),
                    )
                  );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: Text("Tambah Keranjang",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: size.height * 0.02,
                      fontWeight: FontWeight.w500,
                    ),
                    ),
                  ),
                ),
              ) 
              : Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.redAccent,
                          radius: 4,
                        ),
                        SizedBox(width: size.width * 0.20),
                        Text(
                          "Habis",
                          style: GoogleFonts.poppins(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w600,
                            fontSize: size.width * 0.031,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
