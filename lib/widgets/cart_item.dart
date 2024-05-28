import 'dart:js_interop';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:muslimahbakery/models/cart_model.dart';
import 'package:muslimahbakery/provider/cart_provider.dart';
import 'package:provider/provider.dart';


class CartItem extends StatefulWidget {
  final CartModel cartItem;
  const CartItem({super.key, required this.cartItem});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: size.width * 0.30,
            height: size.height * 0.13,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
            child: Image.asset(
              widget.cartItem.product.image,
              width: 70,
              height: 70,
              fit: BoxFit.contain,
            ),
            ),
          ),
          SizedBox(
            width: size.width * 0.45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                widget.cartItem.product.name,
                style: GoogleFonts.poppins(
                  fontSize: size.width * 0.035,
                  fontWeight: FontWeight.w500,
                ),
                ),
                SizedBox(height: size.height * 0.005),
                  Text(
                "\$ ${widget.cartItem.product.price}",
                style: GoogleFonts.poppins(
                  fontSize: size.width * 0.035,
                  color: Colors.black.withOpacity(0.8),
                ),
                ),
                SizedBox(height: size.height * 0.030),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context
                        .read<CartProvider>()
                        .incrementQty(widget.cartItem.id);
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(Iconsax.add,
                        color: Colors.black,
                        size: 14,
                        ),
                      ),
                    ),
                    SizedBox(width: 13),
                    Text(
                      widget.cartItem.quantity.toString(),
                      style: GoogleFonts.poppins(),
                    ),
                    SizedBox(width: 13),
                    GestureDetector(
                      onTap: () {
                        context
                        .read<CartProvider>()
                        .decrimentQty(widget.cartItem.id);
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(Iconsax.minus,
                        color: Colors.black,
                        size: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<CartProvider>().removeItem(widget.cartItem.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Color.fromARGB(255, 247, 247, 247),
                  content: Text(
                    "Item Removed!",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              );
            },
            child: CircleAvatar(
              backgroundColor: Colors.redAccent.withOpacity(0.07),
              radius: 18,
              child: Icon(CupertinoIcons.delete_solid,
              color: Colors.redAccent,
              size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}