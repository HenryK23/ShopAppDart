import 'package:flutter/foundation.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus(String? id) async {
    bool favourite;

    if (isFavorite) {
      favourite = false;
    } else {
      favourite = true;
    }

    final url = Uri.parse(
        "https://flutter-test-a59d2-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json");

    try {
      final response =
          await http.patch(url, body: json.encode({"isFavourite": favourite}));

      if (response.statusCode >= 400) {
        throw Exception();
      }
    } catch (error) {
      print(error);
      if (favourite) {
        favourite = false;
      } else {
        favourite = true;
      }
    } finally {
      isFavorite = favourite;
      notifyListeners();
    }
  }
}
