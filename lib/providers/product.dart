import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFaforite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFaforite = false,
  });

  void _setFavValue(bool newValue) {
    isFaforite = newValue;
    notifyListeners();
  }

  Future<void> toogleFavoriteStatus() async {
    final oldStatus = isFaforite;
    isFaforite = !isFaforite;
    notifyListeners();
    final url = 'https://shopapp-a1ec4.firebaseio.com/products/$id.json';
    try {
      final response = await http.patch(url,
          body: json.encode({
            'isFavorite': isFaforite,
          }));
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
