import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_provider/provider/cart_provider.dart';
import 'package:shopping_provider/provider/product_provider.dart';
import 'package:shopping_provider/screens/login%20screen/login_screen.dart';
//import 'package:shopping_provider/screens/login%20screen/login_screen.dart';
//import 'package:shopping_provider/screens/main_screen.dart';
import 'package:shopping_provider/themes/theme.dart';


void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> ProductProvider()),
      ChangeNotifierProvider(create: (_)=> CartProvider()),
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