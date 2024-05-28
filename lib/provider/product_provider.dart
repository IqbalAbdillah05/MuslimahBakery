import 'package:flutter/material.dart';
import 'package:shopping_provider/models/product_model.dart';



class ProductProvider extends ChangeNotifier {
  final List<ProductModel> _shirts = [
    ProductModel(
      name: "Donat Mesis Cokelat",
      price: 5000,
      image: 'assets/donat1.jpg',
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      isAvailable: true,
    ),
    ProductModel(
      name: "Donat Cokelat Kacang",
      price: 6000,
      image: "assets/donat2.jpg",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      isAvailable: true
      ,
    ),
    ProductModel(
      name: "Donat Gula Halus",
      price: 6000,
      image: "assets/donat3.jpg",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      isAvailable: true
      ,
    ),
    ProductModel(
      name: "Donat Cokelat Keju",
      price: 6000,
      image: "assets/donat4.jpg",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      isAvailable: true
      ,
    ),
        ProductModel(
      name: "Donat Macha",
      price: 7000,
      image: "assets/donat5.jpg",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      isAvailable: true
      ,
    ),
  ];

  final List<ProductModel> _pants = [
    ProductModel(
      name: "Roti Bolen Cokelat",
      price: 12000,
      image: "assets/roti1.jpg",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      isAvailable: true,
    ),
    ProductModel(
      name: "Roti Abon Keju",
      price: 8000,
      image: "assets/roti2.jpg",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      isAvailable: true,
    ),
      ProductModel(
      name: "Roti Pizza Abon",
      price: 8000,
      image: "assets/roti3.jpg",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      isAvailable: true,
    ),
      ProductModel(
      name: "Roti Strawberry",
      price: 8000,
      image: "assets/roti4.jpg",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      isAvailable: true,
    ),
         ProductModel(
      name: "Roti Gulung",
      price: 8000,
      image: "assets/roti5.jpg",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      isAvailable: true,
    ),
  ];

  final List<ProductModel> _shoes = [
    ProductModel(
      name: "Kue Tart Cokelat",
      price: 120000,
      image: "assets/kue1.jpg",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      isAvailable: true,
    ),
    ProductModel(
      name: "Kue Tart 60x90",
      price: 200000,
      image: "assets/kue6.jpg",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      isAvailable: true,
    ),
       ProductModel(
      name: "Kue Tart 50x50",
      price: 150000,
      image: "assets/kue3.jpg",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      isAvailable: true,
    ),
       ProductModel(
      name: "Kue Tart Mini",
      price: 50000,
      image: "assets/kue4.jpg",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
      isAvailable: true,
    ),
       ProductModel(
      name: "Kue Tart 10x30",
      price: 120000,
      image: "assets/kue5.jpg",
      desc:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",

      isAvailable: true,
    ),
  ];

  void toggleFavorite(ProductModel product) {
    product.isFavorite = !product.isFavorite;
    notifyListeners();
  }

  List<ProductModel> get shirts => _shirts;
  List<ProductModel> get pants => _pants;
  List<ProductModel> get shoes => _shoes;
}
