import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopping_provider/provider/product_provider.dart';
import 'package:shopping_provider/screens/login%20screen/login_screen.dart';
import 'package:shopping_provider/screens/main_screen.dart';
import 'package:shopping_provider/widgets/category_header.dart';
import 'package:shopping_provider/widgets/product.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
void _logout() {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context)=> LoginPage()),
  );
}


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.005),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Belanja Sekarang",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: size.width * 0.050,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        "Muslimah Bakery",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: size.width * 0.040,
                        ),
                      ),
                    ],
                  ),


                ],
              ),
              SizedBox(height: size.height * 0.025),
              SizedBox(
                width: size.width,
                child: TextFormField(
                  decoration: InputDecoration(

                    focusColor: Colors.black38,
                    isCollapsed: false,
                    hintText: "Search products",
                    prefixIcon: Icon(Icons.search),
                    hintStyle: GoogleFonts.poppins(
                      fontSize: size.width * 0.040,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.01,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.black26, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(color: Colors.black26, width: 1),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.025),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset('assets/f6.jpg',
                height: size.height * 0.2,
                width: size.width * 0.999,
                fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: size.height * 0.030),
              Column(
                children: [
                  CategoryHeader(
                    title: "Donat", 
                    count: '${(Provider.of<ProductProvider>(context).shirts.length.toDouble())}',
                   // count: 'Rp ${formatCurrency(.shirts.length)}',
                    ),
                    SizedBox(height: size.height * 0.020),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Consumer<ProductProvider>(
                        builder: (context, value, child) {
                          return Row(
                            children: value.shirts
                            .map((product)=> Product(product: product))
                            .toList(),
                          );
                        },
                        ),
                    ),
                ],
              ),
              SizedBox(height: size.height * 0.020),
              Column(
                children: [
                  CategoryHeader(
                    title: "Kue", 
                    count: '${Provider.of<ProductProvider>(context).shoes.length}',
                    //count: 'Rp ${formatCurrency(widget.price)}',
                    ),
                    SizedBox(height: size.height * 0.020),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Consumer<ProductProvider>(
                        builder: (context, value, child) {
                          return Row(
                            children: value.shoes
                            .map((product)=> Product(product: product))
                            .toList(),
                          );
                        },
                        ),
                    ),
                ],
              ),
              SizedBox(height: size.height * 0.020),
              Column(
                children: [
                  CategoryHeader(
                    title: "Roti", 
                    count: '${Provider.of<ProductProvider>(context).pants.length}',
                    ),
                    SizedBox(height: size.height * 0.020),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Consumer<ProductProvider>(
                        builder: (context, value, child) {
                          return Row(
                            children: value.pants
                            .map((product)=> Product(product: product))
                            .toList(),
                          );
                        },
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
