import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  double _totalprice = 0.0;
  double get totalprice => _totalprice;

  void _setprefsitem() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt('cart_item', _counter);
    prefs.setDouble('total_price', _totalprice);
    notifyListeners();
  }

  void _getprefsitem() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _counter = prefs.getInt('cart_item') ?? 0;
    _totalprice = prefs.getDouble('total_price') ?? 0;
    notifyListeners();
  }

  void addcounter() {
    _counter++;
    _setprefsitem();
    notifyListeners();
  }

  void removecounter() {
    _counter--;
    _setprefsitem();
    notifyListeners();
  }

  int getcounter() {
    _getprefsitem();
    return _counter;
  }

  void addtotalprice(double productprice) {
    _totalprice = _totalprice + productprice;
    _setprefsitem();
    notifyListeners();
  }

  void removetotalprice(int productprice) {
    _totalprice = _totalprice - productprice;
    _setprefsitem();
    notifyListeners();
  }

  double gettotalprice() {
    _getprefsitem();
    return _totalprice;
  }
}
