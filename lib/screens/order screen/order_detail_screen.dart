import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslimahbakery/provider/cart_provider.dart';
import 'package:provider/provider.dart';


class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details', style: GoogleFonts.poppins()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Items", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: cartProvider.shoppingCart.length,
                itemBuilder: (context, index) {
                  final cartItem = cartProvider.shoppingCart[index];
                  return ListTile(
                    leading: Image.asset(cartItem.product.image, width: 50, height: 50),
                    title: Text(cartItem.product.name, style: GoogleFonts.poppins()),
                    subtitle: Text("Quantity: ${cartItem.quantity}", style: GoogleFonts.poppins()),
                    trailing: Text("\$${cartItem.product.price * cartItem.quantity}", style: GoogleFonts.poppins()),
                  );
                },
              ),
            ),
            const Divider(),
            Text("Order Summary", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Sub Total", style: GoogleFonts.poppins()),
                Text("\$${cartProvider.cartSubTotal}", style: GoogleFonts.poppins()),
              ],
            ),
  
            SizedBox(height: size.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                Text("\$${cartProvider.cartTotal}", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}