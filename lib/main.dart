import 'package:flutter/material.dart';
import 'package:muslimahbakery/provider/cart_provider.dart';
import 'package:muslimahbakery/provider/product_provider.dart';
import 'package:muslimahbakery/screens/login%20screen/login_screen.dart';
import 'package:muslimahbakery/themes/theme.dart';
import 'package:muslimahbakery/transaksi/transaction_provider.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> ProductProvider()),
      ChangeNotifierProvider(create: (_)=> CartProvider()),
      ChangeNotifierProvider(create: (_) => TransactionProvider()),
    ],
    child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  //const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Shopping App",
      theme: Themes.light,
      themeMode: ThemeMode.light,
      //home: MainScreen(),
      home: LoginPage(),
    );
  }
}