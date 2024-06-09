import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muslimahbakery/provider/cart_provider.dart';
import 'package:muslimahbakery/screens/cart%20screen/cart_screen.dart';
import 'package:muslimahbakery/screens/favorite%20screen/favorite_screen.dart';
import 'package:muslimahbakery/screens/home%20screen/home_screen.dart';
import 'package:muslimahbakery/screens/order%20screen/order_screen.dart';
//import 'package:muslimahbakery/screens/order%20screen/order_screen.dart';
import 'package:muslimahbakery/screens/profile%20screen/profile_screen.dart';
import 'package:provider/provider.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  Size size = Size.zero;
  int currentIndex = 0;

  final _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  List<Widget> _buildScreens = [
    HomeScreen(),
    FavortieScreen(),
    CartScreen(),
    OrdersScreen(), 
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildScreens[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black26,
              width: 0.5,
            ),
          ),
        ),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            bottomNavigationBarTheme: Theme.of(context).bottomNavigationBarTheme,
          ),
          child: BottomNavigationBar(
            items: [
              getIcon(0, "Home", Icons.home),
              getIcon(1, "Favourite", CupertinoIcons.heart),
              BottomNavigationBarItem(
                icon: Container(
                  padding: EdgeInsets.only(
                    bottom: size.height * 0.005,
                  ),
                  margin: EdgeInsets.only(bottom: 2),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Icon(
                            CupertinoIcons.cart,
                            color: Colors.black26,
                            size: 22,
                          ),
                        ),
                      ),
                      Positioned(
                        top: -5,
                        right: -3,
                        child: context.watch<CartProvider>().shoppingCart.isNotEmpty ?
                        CircleAvatar(
                          backgroundColor: Colors.redAccent,
                          radius: 10,
                          child: Text(
                            context.watch<CartProvider>().shoppingCart.length.toString(),

                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ) : SizedBox(),
                      ),
                    ],
                  ),
                ),
                label: "Cart",
              ),
              getIcon(3, "Orders", CupertinoIcons.list_bullet_indent),
              getIcon(4, "Profile", CupertinoIcons.profile_circled),
            ],
            currentIndex: currentIndex,
            onTap: (int tab){
              setState(() {
                currentIndex = tab;
                
              });
            },
          ),
        ),
      ),
    );
  }

  getIcon(int i, String label, IconData icon){
    return BottomNavigationBarItem(
      icon: Container(
        padding: EdgeInsets.only(
          bottom: size.height * 0.001,
        ),
        child: Icon(icon),
      ),
      label: label,
    );
  }
}